; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2018 Joshua M. Thompson *
; *******************************

        .include "common.s"
        .include "sys/console.s"

        .export vga_console_init

        .import getc_seriala
        .import __SYSDP_START__

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

text_color: .res    1
cursor_x:   .res    1
cursor_y:   .res    1
vram_addr:  .res    2

        .segment "BUFFERS"

line_buffer: .res   ROW_SIZE

        .segment "HIGHROM"

vga_console_init:
        lda     vga_status
        cmp     #$42
        bne     vga_console_init

        lda     #$5c
        sta     console_bell
        sta     console_cls
        sta     console_reset
        sta     console_read
        sta     console_write

        lda     #<vga_bell
        sta     console_bell+1
        lda     #>vga_bell
        sta     console_bell+2
        lda     #^vga_bell
        sta     console_bell+3

        lda     #<vga_cls
        sta     console_cls+1
        lda     #>vga_cls
        sta     console_cls+2
        lda     #^vga_cls
        sta     console_cls+3

        lda     #<vga_reset
        sta     console_reset+1
        lda     #>vga_reset
        sta     console_reset+2
        lda     #^vga_reset
        sta     console_reset+3

        lda     #<vga_read
        sta     console_read+1
        lda     #>vga_read
        sta     console_read+2
        lda     #^vga_read
        sta     console_read+3

        lda     #<vga_write
        sta     console_write+1
        lda     #>vga_write
        sta     console_write+2
        lda     #^vga_write
        sta     console_write+3

        rtl

vga_bell:
        lda     #BELL
        rtl

vga_cls:
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
        lda     text_color
        sta     vga_vram
        dex
        bne     @col
        dey
        bne     @row
        rtl

vga_reset:
        lda     #DEFAULT_COLOR
        sta     text_color
        stz     cursor_x
        stz     cursor_y
        jsr     cursor_on       ; turn on the cursor
        jsr     move_cursor     ; move it to 0,0
        rtl

vga_read:
        jml     getc_seriala

vga_write:
        longm
        pha
        phx
        phy
        phd
        ldaw    #__SYSDP_START__
        tcd
        shortm
        lda     5,s
        cmp     #' '
        blt     @ctrl
        ldx     cursor_x
        ldy     cursor_y
        jsr     calc_vram_ptr
        lda     5,s
        sta     vga_vram
        lda     text_color
        sta     vga_vram
        jsr     cursor_forward
        bra     @exit
@ctrl:  cmp     #CR
        beq     @cr
        cmp     #BS
        beq     @bs
@exit:  longm
        pld
        ply
        plx
        pla
        shortm
        rtl
@cr:    lda     #COLS-1
        sta     cursor_x            ; fake being at end of line
        jsr     cursor_forward      ; advance to start of next line
        bra     @exit
@bs:    jsr     cursor_backward
        bra     @exit

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
        stz     cursor_x
        dec     cursor_y
        bpl     move_cursor
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
        lda     text_color
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
        jsr     calc_vram_ptr
        jsr     read_line
        dey
        ldx     #0
        jsr     calc_vram_ptr
        jsr     write_line
        iny
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
; Trashes C,X
;
calc_vram_ptr:
        longm
        tya                 ; automatically sets upper byte to $00
        asl
        asl
        asl
        asl                 ; x16
        pha
        asl
        asl                 ; x64
        sta     vram_addr
        pla
        clc
        adc     vram_addr   ; x16 + x64 = x80
        sta     vram_addr   ; save row base
        txa
        clc
        adc     vram_addr
        asl                 ; x2 since each char is 2 bytes
        sta     vram_addr
        ldaw    #TEXT_SIZE-1
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
