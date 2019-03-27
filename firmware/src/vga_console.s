; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2018 Joshua M. Thompson *
; *******************************

        .include "common.s"
        .include "sys/console.s"

        .export vga_console_init

        .import getc_seriala
        .import __SYSDP_START__

        .segment "ZEROPAGE"

text_color: .res    1
cursor_x:   .res    1
cursor_y:   .res    1
temp:       .res    2

        .segment "HIGHROM"

BELL     =  $07
LBRACKET =  '['

DEFAULT_COLOR = $0F     ; white on black

ROWS = 25
COLS = 80

vga_vram    := $f030
vga_status  := $f031
vga_reg     := $f031

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
        ldx     #0              ; vram lo
        lda     #0
        jsr     set_register
        inx                     ; vram hi
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
        pha
        jsr     set_vram_ptr
        pla
        sta     vga_vram
        lda     text_color
        sta     vga_vram
        jsr     advance_cursor
        bra     @exit
@ctrl:  cmp     #CR
        bne     @exit
        lda     #COLS-1
        sta     cursor_x            ; fake being at end of line
        jsr     advance_cursor      ; advance to start of next line
@exit:  longm
        pld
        ply
        plx
        pla
        shortm
        rtl

cursor_on:
        ldx     #2      ; cursor control reg
        lda     #7      ; cursor on, blinking underline
        jmp     set_register

cursor_off:
        ldx     #2      ; cursor control reg
        lda     #0      ; no cursor
        jmp     set_register

advance_cursor:
        inc     cursor_x
        lda     cursor_x
        cmp     #COLS
        blt     move_cursor
        stz     cursor_x
        inc     cursor_y
        lda     cursor_y
        cmp     #ROWS
        blt     move_cursor
        stz     cursor_y        ; TODO scroll screen instead
        ; fall through

;;
; Move cursor to cursor_x,cursor_y
;
; Trashes A,X
;
move_cursor:
        ldx     #3      ; cursor X register
        lda     cursor_x
        jsr     set_register
        ldx     #4      ; cursor Y register
        lda     cursor_y
        jmp     set_register

;;
; Set VRAM pointer to current cursor position
;
; loc = (row * 160) + (col * 2)
;
; Trashes C, X
;
set_vram_ptr:
        longm
        ldx     cursor_y
        txa                 ; automatically sets upper byte to $00
        asl
        asl
        asl
        asl
        asl                 ; x32
        pha
        asl
        asl                 ; x128
        sta     temp
        pla
        clc
        adc     temp        ; x32 + x128 = x160
        sta     temp        ; save row base
        ldx     cursor_x
        txa
        asl                 ; x2 since each char is 2 bytes
        clc
        adc     temp
        sta     temp
        shortm
        ldx     #0          ; vram ptr lo
        lda     temp
        jsr     set_register
        inx                 ; vram ptr hi
        lda     temp+1
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
