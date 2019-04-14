#include <stdio.h>
#include <avr/interrupt.h>

#include "mpu.h"
#include "pins.h"
#include "ps2.h"
#include "timers.h"

static volatile mpu_state_t state;
static volatile uint8_t packet_buffer[MAX_PACKET];
static volatile uint16_t packet_len, send_pos;
static uint8_t error_packet[2];
static volatile uint8_t portc_last;
static volatile uint8_t busy;

/**
 * Strobe one of the handshake pins on port B. Input is the pin mask.
 */
static inline void strobe(uint8_t pin)
{
    PORTB &= ~pin;
    __asm__("nop\n\t");
    PORTB |= pin;
}

static void protocolError(uint16_t len)
{
    error_packet[0] = len & 0xFF;
    error_packet[1] = (len >> 8) & 0xFF;

    mpuSendResponse(PT_PROTOCOL_ERROR, error_packet, 2);
}

static inline void sendByte(uint8_t data)
{
    PORTD = data;
    strobe(PB_SEND_DATA_RDY);
}

/**
 * Transition to the MPU_IDLE state
 */
static inline void setIdle(void)
{
    DDRD = 0;
    PORTB |= PB_RECV_DATA_ACK;

    state = MPU_IDLE;
}

/**
 * Transition to the MPU_RECEIVING state
 */
static inline void setReceiving(void)
{
    DDRD = 0;
    PORTB |= PB_RECV_DATA_ACK;

    state = MPU_RECEIVING;

    packet_len = 0;
}

/**
 * Transition to the MPU_RECEIVED state
 */
static inline void setReceived(void)
{
    uint16_t len = (packet_buffer[2] << 8) | packet_buffer[1];

    if ((len != (packet_len - 3)) || (packet_buffer[0] < 1)) {
        protocolError(len);
    }
    else if (busy) {
        mpuSendResponse(PT_BUSY, NULL, 0);
    }
    else {
        state = MPU_RECEIVED;
    }
}

/**
 * Transition to the MPU_SENDING state
 */
static inline void setSending(void)
{
    DDRD = 0xFF;

    state = MPU_SENDING;
    send_pos = 1;
    sendByte(packet_buffer[0]);
}

/**
 * Initialize the MPU driver.
 */
void mpuInit(void)
{
    DDRB   =  (DDRB | PB_RECV_DATA_ACK) & ~PB_RECV_DATA_RDY;
    PORTB |=  PB_RECV_DATA_RDY;  // enable pull-up
    DDRC  &= ~PC_DDIR;

    portc_last = PC_PS2_CLOCK;

    busy = 0;

    setIdle();
}

/**
 * Get the next request to process and return its type, or PT_NO_DATA
 * if no request has been received. The length of the packet payload
 * will be placed into *len. The payload data, if any, will be copied
 * to the passed buffer, which must be able to hold MAX_PAYLOAD bytes.
 */
uint8_t mpuGetRequest(uint8_t *buffer, uint16_t *len)
{
    if (state == MPU_RECEIVED) {
        if (packet_len > 3) {
            for (uint16_t i = 3 ; i < packet_len ; ++i) {
                *buffer++ = packet_buffer[i];
            }
        }

        *len = packet_len - 3;

        return packet_buffer[0];
    }
    else {
        return PT_NO_DATA;
    }
}

/**
 * Send a response packet of the specified type and optional payload.
 * If len == 0 the payload pointer can be null; otherwise it must point
 * to a buffer of len bytes.
 */
void mpuSendResponse(uint8_t type, uint8_t *payload, uint16_t len)
{
    packet_len = len + 3;

    packet_buffer[0] = type;
    packet_buffer[1] = len & 0xFF;
    packet_buffer[2] = (len >> 8) & 0xFF;

    if (len) {
        for (uint16_t i = 0 ; i < len ; ++i) {
            packet_buffer[i+3] = *payload++;
        }
    }

    setSending();
}

/**
 * Set or clear the busy flag
 */
void mpuSetBusy(uint8_t val)
{
    busy = val;
}

/**
 * We have two possible pins that can interrupt: DDIR (PC1)
 * and the inbound handshake pin (PB1)
 *
 * DDIR transitions drive the state machine most of the way. In the
 * MPU_IDLE state, DDIR is low, and both sides are set to receive, to
 * minimize the possibility of bus contention.
 *
 * When DDIR transitions high it means the remote side is about to transmit.
 * For this reason any time this happens we immediately reset the state
 * machine to the MPU_RECEIVING state; any in-progress transaction is effectively
 * cancelled.
 *
 * While in the MPU_RECEIVING state a high-to-low transition on PB_RECV_DATA_RDY
 * means a new data byte is ready, so we read the byte, stash it in the
 * packet buffer, and ack the byte by strobing PB_RECV_DATA_ACK.
 *
 * The state machine remains in the MPU_RECEIVING state until DDIR transitions
 * from high to low. At that point it transitions to the MPU_RECEIVED state. This
 * state remains until the main loop takes the received packet, builds a
 * response packet, and calls mpuSendResponse(). At this point the state
 * machine transitions to MPU_SENDING, and sends the first byte by placing it
 * on port D and strobing PB_SEND_DATA_RDY.
 *
 * While in MPU_SENDING high-to-low transitions on PB_SEND_DATA_ACK will cause
 * additional bytes to be sent, until the end of the packet is reached.
 * At that point the state transitions back to MPU_IDLE.
 */

ISR(PCINT1_vect)
{
    uint8_t changed = portc_last ^ PINC;
    portc_last = PINC;

    if (changed & PC_DDIR) {
        if (PINC & PC_DDIR) {
            setReceiving();
        }
        else if (state == MPU_RECEIVING) {
            setReceived();
        }
        else {
            setIdle();
        }
    }

    // Send PS/2 clock interrupts to the PS/2 driver
    if ((changed & PC_PS2_CLOCK) && !(portc_last & PC_PS2_CLOCK)) {
        ps2Interrupt();
    }
}

ISR(PCINT0_vect)
{
    if (PINB & PB_RECV_DATA_RDY) return;

    if (state == MPU_RECEIVING) {
        if (packet_len < MAX_PACKET) {
            packet_buffer[packet_len++] = PIND;
        }

        strobe(PB_RECV_DATA_ACK);
    }
    else if (state == MPU_SENDING) {
        if (send_pos < packet_len) {
            sendByte(packet_buffer[send_pos++]);
        }
        else {
            setIdle();
        }
    }
}
