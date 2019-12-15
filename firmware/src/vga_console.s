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

ROWS      = 25
COLS      = 80
ROW_SIZE  = COLS * 2
SCROLL_SIZE = (ROWS-1)*ROW_SIZE

FONT_ADDR = $3000       ; Location of the font in video RAM
FONT_SIZE = $1000       ; Size of the font data

tivi_data       = $00   ; VRAM r/w register
tivi_addr       = $01   ; VRAM address (16-bit)
tivi_ctrl       = $03   ; Control register
tivi_cursorch   = $04   ; Cursor char
tivi_cursorx    = $05   ; Cursor X pos
tivi_cursory    = $06   ; Cursor Y pos
tivi_clkdiv     = $07   ; Phi2 clock divisor

tivi_base := $F060

        .segment "ZEROPAGE"

command:    .res    1
text_attr:  .res    1
cursor_x:   .res    1
cursor_y:   .res    1

        .segment "BUFFERS"

line_buffer: .res   ROW_SIZE*ROWS

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
        ldx     cursor_x
        ldy     cursor_y
        pha
        jsr     calc_vram_ptr
        pla
        sta     tivi_base+tivi_data
        lda     text_attr
        sta     tivi_base+tivi_data
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
        sta     cursor_x            ; fake being at end of line
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
        ldaw    #FONT_ADDR
        sta     tivi_base+tivi_addr
        shortm
        ldxw    #0
@load:  lda     f:vga_font,x
        sta     tivi_base+tivi_data
        inx
        cpxw    #FONT_SIZE
        bne     @load
        shortx
        rts

clear_screen:
        stz     tivi_base+tivi_addr
        stz     tivi_base+tivi_addr+1
        lda     text_attr
        xba
        lda     #' '
        ldy     #ROWS
@row:   ldx     #COLS
@col:   sta     tivi_base+tivi_data
        xba
        sta     tivi_base+tivi_data
        xba
        dex
        bne     @col
        dey
        bne     @row
        stz     cursor_x
        stz     cursor_y
        jmp     move_cursor         ; reset cursor to upper left

cursor_on:
        lda     tivi_base+tivi_ctrl
        ora     #2
        sta     tivi_base+tivi_ctrl
        lda     #'_'
        sta     tivi_base+tivi_cursorch
        rts

cursor_off:
        lda     tivi_base+tivi_ctrl
        and     #%11111101
        sta     tivi_base+tivi_ctrl
        rts

cursor_backward:
        dec     cursor_x
        bpl     move_cursor
        lda     #COLS-1
        sta     cursor_x
        dec     cursor_y
        bpl     move_cursor
        stz     cursor_x
        stz     cursor_y
        bra     move_cursor

cursor_forward:
        inc     cursor_x
        lda     cursor_x
        cmp     #COLS
        blt     move_cursor
        stz     cursor_x
        inc     cursor_y
        lda     cursor_y
        cmp     #ROWS
        blt     move_cursor
        jsr     scroll_up
        lda     #ROWS-1
        sta     cursor_y
        ; fall through

;;
; Move cursor to cursor_x,cursor_y
;
; Trashes A
;
move_cursor:
        lda     cursor_x
        sta     tivi_base+tivi_cursorx
        lda     cursor_y
        sta     tivi_base+tivi_cursory
        rts

scroll_up:
        longx
        ldx     line_base+2
        stx     tivi_base+tivi_addr   ; Read starting at line 1
        ldxw    #SCROLL_SIZE
@read:  lda     tivi_base+tivi_data
        sta     line_buffer,x
        dex
        bne     @read
        stx     tivi_base+tivi_addr   ; Write back starting at line 0
        ldxw    #SCROLL_SIZE
@write: lda     line_buffer,x
        sta     tivi_base+tivi_data
        dex
        bne     @write
        shortx
        lda     text_attr
        xba
        lda     #' '
        ldx     #COLS
@blank: sta     tivi_base+tivi_data
        xba
        sta     tivi_base+tivi_data
        xba
        dex
        bne     @blank
        rts

;;
; Calculate VRAM address of col/row in X/Y
;
; Trashes C,X,Y
;
calc_vram_ptr:
        longm
        tya
        asl
        tay
        txa
        asl
        clc
        adc     line_base,y
        sta     tivi_base+tivi_addr
        shortm
        rts

        .segment "LOWROM"

line_base:
        .repeat ROWS, i
        .word   ROW_SIZE*i
        .endrepeat
