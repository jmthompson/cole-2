#include <stdio.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>

#include "keyboard.h"
#include "pins.h"
#include "ps2.h"
#include "key_codes.h"
#include "scan_codes.h"
#include "key_map.h"

static volatile uint8_t keyup;      // 1 if next code is a keyup
static volatile uint8_t is_e0;      // 1 if next code is an 0xE0 code
static volatile uint8_t e1_bytes;   // How many bytes of 0xE1 sequence left to skip

static volatile uint8_t led_state;
static volatile uint8_t update_leds;

static void srQueueByte(uint8_t data) {
        // temp do nothing
}

static void putKey(uint8_t scancode) {

    uint8_t keycode = pgm_read_byte(&(scancode_map[is_e0][scancode]));

    if (keycode != 255) {
        srQueueByte(keycode);
    }
}

static void toggle_led(uint8_t code, uint8_t led)
{
    led_state ^= led;

    if (!(led_state & led)) {
        srQueueByte(KEY_PFX_KEYUP);
    }

    putKey(code);

    update_leds = 1;
}

void kbdInit(void)
{
    kbdReset();

    keyup = is_e0 = led_state = update_leds = 0;
}

void kbdReset(void)
{
    ps2SendByte(PS2_PORT_KBD, PS2_RESET);
}

void kbdUpdate(void)
{
    if (update_leds) {
        update_leds = 0;

        if (ps2SendByte(PS2_PORT_KBD, PS2_SET_LEDS) == PS2_ACK) {
            ps2SendByte(PS2_PORT_KBD, led_state);
        }
    }
}

// normal code
// $E0 + code
// $E1 + code (only for pause key)
// $F0 + code

void kbdProcessData(uint8_t code)
{
    if (e1_bytes) {
        if (!--e1_bytes) {
            srQueueByte(KEY_PAUSE);
        }
    }
    else if (code == SC_EXT0) {
        is_e0 = 1;
    }
    else if (code == SC_EXT1) {
        e1_bytes = 7;   // There's only one 0xE1 sequence so just eat it
    }
    else if (code == SC_KEYUP) {
        keyup = 1;
    }
    else {
        if (keyup) {
            switch (code) {
                case SC_CAPS:
                case SC_NUM:
                case SC_SCROLL:
                    break;
                default:
                    srQueueByte(KEY_PFX_KEYUP);
                    putKey(code);
                    break;
            }

            keyup = 0;
        }
        else {
            switch (code) {
                case SC_CAPS:
                    toggle_led(code, LED_CAPS);
                    break;
                case SC_NUM:
                    toggle_led(code, LED_NUM);
                    break;
                case SC_SCROLL:
                    toggle_led(code, LED_SCROLL);
                    break;
                default:
                    putKey(code);
                    break;
            }
        }

        is_e0 = 0;
    }
}
