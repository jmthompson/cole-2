#ifndef __PS2_H
#define __PS2_H

#include "packet_types.h"

#define PS2_PORT_KBD    0
#define PS2_PORT_MOUSE  1

// Commands
#define PS2_SET_LEDS    0xED
#define PS2_RESET       0xFF

// Self-test responses
#define PS2_TEST_OK     0xAA
#define PS2_TEST_FAIL1  0xFC
#define PS2_TEST_FAIL2  0xFD

// Response bytes
#define PS2_ACK         0xFA
#define PS2_RESEND      0xFE
#define PS2_ERROR       0xFF

typedef enum kbd_state_t {
    PS2_IDLE,
    PS2_RECEIVING,
    PS2_SENDING,
    PS2_SEND_ACK,
    PS2_SEND_ERROR,
    PS2_SEND_RESEND
} kbd_state_t;

extern void ps2Init(void);
extern void ps2Interrupt(void);
extern uint8_t ps2SendByte(uint8_t, uint8_t);

#endif // __PS2_H
