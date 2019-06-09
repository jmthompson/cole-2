; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2018 Joshua M. Thompson *
; *******************************

        .include "common.s"
        .include "sys/console.s"

        .export vga_reset
        .export vga_write

        .import kbd_read

BELL     =  $07
LBRACKET =  '['

DEFAULT_COLOR = $0F     ; white on black

ROWS      = 25
COLS      = 80
ROW_SIZE  = COLS * 2
TEXT_SIZE = ROWS * ROW_SIZE

vga_vram    := $f030
vga_status  := $f031
vga_reg     := $f031

        .segment "ZEROPAGE"

command:    .res    1
text_attr:  .res    1
cursor_x:   .res    1
cursor_y:   .res    1
vram_addr:  .res    2

        .segment "BUFFERS"

line_buffer: .res   ROW_SIZE

        .segment "HIGHROM"

vga_reset:
        lda     #DEFAULT_COLOR
        sta     text_attr
        stz     command
        stz     cursor_x
        stz     cursor_y
        jsr     cursor_on       ; turn on the cursor
        jsr     move_cursor     ; move it to 0,0
        jsr     clear_screen
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
        sta     vga_vram
        lda     text_attr
        sta     vga_vram
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

clear_screen:
        ldx     #1              ; vram lo
        lda     #<(TEXT_SIZE-1)
        jsr     set_register
        inx                     ; vram hi
        lda     #>(TEXT_SIZE-1)
        jsr     set_register
        ldy     #ROWS
@row:   ldx     #COLS
@col:   lda     #' '
        sta     vga_vram
        lda     text_attr
        sta     vga_vram
        dex
        bne     @col
        dey
        bne     @row
        rts

cursor_on:
        ldx     #3      ; cursor control reg
        lda     #7      ; cursor on, blinking underline
        jmp     set_register

cursor_off:
        ldx     #3      ; cursor control reg
        lda     #0      ; no cursor
        jmp     set_register

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
; Trashes A,X
;
move_cursor:
        ldx     #4      ; cursor X register
        lda     cursor_x
        jsr     set_register
        ldx     #5      ; cursor Y register
        lda     cursor_y
        jmp     set_register

read_line:
        ldx     #0
@loop:  lda     vga_vram
        sta     line_buffer,x
        inx
        cpx     #ROW_SIZE
        bne     @loop
        rts

write_line:
        ldx     #0
@loop:  lda     line_buffer,x
        sta     vga_vram
        inx
        cpx     #ROW_SIZE
        bne     @loop
        rts

blank_line:
        ldx     #0
        lda     text_attr
        xba
        lda     #' '
@loop:  sta     vga_vram
        xba
        sta     vga_vram
        xba
        inx
        cpx     #COLS
        bne     @loop
        rts

scroll_up:
        ldy     #1
@line:  ldx     #0
        phy
        phy
        jsr     calc_vram_ptr
        jsr     read_line
        ply
        dey
        ldx     #0
        jsr     calc_vram_ptr
        jsr     write_line
        ply
        iny
        cpy     #ROWS
        bne     @line
        ldx     #0
        ldy     #ROWS-1
        jsr     calc_vram_ptr
        jmp     blank_line

;;
; Calculate VRAM address of col/row in X/Y
;
; Trashes C,X,Y
;
calc_vram_ptr:
        longm
        txa
        asl
        sta     vram_addr
        tya
        asl
        tay
        lda     line_base,y
        sec
        sbc     vram_addr
        sta     vram_addr
        shortm
        ; fall through

;;
; Set VRAM pointer to current cursor position
;
; loc = 2 * ((row * 80) + col)
;
; Trashes C, X
;
set_vram_ptr:
        ldx     #1          ; vram ptr lo
        lda     vram_addr
        jsr     set_register
        inx                 ; vram ptr hi
        lda     vram_addr+1
        ; fall through

;;
; Store value in A to register in X
;
set_register:
        sei
        stx     vga_reg
        sta     vga_reg
        cli
        rts

        .segment "LOWROM"

line_base:
        .repeat ROWS, i
        .word   TEXT_SIZE-1-(ROW_SIZE*i)
        .endrepeat
