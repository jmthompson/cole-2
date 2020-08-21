; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2019 Joshua M. Thompson *
; *******************************

        .include "common.s"
        .include "sys/console.s"
        .include "sys/key_codes.s"

        .export cic_init
        .export cic_irq
        .export kbd_read

        .import spi_deselect
        .import spi_select
        .import spi_transfer

BUFFER_SIZE = 16
CIC_DEV_ID  = 0

CMD_STATUS      = $00
CMD_READ_KBD    = $01
CMD_READ_MOUSE  = $02
CMD_READ_GP0    = $03 
CMD_READ_GP1    = $04 
CMD_SET_CTRL    = $80 
CMD_WRITE_KBD   = $81 
CMD_WRITE_MOUSE = $82

KBD_IN_FULL     = $01
MOUSE_IN_FULL   = $02
KBD_OUT_FULL    = $04
MOUSE_OUT_FULL  = $08

PS2_SET_LEDS    = $ED
LED_SCROLL      = $01
LED_NUM         = $02
LED_CAPS        = $03

MOD_ALT     = $01
MOD_CTRL    = $02
MOD_SHIFT   = $04
MOD_CAPS    = $08
MOD_NUM     = $10
MOD_SCROLL  = $20
MOD_KEYUP   = $80

        .segment "SYSDATA": far

key_buffer: .res BUFFER_SIZE
mod_buffer: .res BUFFER_SIZE

        .segment "ZEROPAGE"

in_e0:      .res    1
in_e1:      .res    1
in_keyup:   .res    1
kbd_rd_idx: .res    1
kbd_wr_idx: .res    1
modifiers:  .res    1

        .segment "LOWROM"

cic_init:
        stz     in_e0
        stz     in_e1
        stz     in_keyup
        stz     kbd_rd_idx
        stz     kbd_wr_idx
        stz     modifiers
        jsr     reset_kbd
        rts

reset_kbd:
        ldx     #CMD_WRITE_KBD
        lda     #$FF
        jmp     cic_command

;; 
; CIC interrupt handler
;
cic_irq:
        ldx     #CMD_STATUS
        jsr     cic_command
        bit     #KBD_IN_FULL    ; keyboard input buffer full?
        beq     :+
        pha
        ldx     #CMD_READ_KBD
        jsr     cic_command     ; read the keyboard input buffer
;;        jsr     process_kbd     ; ... and process the byte
        pla
:       bit     #MOUSE_IN_FULL
        beq     :+
        ldx     #CMD_READ_MOUSE
        jsr     cic_command
        ;; TODO handle mouse data
:       rts

;;;;process_kbd:
;;;;        bit     in_e1           ; Processing an $e1 code (pause key only)?
;;;;        bne     @cont
;;;;        dec     in_e1           ; dec remaining byte count
;;;;        bne     :+              ; Exit if there are more bytes
;;;;        lda     #KEY_PAUSE
;;;;        jsr     queue_key
;;;;:       rts                     ; and exit
;;;;@cont:  cmp     #$E0            ; start of $e0 sequence?
;;;;        bne     :+
;;;;        sta     in_e0           ; set flag
;;;;        rts                     ; and exit
;;;;:       cmp     #$E1            ; start of $e1 sequence
;;;;        bne     :+
;;;;        lda     #7
;;;;        sta     in_e1           ; eat the next seven bytes
;;;;        rts
;;;;:       cmp     #$F0            ; keyup?
;;;;        bne     :+
;;;;        sta     in_keyup        ; flag that we're procesing a keyup
;;;;        rts
;;;;:       bit     in_keyup        ; is this a key up or key down?
;;;;        beq     process_keydown
;;;;
;;;;process_keyup:
;;;;        cmp     #SC_CAPS
;;;;        beq     :+
;;;;        cmp     #SC_NUM
;;;;        beq     :+
;;;;        cmp     #SC_SCROLL
;;;;        beq     :+
;;;;
;;;;        ; TODO save keyups in raw mode
;;;;                
;;;;:       stz     in_e0
;;;;        stz     in_keyup
;;;;        rts
;;;;
;;;;process_keydown:
;;;;        cmp     #SC_CAPS
;;;;        bne     :+
;;;;        lda     #LED_CAPS
;;;;        jsr     toggle_leds
;;;;        bra     @exit
;;;;:       cmp     #SC_NUM
;;;;        bne     :+
;;;;        lda     #LED_NUM
;;;;        jsr     toggle_leds
;;;;        bra     @exit
;;;;:       cmp     #SC_SCROLL
;;;;        bne     :+
;;;;        lda     #LED_SCROLL
;;;;        jsr     toggle_leds
;;;;        bra     @exit
;;;;:       
;;;;        
;;;;@exit:  stz     in_e0
;;;;        rts

;;
; Queue a key code sequence. Key code is in A, modifiers are in B
;
queue_key:
        pha
        lda     kbd_wr_idx
        inc                     ; incr read index
        and     #BUFFER_SIZE-1  ; ... and wrap it at the buffer size
        cmp     kbd_rd_idx      ; Are we about to overrun the buffer?
        beq     @full           ; If yes drop this key
        tax                     ; Transfer new read index to X
        pla                     ; get keyboard data back
        sta     key_buffer,x    ; ... and save it in the buffer
        xba                     ; Get modifiers
        sta     mod_buffer,x    ; .. and save them too
        stx     kbd_wr_idx
        rts
@full:  pla
        rts

toggle_leds:

;;
; Return the next key fron the buffer, if one is available. 
;
; On exit, C=1 and A=keycode if there was data in the buffer.
kbd_read:
        phx
        jsr     parse_keycode
        plx
        rtl

parse_keycode:
        jsr     get_data
        bcs     @process
        rts
@process:
        xba                     ; save data for later
        lda     #MOD_KEYUP
        bit     modifiers       ; are we processing a key up sequence?
        bmi     key_up          ; yes so process key up
        bra     key_down        ; no, so process key down

key_up:
        trb     modifiers       ; A is still #MOD_KEYUP
        xba
        cmp     #KEY_L_ALT
        beq     @alt
        cmp     #KEY_R_ALT
        beq     @alt
        cmp     #KEY_L_CTRL
        beq     @ctrl
        cmp     #KEY_R_CTRL
        beq     @ctrl
        cmp     #KEY_L_SHIFT
        beq     @shift
        cmp     #KEY_R_SHIFT
        beq     @shift
        cmp     #KEY_CAPS
        beq     @caps
        cmp     #KEY_NUM
        beq     @num
        cmp     #KEY_SCROLL
        beq     @scroll
        bra     parse_keycode   ; don't care about other key up codes
@alt:   lda     #MOD_ALT
        trb     modifiers
        bra     parse_keycode
@ctrl:  lda     #MOD_CTRL
        trb     modifiers
        bra     parse_keycode
@shift: lda     #MOD_SHIFT
        trb     modifiers
        bra     parse_keycode
@caps:  lda     #MOD_CAPS
        trb     modifiers
        bra     parse_keycode
@num:   lda     #MOD_NUM
        trb     modifiers
        bra     parse_keycode
@scroll: lda    #MOD_SCROLL 
        trb     modifiers
        bra     parse_keycode

key_down:
        xba
        cmp     #KEY_PFX_KEYUP  ; is it a keyup prefix
        beq     @keyup
        cmp     #KEY_L_ALT
        beq     @alt
        cmp     #KEY_R_ALT
        beq     @alt
        cmp     #KEY_L_CTRL
        beq     @ctrl
        cmp     #KEY_R_CTRL
        beq     @ctrl
        cmp     #KEY_L_SHIFT
        beq     @shift
        cmp     #KEY_R_SHIFT
        beq     @shift
        cmp     #KEY_CAPS
        beq     @caps
        cmp     #KEY_NUM
        beq     @num
        cmp     #KEY_SCROLL
        beq     @scroll
        jsr     apply_modifiers
        sec
        rts
@keyup: lda     #MOD_KEYUP
        tsb     modifiers
        jmp     parse_keycode
@alt:   lda     #MOD_ALT
        tsb     modifiers
        jmp     parse_keycode
@ctrl:  lda     #MOD_CTRL
        tsb     modifiers
        jmp     parse_keycode
@shift: lda     #MOD_SHIFT
        tsb     modifiers
        jmp     parse_keycode
@caps:  lda     #MOD_CAPS
        tsb     modifiers
        jmp     parse_keycode
@num:   lda     #MOD_NUM
        tsb     modifiers
        jmp     parse_keycode
@scroll: lda    #MOD_SCROLL
        tsb     modifiers
        jmp     parse_keycode

;;
; Given a key code A, apply modifiers to the keycode
; and return the result in A.
;
apply_modifiers:
        xba
        lda     modifiers
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
        xba
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
; Get the next byte from the buffer, if one is available.
; Returns with C = 0 if no data is available. Otherwise, C=1,
; and the data is in A
;
get_data:
        ldx     kbd_rd_idx
        cpx     kbd_wr_idx
        beq     @empty
        lda     key_buffer,x
        xba
        inx
        txa
        and     #BUFFER_SIZE-1
        tax
        stx     kbd_rd_idx 
        xba
        sec
        rts
@empty: clc
        rts

;;
; Send SPI command in X, followed by data in A.
; Returns response to data byte in A.
;
cic_command:
        xba
        lda     #CIC_DEV_ID
        jsr     spi_select      ; select the CIC
        txa
        jsr     spi_transfer
        xba
        jsr     spi_transfer
        jmp     spi_deselect

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
