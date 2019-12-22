#include <stdio.h>
#include <avr/interrupt.h>

#include "pins.h"
#include "ps2.h"
#include "spi.h"
#include "system.h"
#include "timers.h"

int main(void) {
    systemInit();
    timerInit();
    ps2Init();
    spiInit();

    sei();

    delayTicks(125);    // give TIVI enough time to start up
    systemReset();      // now reset the system

    while (1) {
        spiUpdate();
        // TODO: game pad update
    }
}
