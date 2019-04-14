#include <stdio.h>
#include <avr/interrupt.h>

#include "packet_types.h"
#include "mpu.h"
#include "pins.h"
#include "ps2.h"
#include "timers.h"

uint8_t payload[MAX_PAYLOAD];
uint16_t payload_len;

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

    sei();

    while (1) {
        uint8_t pt = mpuGetRequest(payload, &payload_len);
        
        switch(pt) {
            case PT_NO_DATA:
                // do nothing
                break;
            case PT_GET_KBD_BYTES:
                payload_len = ps2GetKbdBytes(payload);
                mpuSendResponse(PT_KBD_BYTES, payload, payload_len);

                break;
            case PT_SET_KBD_LEDS:
                if (payload_len != 1) {
                    mpuSendResponse(PT_PROTOCOL_ERROR, NULL, 0);
                }
                else {
                    uint8_t leds = payload[0] & 0x07;

                    ps2SendKbdByte(PS2_SET_LEDS);

                    // wait for a response
                    while (!(payload_len = ps2GetKbdBytes(payload))) {};

                    if (payload[0] == PS2_ACK) {
                        ps2SendKbdByte(leds);

                        while (!(payload_len = ps2GetKbdBytes(payload))) {};
                    }

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
