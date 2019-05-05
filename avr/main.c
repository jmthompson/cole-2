#include <stdio.h>
#include <avr/interrupt.h>

#include "keyboard.h"
#include "packet_types.h"
#include "mpu.h"
#include "pins.h"
#include "ps2.h"
#include "timers.h"

uint8_t payload[MAX_PAYLOAD];
uint16_t payload_len;

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

/**
 * Set interrupt (pull IRQ line low)
 */
static void set_irq(void) {
    status |= 0x80;

    PORTC &= ~PC_IRQ;
}

/**
 * Clar interrupt line (pull IRQ high)
 */
static void clear_irq(void) {
    status &= 0x7F;

    PORTC |= PC_IRQ;
}

int main(void) {
    initTimers();
    mpuInit();
    ps2Init();

    // Enable pin change interrupts
    PCICR  |= BIT(PCIE0) | BIT(PCIE1); 
    PCMSK0 |= BIT(PCINT1) | BIT(PCINT0);
    PCMSK1 |= BIT(PCINT9) | BIT(PCINT12);

    // Default IRQ line to high
    DDRC  |= PC_IRQ;
    PORTC |= PC_IRQ;

    status = 0;

    sei();

    kbdInit();  // must occur after all other HW setup

    while (1) {
        kbdUpdate();    // Do pending LED updates, etc.

        /**
         * If the "keyboard data availble" is not set,
         * and data is now available, then set the flag
         * and raise an interrupt
         */
        if (!(status & 0x01) && kbdDataReady()) {
            status |= 0x01;

            set_irq();
        }

        uint8_t pt = mpuGetRequest(payload, &payload_len);
        
        switch(pt) {
            case PT_NO_DATA:
                // do nothing
                break;
            case PT_GET_STATUS:
                mpuSendResponse(PT_STATUS, &status, 1);
                clear_irq();

                break;
            case PT_GET_KBD_DATA:
                payload_len = kbdGetData(payload);
                mpuSendResponse(PT_KBD_DATA, payload, payload_len);
                status &= ~0x01;    // clear kbd data available flag

                break;
            case PT_SET_KBD_LEDS:
                if (payload_len != 1) {
                    mpuSendResponse(PT_PROTOCOL_ERROR, NULL, 0);
                }
                else {
                    kbdSetLeds(payload[0]);

                    mpuSendResponse(PT_PS2_RESPONSE, payload, payload_len);
                }

                break;
            case PT_TEST:
                if (payload_len) {
                    for (uint16_t i = 0 ; i < payload_len ; i++) {
                        payload[i] = ~payload[i]; 
                    }
                }

                mpuSendResponse(PT_TEST_RESPONSE, payload, payload_len);

                break;
            default:
                mpuSendResponse(PT_UNKNOWN_CMD, NULL, 0);

                break;
        }
    }
}
