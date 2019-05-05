/**
 * Keyboard key codes
 */

/* ASCII keys */

#define KEY_BREAK      0x00
#define KEY_BACKSPACE  0x08
#define KEY_TAB        0x09
#define KEY_ENTER      0x0D
#define KEY_ESC        0x1B
#define KEY_SPACE      0x20

#define KEY_APOSTROPHE 0x27
#define KEY_COMMA      0x2C
#define KEY_MINUS      0x2D
#define KEY_PERIOD     0x2E
#define KEY_DIV        0x2F

#define KEY_0          0x30
#define KEY_1          0x31
#define KEY_2          0x32
#define KEY_3          0x33
#define KEY_4          0x34
#define KEY_5          0x35
#define KEY_6          0x36
#define KEY_7          0x37
#define KEY_8          0x38
#define KEY_9          0x39

#define KEY_SEMICOLON  0x3B
#define KEY_EQUALS     0x3D

#define KEY_A          0x41
#define KEY_B          0x42
#define KEY_C          0x43
#define KEY_D          0x44
#define KEY_E          0x45
#define KEY_F          0x46
#define KEY_G          0x47
#define KEY_H          0x48
#define KEY_I          0x49
#define KEY_J          0x4A
#define KEY_K          0x4B
#define KEY_L          0x4C
#define KEY_M          0x4D
#define KEY_N          0x4E
#define KEY_O          0x4F
#define KEY_P          0x50
#define KEY_Q          0x51
#define KEY_R          0x52
#define KEY_S          0x53
#define KEY_T          0x54
#define KEY_U          0x55
#define KEY_V          0x56
#define KEY_W          0x57
#define KEY_X          0x58
#define KEY_Y          0x59
#define KEY_Z          0x5A

#define KEY_L_BRACKET  0x5B
#define KEY_BACKSLASH  0x5C
#define KEY_R_BRACKET  0x5D
#define KEY_BACKTICK   0x60

/* Non-ASCII keys */

// Cursor keys
#define KEY_HOME        0x81
#define KEY_END         0x82
#define KEY_INSERT      0x83
#define KEY_DELETE      0x84
#define KEY_PAGE_DOWN   0x85
#define KEY_PAGE_UP     0x86
#define KEY_LEFT_ARROW  0x87
#define KEY_RIGHT_ARROW 0x88
#define KEY_UP_ARROW    0x89
#define KEY_DOWN_ARROW  0x8A

// Misc
#define KEY_MENU        0x8B
#define KEY_PRTSCR      0x8C
#define KEY_PAUSE       0x8D
#define KEY_L_GUI       0x8E
#define KEY_R_GUI       0x8F

// Keypad keys
#define KEY_KP0        0x90
#define KEY_KP1        0x91
#define KEY_KP2        0x92
#define KEY_KP3        0x93
#define KEY_KP4        0x94
#define KEY_KP5        0x95
#define KEY_KP6        0x96
#define KEY_KP7        0x97
#define KEY_KP8        0x98
#define KEY_KP9        0x99
#define KEY_KP_COMMA   0x9A
#define KEY_KP_DIV     0x9B
#define KEY_KP_ENTER   0x9C
#define KEY_KP_EQUALS  0x9D
#define KEY_KP_MINUS   0x9E
#define KEY_KP_PERIOD  0x9F
#define KEY_KP_PLUS    0xA0
#define KEY_KP_TIMES   0xA1

// Language keys
#define KEY_LANG1      0xA2
#define KEY_LANG2      0xA3
#define KEY_LANG3      0xA4
#define KEY_LANG4      0xA5
#define KEY_LANG5      0xA6
#define KEY_SYSRQ      0xA7

// ACPI
#define KEY_POWER      0xA8
#define KEY_SLEEP      0xA9
#define KEY_WAKE       0xAA

// Multimedia keys
#define KEY_MEDIA        0xC0
#define KEY_PLAY         0xC1
#define KEY_STOP         0xC2
#define KEY_NEXT_TRACK   0xC3
#define KEY_PREV_TRACK   0xC4
#define KEY_VOL_DOWN     0xC5
#define KEY_VOL_UP       0xC6
#define KEY_MUTE         0xC7
#define KEY_CALC         0xC8
#define KEY_COMPUTER     0xC9
#define KEY_EMAIL        0xCA
#define KEY_WEB_BACK     0xCB
#define KEY_WEB_FAVOR    0xCC
#define KEY_WEB_FORWARD  0xCD
#define KEY_WEB_HOME     0xCE
#define KEY_WEB_REFRESH  0xCF
#define KEY_WEB_SEARCH   0xD0
#define KEY_WEB_STOP     0xD1

// Fn keys
#define KEY_F1  0xE1
#define KEY_F2  0xE2
#define KEY_F3  0xE3
#define KEY_F4  0xE4
#define KEY_F5  0xE5
#define KEY_F6  0xE6
#define KEY_F7  0xE7
#define KEY_F8  0xE8
#define KEY_F9  0xE9
#define KEY_F10 0xEA
#define KEY_F11 0xEB
#define KEY_F12 0xEC
#define KEY_F13 0xED
#define KEY_F14 0xEE
#define KEY_F15 0xEF
#define KEY_F16 0xF0
#define KEY_F17 0xF1
#define KEY_F18 0xF2
#define KEY_F19 0xF3
#define KEY_F20 0xF4
#define KEY_F21 0xF5
#define KEY_F22 0xF6
#define KEY_F23 0xF7
#define KEY_F24 0xF8

// Misc
#define KEY_INTL1   0xF9
#define KEY_INTL2   0xFA
#define KEY_INTL3   0xFB
#define KEY_INTL4   0xFC
#define KEY_INTL5   0xFD
#define KEY_EUROPE2 0xFE

