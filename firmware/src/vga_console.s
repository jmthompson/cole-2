; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2018 Joshua M. Thompson *
; *******************************

        .include "common.s"
        .include "sys/console.s"

        .export vga_reset
        .export vga_write
        .import kbd_read
        .import vga_font

DEFAULT_COLOR = $0F     ; white on black

COLS = 80
ROWS = 25

SRAM_START = $0000      ; Starting address of screen RAM
CRAM_START = $2000      ; Starting address of color RAM
FRAM_START = $3000      ; Starting address of font RAM
FONT_SIZE  = $1000      ; Size of the font data

tivi_base := $F060

tivi_data       = tivi_base+$00 ; VRAM r/w register
tivi_addr       = tivi_base+$01 ; VRAM address (16-bit)
tivi_ctrl       = tivi_base+$03 ; Control register
tivi_cursorch   = tivi_base+$04 ; Cursor char
tivi_cursorx    = tivi_base+$05 ; Cursor X pos
tivi_cursory    = tivi_base+$06 ; Cursor Y pos
tivi_first_row  = tivi_base+$07 ; First row
tivi_hshift     = tivi_base+$08 ; Horizontal shift register

        .segment "ZEROPAGE"

command:    .res    1
text_attr:  .res    1

        .segment "HIGHROM"

vga_reset:
        lda     #DEFAULT_COLOR
        sta     text_attr
        stz     command
        jsr     load_font
        jsr     clear_screen
        jsr     cursor_on       ; turn on the cursor
        rtl

vga_write:
        phx
        phy
        ldx     command
        bne     @cmd
        cmp     #' '
        blt     @ctrl

        pha                     ; stash char to write

        ldx     tivi_cursorx        ; X position in X
        lda     tivi_cursory
        jsr     virt_to_real    ; Get physical row for current cursor position
        asl                     ;  convert it to an offset in the base address tables
        tay                     ;  and stash it in Y

        longm
        txa                     ; transferr to C, clearing high byte
        clc
        adc     sram_base,y     ; add it to the line base
        sta     tivi_addr
        shortm
        pla                     ; now retrieve char
        sta     tivi_data       ; and write it to screen ram
        
        longm
        txa                     ; get cursor X back
        clc
        adc     cram_base,y     ; add it to the line base
        sta     tivi_addr
        shortm
        lda     text_attr
        sta     tivi_data       ; and write attribute byte

        jsr     cursor_forward
        bra     @exit
@ctrl:  cmp     #1
        beq     @attr
        cmp     #CR
        beq     @cr
        cmp     #BS
        beq     @bs
        cmp     #CLS
        beq     @cls
@exit:  ply
        plx
        rtl
@attr:  sta     command
        bra     @exit
@cr:    lda     #COLS-1
        sta     tivi_cursorx            ; fake being at end of line
        jsr     cursor_forward      ; advance to start of next line
        bra     @exit
@bs:    jsr     cursor_backward
        bra     @exit
@cls:   jsr     clear_screen
        bra     @exit
@cmd:   sta     text_attr
        stz     command
        bra     @exit

load_font:
        longmx
        ldaw    #FRAM_START
        sta     tivi_addr
        shortm
        ldxw    #0
@load:  lda     f:vga_font,x
        sta     tivi_data
        inx
        cpxw    #FONT_SIZE
        bne     @load
        shortx
        rts

clear_screen:
        longmx
        ldaw    #SRAM_START
        sta     tivi_addr
        shortm

        ldxw    #ROWS*COLS
        lda     #' '
@sram:  sta     tivi_data
        dex
        bne     @sram

        longm
        ldaw    #CRAM_START
        sta     tivi_addr
        shortm

        ldxw    #ROWS*COLS
        lda     text_attr
@cram:  sta     tivi_data
        dex
        bne     @cram

        shortx

        stz     tivi_cursorx        ; reset cursor to upper left
        stz     tivi_cursory
        stz     tivi_first_row

        rts

cursor_on:
        lda     tivi_ctrl
        ora     #2
        sta     tivi_ctrl
        lda     #'_'
        sta     tivi_cursorch
        rts

cursor_off:
        lda     tivi_ctrl
        and     #%11111101
        sta     tivi_ctrl
        rts

cursor_backward:
        dec     tivi_cursorx
        bpl     @done
        lda     #COLS-1
        sta     tivi_cursorx
        dec     tivi_cursory
        bpl     @done
        stz     tivi_cursorx
        stz     tivi_cursory
@done:  rts

cursor_forward:
        inc     tivi_cursorx
        lda     tivi_cursorx
        cmp     #COLS
        blt     @done
        stz     tivi_cursorx
        inc     tivi_cursory
        lda     tivi_cursory
        cmp     #ROWS
        blt     @done
        jsr     scroll_up
        lda     #ROWS-1
        sta     tivi_cursory
@done:  rts

scroll_up:
        lda     tivi_first_row
        inc
        cmp     #ROWS
        blt     @ok
        lda     #0
@ok:    sta     tivi_first_row

        lda     #ROWS-1
        jsr     virt_to_real
        asl
        tax

        longm
        lda     sram_base,x
        sta     tivi_addr
        shortm

        ldy     #COLS
        lda     #' '
@sram:  sta     tivi_data
        dey
        bne     @sram

        longm
        lda     cram_base,x
        sta     tivi_addr
        shortm

        ldy     #COLS
        lda     text_attr
@cram:  sta     tivi_data
        dey
        bne     @cram

        rts

virt_to_real:
        clc
        adc     tivi_first_row
        cmp     #ROWS
        blt     @ok
        sec
        sbc     #ROWS
@ok:    rts

        .segment "LOWROM"

sram_base:
        .repeat ROWS, i
        .word   SRAM_START+(COLS*i)
        .endrepeat

cram_base:
        .repeat ROWS, i
        .word   CRAM_START+(COLS*i)
        .endrepeat
