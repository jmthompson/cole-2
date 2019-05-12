#include <stdio.h>
#include <avr/interrupt.h>

#include "keyboard.h"
#include "sr.h"
#include "pins.h"
#include "ps2.h"
#include "timers.h"

static volatile ps2_port_t ports[PS2_NUM_PORTS];

static inline uint8_t getBit(volatile ps2_port_t *port)
{
    return PIND & port->data_mask;
}

static inline void setBit(volatile ps2_port_t *port, uint8_t val)
{
    if (val) {
        PORTD |= port->data_mask;
    }
    else {
        PORTD &= ~port->data_mask;
    }
}

static inline void setReceiving(volatile ps2_port_t *port)
{
    port->data_in = port->bits = port->parity = 0;

    port->state = PS2_RECEIVING;
}

static inline void setSending(volatile ps2_port_t *port)
{
    // Pull clock line low for at least 100us
    DDRD  |= port->clock_mask;
    PORTD &= ~port->clock_mask;
    delayMicroseconds(100);

    // Pull the data line low
    DDRD  |= port->data_mask;
    PORTD &= ~port->data_mask;

    // Release the clock line
    DDRD &= ~port->clock_mask;

    port->bits   = 0;
    port->parity = 0;
    port->resend = 3;
    port->state  = PS2_SENDING;
}

static inline void setIdle(volatile ps2_port_t *port)
{
    DDRD &= ~port->data_mask;

    port->state = PS2_IDLE;
}

/**
 * Initialize the PS/2 driver.
 */
void ps2Init(void)
{
    ports[0].device     = PS2_KEYBOARD;
    ports[0].clock_mask = PD_KBD_CLK;
    ports[0].data_mask  = PD_KBD_DATA;

    ports[1].device     = PS2_MOUSE;
    ports[1].clock_mask = PD_MOUSE_CLK;
    ports[1].data_mask  = PD_MOUSE_DATA;

    setIdle(&ports[0]);
    setIdle(&ports[1]);

    EICRA = 0x0A;   // Interrupt on INT0 or INT1 falling edge
    EIMSK = 0x03;   // Enable both INTx interrupts
}

/**
 * Send a byte out to the specified PS/2 port.
 *
 * Returns the response from the device on completion
 */
uint8_t ps2SendByte(uint8_t port_num, uint8_t byte)
{
    volatile ps2_port_t *port = &ports[port_num];

    while (port->state != PS2_IDLE) { /* wait */ }

    port->data_out = byte;
    port->result   = 0;

    setSending(port);

    while (port->result == 0) { /* wait */ }

    return port->result;
}

/**
 * Service an interrupt on a PS/2 port. This function will be called
 * whenever a falling edge is detected on the port's clock line.
 */
void serviceInterrupt(volatile ps2_port_t *port)
{
    if (port->state == PS2_SENDING) {
        ++port->bits;

        if (port->bits < 9) {
            setBit(port, port->data_out & 1);
            port->parity += port->data_out & 1;

            port->data_out >>= 1;
        }
        else if (port->bits == 9) {
            setBit(port, !(port->parity & 1));
        }
        else if (port->bits == 10) {
            // stop bit
            setBit(port, 1);
        }
        else if (port->bits == 11) {
            // ack bit
            setIdle(port);
        }
    }
    else if (port->state == PS2_IDLE) {
        if (!getBit(port)) {
            setReceiving(port);
        }
    }
    else if (port->state == PS2_RECEIVING) {
        ++port->bits;

        if (port->bits < 9) {
            port->data_in >>= 1;

            if (getBit(port)) {
                port->data_in |= 0x80;

                ++port->parity;
            }
        }
        else if (port->bits == 9)  { // parity
        }
        else { // stop bit
            switch (port->data_in) {
                case PS2_ACK:
                case PS2_ERROR:
                    port->result = port->data_in;
                    setIdle(port);

                    break;
                case PS2_RESEND:
                    if (--port->resend) {
                        setSending(port);
                    }
                    else {
                        port->result = PS2_ERROR;

                        setIdle(port);
                    }

                    break;
                default:
                    port->result = PS2_ERROR;
                    setIdle(port);

                    switch(port->device) {
                        case PS2_KEYBOARD:
                            kbdProcessData(port->data_in);
                            break;
                        default:
                            break;
                    }

                    break;
            }
        }
    }
}

ISR(INT0_vect)
{
    serviceInterrupt(&ports[0]);
}

ISR(INT1_vect)
{
    serviceInterrupt(&ports[1]);
}
