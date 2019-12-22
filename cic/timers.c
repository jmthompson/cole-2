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

    // Initialize counter 0.
    TCNT0  = 0;             // start count at zero
    TCCR0A = BIT(WGM01)|BIT(COM0A0);    // CTC mode.
    OCR0A  = 131;           // 8MHz / 1024 / 131 = 59.63 Hz.
    OCR0B  = 0;             // Unused.
    TIMSK0 = BIT(OCIE0A);   // enable interrupt
}

/**
 * Return 1 if the timer has expired, and zero otherwise.
 */
uint8_t timerExpired(void)
{
    return ticks? 0 : 1;
}

/**
 * Set the timer value
 */
void setTimer(uint8_t numTicks)
{
    ticks = numTicks;

    // Set prescaler to clk/1024 and start the timer
    TCCR0B = BIT(CS02) | BIT(CS00);
}

/**
 * Delay by up to 255 us. This is very approximate
 * and assumes an 8 MHz clock.
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
  }
}

/**
 * Delay by up to 255 ticks. One tick is ~1/60th of
 * a second, so the maximum delay is ~4.25 seconds.
 */
void delayTicks(uint8_t numTicks)
{
    setTimer(numTicks);

    while (!timerExpired()) { /* wait */ }
}

/**
 * Timer0 interrupt handler
 */
ISR(TIMER0_COMPA_vect)
{
    if (ticks) {
        --ticks;
    }

    if (!ticks) {
        TCCR0B = 0; // stop the timer
    }
}
