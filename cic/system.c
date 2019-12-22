#include <stdio.h>
#include <avr/interrupt.h>

#include "pins.h"
#include "timers.h"

static void resetOn(void)
{
    // Let RESET float high
    DDRB &= ~PB_RESET;

    // Pull /RESET low
    DDRB |= PB_RESETB;
}

static void resetOff(void)
{
    // Pull RESET low
    DDRB |= PB_RESET;

    // Let /RESET float high
    DDRB &= ~PB_RESETB;
}

static void nmiOn(void)
{
    // Pull /NMI low
    DDRB |= PB_NMI;
}

static void nmiOff(void)
{
    // Let /NMI float high
    DDRB &= ~PB_NMI;
}

void systemInit(void)
{
    // System interface lines are always either driven low or floating.
    PORTB &= ~(PB_NMI|PB_RESET|PB_RESETB);

    nmiOff();
    resetOff();
}

void systemReset(void)
{
    resetOn();

    delayMicroseconds(255);

    resetOff();
}

void systemBreak(void)
{
    nmiOn();

    delayMicroseconds(255);

    nmiOff();
}
