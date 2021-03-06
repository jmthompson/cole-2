; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2018 Joshua M. Thompson *
; *******************************

        .include "common.s"
        .include "sys/console.s"

        .export vt100_reset
        .export vt100_write

        .import getc_seriala
        .import putc_seriala

        .segment "HIGHROM"

BELL     =  $07
LBRACKET =  '['

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

vt100_write:
        pha
        jsl     putc_seriala
        pla
        cmp     #CR
        bne     @exit
        lda     #LF
        jsl     putc_seriala
@exit:  rtl
