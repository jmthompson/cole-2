#include <stdio.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>

#include "keyboard.h"
#include "pins.h"
#include "ps2.h"
#include "key_codes.h"
#include "scan_codes.h"
#include "key_map.h"

static volatile uint8_t kbd_buffer[MAX_KBD_BYTES];
static volatile uint8_t kbd_bytes;

// Bitmap of what modifiers and toggles are currently down/on
static volatile uint16_t modifiers;

static volatile uint8_t keyup;          // 1 if next code is a keyup
static volatile uint8_t is_e0;          // 1 if next code is an 0xE0 code
static volatile uint8_t e1_bytes;       // How many bytes of 0xE1 sequence are left
static volatile uint8_t led_state;      // Current state of the keyboard LEDs
static volatile uint8_t update_leds;    // 1 if keyboard LEDs need to be updated

static void setLeds(void)
{
    if (ps2SendByte(PS2_PORT_KBD, PS2_SET_LEDS) == PS2_ACK) {
        ps2SendByte(PS2_PORT_KBD, led_state);
    }
}

static void putKey(uint8_t scancode, uint8_t mods) {
    if (kbd_bytes < MAX_KBD_BYTES) {
        uint8_t keycode = pgm_read_byte(&(scancode_map[is_e0][scancode]));

        if (keycode != 255) {
            kbd_buffer[kbd_bytes++] = keycode;
            kbd_buffer[kbd_bytes++] = mods;
        }
    }
}

static void handleKeyDown(uint8_t code)
{
    switch (code) {
        case SC_ALT:
            modifiers |= MOD_ALT;

            break;
        case SC_CTRL:
            modifiers |= MOD_CTRL;

            break;
        case SC_L_SHIFT:
        case SC_R_SHIFT:
            modifiers |= MOD_SHIFT;

            break;
        case SC_CAPS:
            modifiers ^= MOD_CAPS;

            if (modifiers & MOD_CAPS) {
                led_state |= LED_CAPS;
            }
            else {
                led_state &= ~LED_CAPS;
            }

            update_leds = 1;

            break;
        case SC_NUM:
            modifiers ^= MOD_NUM;

            if (modifiers & MOD_NUM) {
                led_state |= LED_NUM;
            }
            else {
                led_state &= ~LED_NUM;
            }

            update_leds = 1;

            break;
        case SC_SCROLL:
            modifiers ^= MOD_SCROLL;

            if (modifiers & MOD_SCROLL) {
                led_state |= LED_SCROLL;
            }
            else {
                led_state &= ~LED_SCROLL;
            }

            update_leds = 1;

            break;
        default:
            putKey(code, modifiers);

            break;
    }
}

static void handleKeyUp(uint8_t code)
{
    switch(code) {
        case SC_ALT:
            modifiers &= ~MOD_ALT;

            break;
        case SC_CTRL:
            modifiers &= ~MOD_CTRL;

            break;
        case SC_L_SHIFT:
        case SC_R_SHIFT:
            modifiers &= ~MOD_SHIFT;

            break;
        default:
            putKey(code, modifiers | 0x80);

            break;
    }
}

void kbdInit(void)
{
    kbdReset();

    kbd_bytes = keyup = is_e0 = update_leds = 0;
    modifiers = 0;
}

void kbdReset(void)
{
    ps2SendByte(PS2_PORT_KBD, PS2_RESET);
}

void kbdUpdate(void) {
    if (update_leds) {
        update_leds = 0;

        setLeds();
    }
}

uint8_t kbdDataReady(void)
{
    return kbd_bytes;
}

uint8_t kbdGetData(uint8_t *buffer)
{
    cli();

    uint8_t bytes = kbd_bytes;

    if (bytes) {
        for (uint8_t i = 0 ; i < bytes ; ++i) {
            *buffer++ = kbd_buffer[i];
        }

        kbd_bytes = 0;
    }

    sei();

    return bytes;
}

void kbdSetLeds(uint8_t new_state)
{
   led_state = new_state & 0x07;

   setLeds();
}

// normal code
// $E0 + code
// $E1 + code (only for pause key)
// $F0 + code

void kbdProcessData(uint8_t code)
{
    if (e1_bytes) {
        if (!--e1_bytes) {
            putKey(KEY_PAUSE, modifiers);
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
            handleKeyUp(code);

            keyup = 0;
        }
        else {
            handleKeyDown(code);
        }

        is_e0 = 0;
    }
}
