#include <stdio.h>
#include <avr/interrupt.h>

#include "keyboard.h"
#include "pins.h"
#include "ps2.h"
#include "timers.h"

volatile kbd_state_t state;

volatile uint8_t kbd_data_in;
volatile uint8_t kbd_data_out;
volatile uint8_t kbd_result;
volatile uint8_t kbd_bits;
volatile uint8_t kbd_parity; 
volatile uint8_t kbd_resend;

static inline uint8_t getBit(void)
{
    return PINC & PC_PS2_DATA;
}

static inline void setBit(uint8_t val)
{
    if (val) {
        PORTC |= PC_PS2_DATA;
    }
    else {
        PORTC &= ~PC_PS2_DATA;
    }
}

static inline void setReceiving(void)
{
    kbd_data_in = kbd_bits = kbd_parity = 0;

    state = PS2_RECEIVING;
}

static inline void setSending(void)
{
    // Pull clock line low for at least 100us
    DDRC  |= PC_PS2_CLOCK;
    PORTC &= ~PC_PS2_CLOCK;
    delayMicroseconds(100);

    // Pull the data line low
    DDRC  |= PC_PS2_DATA;
    PORTC &= ~PC_PS2_DATA;

    // Release the clock line
    DDRC &= ~PC_PS2_CLOCK;

    kbd_bits   = 0;
    kbd_parity = 0;
    kbd_resend = 3;

    state = PS2_SENDING;
}

static inline void setIdle(void)
{
    DDRC &= ~PC_PS2_DATA;
    state = PS2_IDLE;
}

/**
 * Initialize the PS/2 driver.
 */
void ps2Init(void)
{
    setIdle();
}

/**
 * Send a byte out to the specified PS/2 port.
 *
 * Returns the response from the device on completion
 */
uint8_t ps2SendByte(uint8_t port, uint8_t byte)
{
    if (port == 0) {
        while (state != PS2_IDLE) { /* wait */ }

        kbd_data_out = byte;
        kbd_result   = 0;

        setSending();

        while (kbd_result == 0) { /* wait */ }
    }

    return kbd_result;
}

/**
 * This method is called from the PCINT1_vect
 * interrupt handler whenever it sees a pin
 * change on the PS/2 clock line.
 */
void ps2Interrupt()
{
    if (state == PS2_SENDING) {
        ++kbd_bits;

        if (kbd_bits < 9) {
            setBit(kbd_data_out & 1);
            kbd_parity += kbd_data_out & 1;

            kbd_data_out >>= 1;
        }
        else if (kbd_bits == 9) {
            setBit(!(kbd_parity & 1));
        }
        else if (kbd_bits == 10) {
            // stop bit
            setBit(1);
        }
        else if (kbd_bits == 11) {
            // ack bit
            setIdle();
        }
    }
    else if (state == PS2_IDLE) {
        if (!getBit()) {
            setReceiving();
        }
    }
    else if (state == PS2_RECEIVING) {
        ++kbd_bits;

        if (kbd_bits < 9) {
            kbd_data_in >>= 1;

            if (getBit()) {
                kbd_data_in |= 0x80;

                ++kbd_parity;
            }
        }
        else if (kbd_bits == 9)  { // parity
        }
        else { // stop bit
            switch (kbd_data_in) {
                case PS2_ACK:
                case PS2_ERROR:
                    kbd_result = kbd_data_in;
                    setIdle();
                    break;
                case PS2_RESEND:
                    if (--kbd_resend) {
                        setSending();
                    }
                    else {
                        kbd_result = PS2_ERROR;

                        setIdle();
                    }
                    break;
                default:
                    kbd_result = PS2_ERROR;
                    kbdProcessData(kbd_data_in);
                    setIdle();
                    break;
            }
        }
    }
}
