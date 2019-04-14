#include <stdio.h>
#include <avr/interrupt.h>

#include "pins.h"

static volatile uint32_t milli_count = 0;
static volatile uint32_t micro_count = 0;

void initTimers(void) {
    TCCR0A = 0;
    TCCR0B = 0;
    TCCR1A = 0;
    TCCR1B = 0;
    TCCR2A = 0;
    TCCR2B = 0;

    // Initialize counter 0.
    milli_count = 0;
    micro_count = 0;
    TCCR0A = BIT(WGM01);     // CTC mode.
    TCNT0 = 0;               // Start from 0.
    OCR0A = 250;             // 16MHz / 64 / 250 = 1KHz.
    OCR0B = 0;               // Unused.
    TIMSK0 = BIT(OCIE0A);    // Enable interrupt on OCR0A compare match.

    // Start counter 0 - set prescaler to CLK/64.
    TCCR0B = BIT(CS01) | BIT(CS00);
}
/*
 * Get the time since clock start, in milliseconds.
 */
uint32_t millis(void)
{
    uint8_t sreg = SREG;
    cli();
    uint32_t mc = milli_count;
    SREG = sreg;
    return mc;
}

/*
 * Get the time in microseconds.  Max resolution is 4usec.  Beware wraparound!
 */
uint32_t micros(void)
{
    uint8_t sreg = SREG;
    cli();
    uint32_t mc = micro_count + (TCNT0 << 2);
    SREG = sreg;
    return mc;
}

/**
 * delayMicroseconds: delay:
 *  These are "fake" delays in that they don't use any timers, etc. so are
 *  just best guesses at the actual delay time.
 *********************************************************************************
 */

void delayMicroseconds(int x)
{
  for( ; x > 0 ; x--)
  {
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

void delay(unsigned long ms)
{
    uint16_t start = (uint16_t)micros();

    while (ms > 0) {
        if (((uint16_t)micros() - start) >= 1000) {
            ms--;
            start += 1000;
        }
    }
}

/**
 * Timer0 interrupt handler; just increments the time
 */
ISR(TIMER0_COMPA_vect)
{
    milli_count++;
    micro_count += 1000;
}
