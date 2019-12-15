#ifndef __PS2_H
#define __PS2_H

#define PS2_NUM_PORTS   2
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

typedef enum ps2_device_t {
    PS2_NONE,
    PS2_KEYBOARD,
    PS2_MOUSE
} ps2_device_t;

typedef enum ps2_state_t {
    PS2_IDLE,
    PS2_RECEIVING,
    PS2_SENDING,
    PS2_SEND_ACK,
    PS2_SEND_ERROR,
    PS2_SEND_RESEND
} ps2_state_t;

typedef struct ps2_port {
    ps2_device_t device;
    ps2_state_t state;

    uint8_t data_mask;
    uint8_t clock_mask;

    uint8_t data_in;
    uint8_t data_out;
    uint8_t result;
    uint8_t bits;
    uint8_t parity;
    uint8_t resend;
} ps2_port_t;

extern void ps2Init(void);
extern uint8_t ps2SendByte(uint8_t, uint8_t);

#endif // __PS2_H
