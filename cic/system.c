#include <stdio.h>
#include <avr/interrupt.h>

#include "pins.h"
#include "timers.h"

static void resetOn(void)
{
    // Let RESET float high
    DDRC &= ~PC_RESET;
}

static void resetOff(void)
{
    // Pull RESET low
    DDRC |= PC_RESET;
}

static void nmiOn(void)
{
    // Pull /NMI low
    DDRC |= PC_NMI;
}

static void nmiOff(void)
{
    // Let /NMI float high
    DDRC &= ~PC_NMI;
}

void systemInit(void)
{
    // System interface lines are always either driven low or floating.
    PORTC &= ~(PC_NMI|PC_RESET);

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
