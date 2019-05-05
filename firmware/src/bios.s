; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2018 Joshua M. Thompson *
; *******************************

        .include "common.s"
        .include "sys/ascii.s"
        .include "sys/io.s"

        .import uart_init
        .import uart_irq
        .import serial_console_init
        .import vga_console_init
        .import kbd_init
        .import monitor_start
        .import monitor_brk
        .import monitor_nmi
        .import via_init
        .import via_irq
        .import get_console_mode

        .import jros_init

        .import __SYSDP_START__
        .import __SYSSTACK_START__
        .import __SYSSTACK_SIZE__
        .import __SYSVEC_START__

        ;; from buildinfo.s
        .import hw_revision
        .import rom_version
        .import rom_date

        .export sysirq
        .export sysnmi
        .export sysreset

        .export ibuff
        .exportzp ibuffp

        .export console_cls
        .export console_bell
        .export console_read
        .export console_readln
        .export console_reset
        .export console_write
        .export console_writeln

        .export print_hex

DIRECTPAGE = __SYSDP_START__
STACKTOP   = __SYSSTACK_START__ + __SYSSTACK_SIZE__ - 1

        .segment "SYSVEC"

console_reset   := __SYSVEC_START__
console_bell    := console_reset+4
console_cls     := console_bell+4
console_read    := console_cls+4
console_write   := console_read+4

        .segment "BUFFERS"

ibuff:  .res    256

        .segment "ZEROPAGE"

ibuffp: .res    2

        .segment "HIGHROM"

;;
; Interactively read a line of text from the console. On exit, the input
; buffer will contain the newly-read line. The contents of the buffer are
; guaranteed to remain until the next call to this function.
;
; All registers preserved
;
console_readln:
        pha
        xba
        pha
        phx
        ldx     #0
@loop:  jsl     console_read
        bcc     @loop
        cmp     #BS
        beq     @bs
        cmp     #CR
        beq     @eol
        cmp     #' '
        bcc     @loop
        jsl     console_write 
        sta     ibuff,x
        inx
        bne     @loop
        dex
@eol:   stz     ibuff,x
        longm
        ldaw    #ibuff
        sta     ibuffp
        shortm
        plx
        pla
        xba
        pla
        rtl
@bs:    cpx     #0
        beq     @loop
        jsl     console_write 
        dex
        bra     @loop

;;
; Print a null-terminated string up to 255 characters in length.
; The 4-byte address of the string to print should be on the stack,
; MSB first:
;
; PEA   ^str
; PEA   str
; JSL   console_writeln
; ...
;
console_writeln:

; register stack frame
@y_reg   = 1
@x_reg   = @y_reg + 2
@a_reg   = @x_reg + 2
@d_reg   = @a_reg + 2
@s_regsf = @d_reg + 2 - @y_reg

@retaddr = @d_reg + 2
@s_cpusf = 3

@str     = @retaddr + 3
@s_argsf = 4

        longmx
        phd
        pha
        phx
        phy
        tsc
        tcd
        shortmx
        ldy     #0
@loop:  lda     [@str],y
        beq     @exit
        jsl     console_write
        iny
        bne     @loop
@exit:  longmx
        tsc
        clc
        adcw    #@s_regsf+@s_cpusf
        tax                             ; copy from 
        adcw    #@s_argsf
        tay
        ldaw    #@s_regsf+@s_cpusf-1
        mvp     0,0
        tya
        tcs
        ply
        plx
        pla
        pld
        shortmx
        rtl

;;
; Print the 8-bit number in the accumulator in decimal
;
; Accumulator is corrupted on exit
;
print_decimal8:
        ldx     #$ff
        sec
@pr100: inx
        sbc     #100
        bcs     @pr100
        adc     #100
        cpx     #0
        beq     @skip100
        jsr     @digit
@skip100: ldx     #$ff
        sec
@pr10:  inx
        sbc     #10
        bcs     @pr10
        adc     #10
        cpx     #0
        beq     @skip10
        jsr     @digit
@skip10: tax
@digit: pha
        txa
        ora     #'0'
        jsl     console_write
        pla
        rts

;;
; Print the contents of the accumulator as a two-digit hexadecimal number.
;
; On exit:
;
; All registers preserved
;
print_hex:
        pha
        pha
        lsr
        lsr
        lsr
        lsr
        jsr     @digit
        pla
        and     #$0f
        jsr     @digit
        pla
        rtl
@digit: and     #$0f
        ora     #'0'
        cmp     #'9'+1
        blt     @print
        adc     #6
@print: jsl     console_write
        rts

; Print the boot banner to the console
;
startup_banner:
        ldx     #0
@loop:  lda     #$01
        jsl     console_write
        lda     f:@colors,x
        jsl     console_write
        puts    @bar
        inx
        cpx     #16
        bne     @loop

        putc    #$01
        putc    #$0F        ; reset to white text

        ; top line of box
        jsr     @indent
        putc    #$DA
        puts    @line
        putc    #$BF
        putc    #CR

        ; System ID
        jsr     @indent
        puts    @sysid

        ; HW Revision
        jsr     @indent
        puts    @hwrev
        lda     hw_revision
        jsr     print_decimal8
        puts    @hwrev2

        ; ROM Version
        jsr     @indent
        puts    @romver
        lda     rom_version
        lsr
        lsr
        lsr
        lsr
        jsr     print_decimal8
        putc    #'.'
        lda     rom_version
        and     #$0f
        jsr     print_decimal8
        putc    #' '
        putc    #'('
        puts    rom_date
        putc    #')'
        puts    @romver2

        ; bottom line of box
        jsr     @indent
        putc    #$C0
        puts    @line
        putc    #$D9
        putc    #CR

        puteol
        puteol

        rtl

@indent:
        ldx     #(80-32)/2
@indent2:
        putc    #' '
        dex
        bne     @indent2
        rts

@colors: .byte  $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $01

@line:  .repeat 30
        .byte   $C4
        .endrepeat
        .byte   0

@sysid:  .byte   $B3, " COLE-2 Single Board Computer ", $B3, CR, 0
@hwrev:  .byte   $B3, " Hardware Revision ", 0
@hwrev2: .byte  "          ", $B3, CR, 0

@romver:  .byte   $B3, " ROM Version ", 0
@romver2: .byte   " ", $B3, CR, 0

@bar:   .byte   $F0, $F0, $F0, $F0, $F0, 00

syscall_table:
        .faraddr    console_read-1
        .faraddr    console_write-1
        .faraddr    console_readln-1
        .faraddr    console_writeln-1

syscall_max = (*-syscall_table)/2

syscall:
        longmx
        pha
        phx
        phy
        phd
        ldaw    #DIRECTPAGE
        tcd
        shortmx
        cli
        txa
        and     #255
        beq     @error
        cmp     #syscall_max
        bge     @error
        asl
        tax
        ; do it

        pha
        pld
        ply
        plx
        pla
        rti
@error: brk     $00

        .segment "LOWROM"

sysentry:
        jml     syscall

sysreset:
        sei
        cld
        clc
        xce

        longm
        ldaw    #DIRECTPAGE
        tcd
        ldaw    #STACKTOP
        tcs
        shortm

        jsr     via_init
        jsr     uart_init
        jsr     kbd_init

        jsr     get_console_mode
        bne     @serial

        jsl     vga_console_init
        bra     @cont

@serial:
        jsl     serial_console_init

@cont:  cli

        jsl     console_reset
        jsl     console_cls
        jsl     startup_banner

        ;jsl     jros_init        ; Initialize JR/OS
        ;jml     LAB_COLD        ; ... and drop the user into BASIC
        jml     monitor_start

sysnmi:
        rep     #$30
        phb
        phd
        pha
        phx
        phy
        ldaw    #DIRECTPAGE
        tcd
        sep     #$30
        cli
        jml     monitor_nmi

sysirq: 
        rep     #$30
        phb
        phd
        pha
        phx
        phy
        ldaw    #DIRECTPAGE
        tcd
        sep     #$30
        pha     ; assumes low byte of DIRECTPAGE is $00
        plb

        jsr     via_irq
        jsr     uart_irq

        rep     #$30
        ply
        plx
        pla
        pld
        plb

        rti

sysbrk:
        rep     #$30
        phb
        phd
        pha
        phx
        phy
        ldaw    #DIRECTPAGE
        tcd
        sep     #$30
        cli
        jml     monitor_brk

        .segment "HWVECTORS"

        .addr   sysentry    ; $FFE4 (cop native)
        .addr   sysbrk      ; $FFE6 (brk native)
        .addr   sysreset    ; $FFE8 (abort native)
        .addr   sysnmi      ; $FFEA (nmi native)
        .addr   0           ; $FFEC (not used)
        .addr   sysirq      ; $FFEE (irq native)
        .addr   0           ; $FFF0 (not used)
        .addr   0           ; $FFF2 (not used)
        .addr   sysreset    ; $FFF4 (cop emulation)
        .addr   0           ; $FFF6 (not used)
        .addr   sysreset    ; $FFF8 (abort emulation)
        .addr   sysreset    ; $FFFA (nmi emulation)
        .addr   sysreset    ; $FFFC (reset)
        .addr   sysreset    ; $FFFE (irq emulation)
