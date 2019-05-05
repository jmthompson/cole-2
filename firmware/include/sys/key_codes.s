;;
; Keyboard key codes
;
; Codes < $80 are ASCII-equivalent and can generally be used as-is.
; Codes >= $80 are special keys (Fn keys, shift/ctrl/alt, etc)
;;

KEY_BREAK      = $00
KEY_BACKSPACE  = $08
KEY_TAB        = $09
KEY_ENTER      = $0D
KEY_ESC        = $1B
KEY_SPACE      = $20

KEY_APOSTROPHE = $27
KEY_COMMA      = $2C
KEY_MINUS      = $2D
KEY_PERIOD     = $2E
KEY_DIV        = $2F

KEY_0          = $30
KEY_1          = $31
KEY_2          = $32
KEY_3          = $33
KEY_4          = $34
KEY_5          = $35
KEY_6          = $36
KEY_7          = $37
KEY_8          = $38
KEY_9          = $39

KEY_SEMICOLON  = $3B
KEY_EQUALS     = $3D

KEY_A          = $41
KEY_B          = $42
KEY_C          = $43
KEY_D          = $44
KEY_E          = $45
KEY_F          = $46
KEY_G          = $47
KEY_H          = $48
KEY_I          = $49
KEY_J          = $4A
KEY_K          = $4B
KEY_L          = $4C
KEY_M          = $4D
KEY_N          = $4E
KEY_O          = $4F
KEY_P          = $50
KEY_Q          = $51
KEY_R          = $52
KEY_S          = $53
KEY_T          = $54
KEY_U          = $55
KEY_V          = $56
KEY_W          = $57
KEY_X          = $58
KEY_Y          = $59
KEY_Z          = $5A

KEY_L_BRACKET  = $5B
KEY_BACKSLASH  = $5C
KEY_R_BRACKET  = $5D
KEY_BACKTICK   = $60

;;
; Non-ASCII keys
;;

; Cursor keys
KEY_HOME        = $81
KEY_END         = $82
KEY_INSERT      = $83
KEY_DELETE      = $84
KEY_PAGE_DOWN   = $85
KEY_PAGE_UP     = $86
KEY_LEFT_ARROW  = $87
KEY_RIGHT_ARROW = $88
KEY_UP_ARROW    = $89
KEY_DOWN_ARROW  = $8A

; Misc
KEY_MENU        = $8B
KEY_PRTSCR      = $8C
KEY_PAUSE       = $8D
KEY_L_GUI       = $8E
KEY_R_GUI       = $8F

; Keypad keys
KEY_KP0        = $90
KEY_KP1        = $91
KEY_KP2        = $92
KEY_KP3        = $93
KEY_KP4        = $94
KEY_KP5        = $95
KEY_KP6        = $96
KEY_KP7        = $97
KEY_KP8        = $98
KEY_KP9        = $99
KEY_KP_COMMA   = $9A
KEY_KP_DIV     = $9B
KEY_KP_ENTER   = $9C
KEY_KP_EQUALS  = $9D
KEY_KP_MINUS   = $9E
KEY_KP_PERIOD  = $9F
KEY_KP_PLUS    = $A0
KEY_KP_TIMES   = $A1

; Language keys
KEY_LANG1      = $A2
KEY_LANG2      = $A3
KEY_LANG3      = $A4
KEY_LANG4      = $A5
KEY_LANG5      = $A6
KEY_SYSRQ      = $A7

; ACPI
KEY_POWER      = $A8
KEY_SLEEP      = $A9
KEY_WAKE       = $AA

; Multimedia keys
KEY_MEDIA        = $C0
KEY_PLAY         = $C1
KEY_STOP         = $C2
KEY_NEXT_TRACK   = $C3
KEY_PREV_TRACK   = $C4
KEY_VOL_DOWN     = $C5
KEY_VOL_UP       = $C6
KEY_MUTE         = $C7
KEY_CALC         = $C8
KEY_COMPUTER     = $C9
KEY_EMAIL        = $CA
KEY_WEB_BACK     = $CB
KEY_WEB_FAVOR    = $CC
KEY_WEB_FORWARD  = $CD
KEY_WEB_HOME     = $CE
KEY_WEB_REFRESH  = $CF
KEY_WEB_SEARCH   = $D0
KEY_WEB_STOP     = $D1

; Fn keys
KEY_F1  = $E1
KEY_F2  = $E2
KEY_F3  = $E3
KEY_F4  = $E4
KEY_F5  = $E5
KEY_F6  = $E6
KEY_F7  = $E7
KEY_F8  = $E8
KEY_F9  = $E9
KEY_F10 = $EA
KEY_F11 = $EB
KEY_F12 = $EC
KEY_F13 = $ED
KEY_F14 = $EE
KEY_F15 = $EF
KEY_F16 = $F0
KEY_F17 = $F1
KEY_F18 = $F2
KEY_F19 = $F3
KEY_F20 = $F4
KEY_F21 = $F5
KEY_F22 = $F6
KEY_F23 = $F7
KEY_F24 = $F8

; Misc
KEY_INTL1   = $F9
KEY_INTL2   = $FA
KEY_INTL3   = $FB
KEY_INTL4   = $FC
KEY_INTL5   = $FD
KEY_EUROPE2 = $FE
