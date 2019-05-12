#include <stdio.h>
#include <avr/interrupt.h>

#include "keyboard.h"
#include "sr.h"
#include "pins.h"
#include "ps2.h"
#include "timers.h"

/**
 * Status register;
 *
 * bit 7 : interrupting
 * bit 6 : reserved
 * bit 5 : reserved
 * bit 4 : reserved
 * bit 3 : reserved
 * bit 2 : SPI ready
 * bit 1 : mouse data available
 * bit 0 : keyboard data available
 */
uint8_t status;

int main(void) {
    initTimers();
    srInit();
    ps2Init();

    status = 0;

    sei();

    kbdInit();  // must occur after all other HW setup

    while (1) {
        srUpdate();
        kbdUpdate();
    }
}
