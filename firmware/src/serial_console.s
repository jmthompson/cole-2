; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2018 Joshua M. Thompson *
; *******************************

        .include "common.s"
        .include "sys/console.s"

        .export serial_console_init

        .import getc_seriala
        .import putc_seriala

        .segment "HIGHROM"

BELL     =  $07
LBRACKET =  '['

serial_console_init:
        lda     #$5c
        sta     console_bell
        sta     console_cls
        sta     console_reset
        sta     console_read
        sta     console_write

        lda     #<vt100_bell
        sta     console_bell+1
        lda     #>vt100_bell
        sta     console_bell+2
        lda     #^vt100_bell
        sta     console_bell+3

        lda     #<vt100_cls
        sta     console_cls+1
        lda     #>vt100_cls
        sta     console_cls+2
        lda     #^vt100_cls
        sta     console_cls+3

        lda     #<vt100_reset
        sta     console_reset+1
        lda     #>vt100_reset
        sta     console_reset+2
        lda     #^vt100_reset
        sta     console_reset+3

        lda     #<getc_seriala
        sta     console_read+1
        lda     #>getc_seriala
        sta     console_read+2
        lda     #^getc_seriala
        sta     console_read+3

        lda     #<vt100_write
        sta     console_write+1
        lda     #>vt100_write
        sta     console_write+2
        lda     #^vt100_write
        sta     console_write+3

        rtl

vt100_bell:
        lda     #BELL
        rtl

vt100_cls:
        lda     #ESC
        jsl     putc_seriala
        lda     #LBRACKET
        jsl     putc_seriala
        lda     #'2'
        jsl     putc_seriala
        lda     #'J'
        jml     putc_seriala

vt100_reset:
        ; Reset device
        lda     #ESC
        jsl     putc_seriala
        lda     #'c'
        jsl     putc_seriala
        ; Enable line wrap
        lda     #ESC
        jsl     putc_seriala
        lda     #LBRACKET
        jsl     putc_seriala
        lda     #'7'
        jsl     putc_seriala
        lda     #'h'
        jml     putc_seriala

vt100_read:
        jml     getc_seriala

vt100_write:
        jsl     putc_seriala
        cmp     #CR
        bne     @exit
        pha
        lda     #LF
        jsl     putc_seriala
        pla
@exit:  rtl
