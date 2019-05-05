; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2019 Joshua M. Thompson *
; *******************************

        .include "common.s"
        .include "sys/console.s"
        .include "sys/key_codes.s"

        .export kbd_handler
        .export kbd_init
        .export kbd_read

BUFFER_SIZE = 16

;;
; Keyboard events are <keycode><modifiers>
;
; <modifiers> is a bitmap

MOD_ALT     = $01
MOD_CTRL    = $02
MOD_SHIFT   = $04
MOD_CAPS    = $08
MOD_NUM     = $10
MOD_SCROLL  = $20
MOD_KEYUP   = $80

        .segment "SYSDATA": far

kbd_buffer:
        .res    BUFFER_SIZE

        .segment "ZEROPAGE"

rd_idx: .res    1
wr_idx: .res    1

        .segment "LOWROM"

kbd_init:
        stz     rd_idx
        stz     wr_idx
        rts

;;
; Keyboard handler. This function is called during the AVR interrupt handler
; to handle incoming keyboard data. On entry A will contain the new byte from
; the keyboard.
;
; On exit the contents of X are undefined
;
kbd_handler:
        ldx     wr_idx
        inx
        cpx     rd_idx      ; Are we about to overrun the buffer?
        beq     @exit       ; If yes drop this byte
        sta     kbd_buffer-1,x
        stx     wr_idx
@exit:  rts

;;
; Return the next key fron the buffer, if one is available. 
;
; On exit, C=1 and A=keycode if there was data in the buffer.
; Otherwise, C=0 and A is undefined.
;
kbd_read:
        phx
        jsr     get_event
        bcc     @empty
        bit     #MOD_KEYUP
        bne     @empty      ; Ignore keyup
        jsr     apply_modifiers
        xba
        plx
        sec
        rtl
@empty: plx
        clc
        rtl

;;
; Given a keyboard event in A/B, apply modifiers to the keycode
; and return the result in A.
;
apply_modifiers:
        bit     #MOD_SHIFT
        beq     @noshift
        jsr     apply_shift
@noshift:
        bit     #MOD_CAPS
        beq     @nocaps
        jsr     apply_capslock
@nocaps:
        bit     #MOD_CTRL
        beq     @noctrl
        jsr     apply_control
@noctrl:
        rts

apply_shift:
        xba
        cmp     #$80
        bge     @no
        tax
        lda     shift_table,x
@no:    xba
        rts

apply_capslock:
        xba
        cmp     #'a'
        blt     @no
        cmp     #'z'+1
        bge     @no
        and     #~$20&$FF
@no:    xba
        rts

apply_control:
        xba
        cmp     #'a'
        blt     @no
        cmp     #'z'+1
        bge     @no
        and     #~$60&$FF
@no:    xba
        rts

;;
; Get the next keyboard event from the buffer, if one is available.
; Returns with C = 0 if no key code is available. Otherwise, C=1,
; the key code is in B and the modifiers are in A.
;
get_event:
        ldx     rd_idx
        cpx     wr_idx
        beq     @empty
        lda     kbd_buffer,x
        xba
        inx
        lda     kbd_buffer,x
        inx
        stx     rd_idx 
        sec
        rts
@empty: clc
        rts

;;
; This table maps a key code to its shifted equivalent. For easy readability codes that do not
; change while shifted are given in hex; keys that change are given as actual chars.
;
shift_table:
        .byte $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
        .byte $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
        .byte ' ', $21, $22, $23, $24, $25, $26, '"', $28, $29, $2A, $2B, '<', '_', '>', '?'
        .byte ')', '!', '@', '#', '$', '%', '^', '&', '*', '(', $3A, ':', $3C, '+', $3E, $3F
        .byte $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
        .byte $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, '{', '|', '}', $5E, $5F
        .byte $60, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O'
        .byte 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', $7B, $7C, $7D, $7E, $7F
