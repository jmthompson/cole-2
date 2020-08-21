#include <stdio.h>
#include <avr/interrupt.h>

#include "pins.h"
#include "ps2.h"
#include "serial.h"
#include "spi.h"
#include "system.h"
#include "timers.h"

int main(void) {
    systemInit();
    timerInit();
    ps2Init();
    spiInit();

    sei();

    serial_start_stdio_baud();
    systemReset();      // now reset the system
    printf("ready\r\n");

    while (1) {
        spiUpdate();
        // TODO: game pad update
    }
}
