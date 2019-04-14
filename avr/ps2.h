#ifndef __PS2_H
#define __PS2_H

#include "packet_types.h"

#define MAX_KBD_BYTES 32

#define PS2_ACK         0xFA
#define PS2_SET_LEDS    0xED

typedef enum kbd_state_t {
    PS2_IDLE,
    PS2_RECEIVING,
    PS2_SENDING
} kbd_state_t;

extern void ps2Init(void);
extern void ps2Interrupt(void);

extern uint8_t ps2GetKbdBytes(uint8_t *);
extern void ps2SendKbdByte(uint8_t);

#endif // __PS2_H
