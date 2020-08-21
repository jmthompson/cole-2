#include <stdio.h>
#include <avr/interrupt.h>

#include "pins.h"

static volatile uint8_t ticks = 0;

void timerInit(void) {
    TCCR0A = 0;
    TCCR0B = 0;
    TCCR1A = 0;
    TCCR1B = 0;
    TCCR2A = 0;
    TCCR2B = 0;

    // Initialize counter 1.
    TCCR1A = 0;
    TCCR1B = BIT(WGM12);     // CTC mode
    TCNT1 = 0;               // Start from 0.
    OCR1A = 41667;           // 20MHz / 8 / 41667 = 59.99 Hz
    OCR1B = 0;               // Unused.
    TIMSK1 = BIT(OCIE1A);    // Enable interrupt on OCR1A compare match.
}

/**
 * Return 1 if the timer has expired, and zero otherwise.
 */
uint8_t timerExpired(void)
{
    return ticks == 0;
}

/**
 * Set the timer value
 */
void setTimer(uint8_t numTicks)
{
    ticks = numTicks;

    TCCR1B |= BIT(CS11);
}

/**
 * Delay by up to 255 us. This is very approximate
 * and assumes a 20 MHz clock.
 */
void delayMicroseconds(uint8_t x)
{
  for( ; x > 0 ; x--) {
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
    __asm__("nop\n\t");
  }
}

/**
 * Delay by up to 255 ticks. One tick is ~1/61 of
 * a second, so the maximum delay is ~4.16 seconds.
 */
void delayTicks(uint8_t numTicks)
{
    setTimer(numTicks);

    while (!timerExpired()) { /* wait */ }
}

/**
 * Timer0 interrupt handler
 */
ISR(TIMER1_COMPA_vect)
{
    if (ticks) {
        --ticks;
    }

    if (!ticks) {
        TCCR1B = 0; // stop the timer
    }
}
