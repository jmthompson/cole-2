#include <stdio.h>
#include <avr/interrupt.h>

#include "sr.h"
#include "pins.h"
#include "ps2.h"
#include "timers.h"

#define INDEX_MASK (SR_BUFFER_SIZE - 1)

static volatile uint8_t buffer[SR_BUFFER_SIZE];
static volatile uint8_t wr_idx, rd_idx;

static inline void sr_pulse()
{
    PORTB |= PB_SR_CLK;
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    PORTB &= ~PB_SR_CLK;
}

/**
 * Initialize the shift register driver.
 */
void srInit(void)
{
    DDRB  |= PB_SR_CLK|PB_SR_DATA;
    PORTB &= ~(PB_SR_CLK|PB_SR_DATA);

    DDRC  |= PC_DATA_RDY;
    PORTC |= PC_DATA_RDY;

    wr_idx = rd_idx = 0;
}

void srUpdate(void)
{
    if (!(PINC & PC_DATA_ACK) && (wr_idx != rd_idx)) {
        uint8_t data = buffer[rd_idx];

        for (uint8_t i = 0 ; i < 8 ; ++i) {
            if (data & 0x80) {
                PORTB |= PB_SR_DATA;
            }
            else {
                PORTB &= ~PB_SR_DATA;
            }

            data <<= 1;

            sr_pulse();
        }

        sr_pulse();

        PORTC |= PC_DATA_RDY;
        __asm__("nop\n\t");
        __asm__("nop\n\t");
        __asm__("nop\n\t");
        __asm__("nop\n\t");
        PORTC &= ~PC_DATA_RDY;

        rd_idx = (rd_idx + 1) & INDEX_MASK;
    }
}

void srQueueByte(uint8_t data) {
    uint8_t new_idx = (wr_idx + 1) & INDEX_MASK;
    
    if (new_idx != rd_idx) {
        buffer[wr_idx] = data;

        wr_idx = new_idx;
    }
}
