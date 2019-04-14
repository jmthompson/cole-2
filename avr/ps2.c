#include <stdio.h>
#include <avr/interrupt.h>

#include "pins.h"
#include "ps2.h"
#include "timers.h"

volatile kbd_state_t state;

volatile uint8_t kbd_buffer[MAX_KBD_BYTES];
volatile uint8_t kbd_bytes;

volatile uint8_t kbd_data;
volatile uint8_t kbd_bits;
volatile uint8_t kbd_parity;

/**
 * Strobe one of the handshake pins on port B. Input is the pin mask.
 */
static inline void strobe(uint8_t pin)
{
    PORTB &= ~pin;
    __asm__("nop\n\t");
    PORTB |= pin;
}

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
    kbd_data   = kbd_bits = 0;
    kbd_parity = 0;
    state   = PS2_RECEIVING;
}

static inline void setIdle(void)
{
    DDRC    &= ~PC_PS2_DATA;
    state = PS2_IDLE;
}

/**
 * Initialize the PS/2 driver.
 */
void ps2Init(void)
{
    kbd_bytes = 0;

    setIdle();
}

uint8_t ps2GetKbdBytes(uint8_t *buffer)
{
    cli();

    uint8_t bytes = kbd_bytes;

    if (bytes) {
        for (uint8_t i = 0 ; i < bytes ; ++i) {
            *buffer++ = kbd_buffer[i];
        }

        kbd_bytes = 0;
    }

    sei();

    return bytes;
}

void ps2SendKbdByte(uint8_t byte)
{
    while (state != PS2_IDLE) { /* wait */ }

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
    kbd_data   = byte;
    kbd_parity = 0;

    state = PS2_SENDING;

    while (state != PS2_IDLE) { /* wait */ }
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
            setBit(kbd_data & 1);
            kbd_parity += kbd_data & 1;

            kbd_data >>= 1;
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
            kbd_data >>= 1;

            if (getBit()) {
                kbd_data |= 0x80;

                ++kbd_parity;
            }
        }
        else if (kbd_bits == 9)  {
            // parity
        }
        else {
            // stop bit

            if (kbd_bytes < MAX_KBD_BYTES) {
                kbd_buffer[kbd_bytes++] = kbd_data;
            }

            setIdle();
        }
    }
}
