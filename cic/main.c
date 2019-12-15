#include <stdio.h>
#include <avr/interrupt.h>

#include "keyboard.h"
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
 * bit 2 : reserved
 * bit 1 : mouse data available
 * bit 0 : keyboard data available
 */
uint8_t status;

int main(void) {
    // Set RESET, /RESET, /NMI, SPIINT, and MISO as outputs
    DDRB |= (PB_RESET|PB_RESETB|PB_NMI|PB_SPIINT|PB_MISO);

    // Start system in reset mode with /NMI high
    PORTB |= (PB_RESET|PB_NMI);
    PORTB &= ~PB_RESETB;

    //Enable SPI && interrupt enable bit
    SPCR=(1<<SPE)|(1<<SPIE);

    status = 0;

    initTimers();
    ps2Init();

    sei();

    //kbdInit();  // Requires interrupts to be enabled

    // Bring the system out of reset
    PORTB &= ~PB_RESET;
    PORTB |= PB_RESETB;

    while (1) {
        kbdUpdate();
    }
}

ISR(SPI_STC_vect)
{
    uint8_t command, reply;
    command = SPDR;   // wot Slave has received
    if (command == 'X') reply = 'Y';
    else reply = 'Z';
    SPDR = reply;     // wot Slave sends on next SPI
}
