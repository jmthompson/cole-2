; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2018 Joshua M. Thompson *
; *******************************

        .include "common.s"
        .include "sys/ascii.s"
        .include "sys/io.s"

        .import uart_init
        .import uart_irq
        .import cic_init
        .import monitor_start
        .import monitor_brk
        .import monitor_nmi
        .import spi_init
        .import spi_irq
        .import via_init
        .import via_irq
        .import device_manager_init

        .import console_init
        .import console_attach
        .import console_reset
        .import console_read
        .import console_readln
        .import console_write
        .import console_writeln

        .import install_device
        .import remove_device
        .import find_device
        .import call_device

        .import getc_seriala
        .import putc_seriala
        .import getc_serialb
        .import putc_serialb

        .import jros_init

        .import __SYSDP_START__
        .import __SYSSTACK_START__
        .import __SYSSTACK_SIZE__

        ;; from buildinfo.s
        .import hw_revision
        .import rom_version
        .import rom_date

STACKTOP    = __SYSSTACK_START__ + __SYSSTACK_SIZE__ - 1

; Processor status register bits
PREG_I      =   %00000100
PREG_C      =   %00000001

        .segment "SYSDATA": far

syscall_trampoline: .res 4

        .segment "HIGHROM"

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
        call    SYS_CONSOLE_WRITE
        pla 
        rts
;;
;
; Print the boot banner to the console
;
startup_banner:
        ldx     #0
@loop:  lda     #$01
        call    SYS_CONSOLE_WRITE
        lda     f:@colors,x
        call    SYS_CONSOLE_WRITE
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

read_seriala:
        set_kernel_dp
        jsl     getc_seriala
        pld
        rtl

write_seriala:
        set_kernel_dp
        jsl     putc_seriala
        pld
        rtl

read_serialb:
        set_kernel_dp
        jsl     getc_serialb
        pld
        rtl

write_serialb:
        set_kernel_dp
        jsl     putc_serialb
        pld
        rtl

.macro  syscall     func, psize
        .faraddr    func
        .byte       psize
.endmacro

syscall_table:
        syscall     console_attach, 0
        syscall     console_read, 0
        syscall     console_write, 0
        syscall     console_readln, 4
        syscall     console_writeln, 4
        syscall     read_seriala, 0
        syscall     write_seriala, 0
        syscall     read_serialb, 0
        syscall     write_serialb, 0
        syscall     install_device, 4
        syscall     remove_device, 0
        syscall     find_device, 4
        syscall     call_device, 4

syscall_max = (*-syscall_table)/4

        .segment "LOWROM"

;;
; COP handler; dispatches to the syscall indicated by the signature byte
;
syscall_dispatch:

; syscall stack frame
@copsig  := 1                   ; Pointer to COP signature byte
@cf_size := @copsig + 4         ; Size of caller's stack frame (size of parameters)
@y_reg   := @cf_size + 2        ; Y
@x_reg   := @y_reg + 2          ; X
@a_reg   := @x_reg + 2          ; A
@d_reg   := @a_reg + 2          ; D
@db_reg  := @d_reg + 2          ; DB
@sc_size := @db_reg + 1 - @copsig

; COP instruction stack frame
@p_reg   := @db_reg + 1         ; P
@pc_reg  := @p_reg  + 1         ; PC
@pb_reg  := @pc_reg + 2         ; PB
@cop_size := @pb_reg + 1 - @p_reg

; Start of parameters passed by caller
@params  := @pb_reg + 1

        longmx

        phb
        phd
        pha
        phx
        phy
        pha                     ; Make space for our local variables
        pha                     ; """
        pha                     ; """
        tsc
        tcd                     ; DP now points to our local stack frame

        shortm

        lda     #BIOS_DB
        pha
        plb                     ; Set kernel data bank

        lda     @p_reg
        and     #~PREG_C&$FF    ; clear carry
        sta     @p_reg
        bit     #PREG_I         ; were interrupts disabled?
        bne     @noirq
        cli                     ; no, so re-enable them

@noirq: longm
        lda     @pc_reg
        dec
        sta     @copsig
        shortm
        lda     @pb_reg
        sta     @copsig+2

        lda     [@copsig]
        cmp     #syscall_max
        bge     @error
        longm
        andw    #255
        asl
        asl
        tax

        shortm
        lda     f:syscall_table+3,x     ; Parameter frame size
        sta     @cf_size
        stz     @cf_size+1

        lda     f:syscall_table+2,x     ; Bank byte of handler
        sta     syscall_trampoline+3
        longm
        lda     f:syscall_table,x       ; Bank address of handler
        sta     syscall_trampoline+1
        phd                             ; save our DP for after dispatch
        lda     @a_reg                  ; Grab A; it might be a parameter
        pha                             ; save it while we switch direct pages
        tdc
        clc
        adcw    #@sc_size+@cop_size
        tcd
        pla                             ; restore A from caller

        shortmx
        jsl     syscall_trampoline
        pld
        sta     @a_reg                  ; return value of A to caller
        bcc     @noerr
        lda     @p_reg
        ora     #PREG_C                 ; set carry on return to caller
        sta     @p_reg
        
@noerr: longmx
        lda     @cf_size
        beq     @nocopy

        tsc
        clc
        adcw    #@sc_size+@cop_size
        tax                             ; copy from end of cop stack frame
        adc     @cf_size
        tay                             ; copy to end of params frame
        ldaw    #@sc_size+@cop_size-1   ; copy local + cop frame
        mvp     0,0                     ; remove parameters
        tya                             ; Y will end up one byte lower than the last byte written
        tcs                             ;  which is exactly where our stack frame starts

@nocopy:
        ply                             ; remove space used for local vars
        ply                             ; """
        ply                             ; """
        ply
        plx
        pla
        pld
        plb
        rti
@error: brk     $00

sysreset:
        sei
        cld
        clc
        xce

        longm
        ldaw    #BIOS_DP
        tcd
        ldaw    #STACKTOP
        tcs
        shortm

        lda     #BIOS_DB
        pha
        plb

        lda     #$5C                ; JML $xxyyzz
        sta     syscall_trampoline  ; Init syscall trampoline vector

        jsl     device_manager_init
        
        jsr     via_init
        jsr     spi_init
        jsr     uart_init
        jsr     cic_init

        cli

        jsl     console_init
        jsl     startup_banner

        ;jsl     jros_init        ; Initialize JR/OS
        ;jml     LAB_COLD        ; ... and drop the user into BASIC
        jml     monitor_start

sysnmi:
        longmx
        phb
        phd
        pha
        phx
        phy
        ldaw    #BIOS_DP
        tcd
        shortmx
        lda     #BIOS_DB
        pha
        plb
        cli
        jml     monitor_nmi

sysirq: 
        rep     #$30
        phb
        phd
        pha
        phx
        phy
        ldaw    #BIOS_DP
        tcd
        sep     #$30
        pha                 ; Low byte of BIOS_DP will always be $00
        plb                 ; Set interrupt data bank

        jsr     via_irq
        jsr     spi_irq
        jsr     uart_irq

        rep     #$30
        ply
        plx
        pla
        pld
        plb

        rti

sysbrk:
        longmx
        phb
        phd
        pha
        phx
        phy
        ldaw    #BIOS_DP
        tcd
        shortmx
        lda     #BIOS_DB
        pha
        plb
        cli
        jml     monitor_brk

        .segment "HWVECTORS"

        .addr   syscall_dispatch    ; $FFE4 (cop native)
        .addr   sysbrk              ; $FFE6 (brk native)
        .addr   sysreset            ; $FFE8 (abort native)
        .addr   sysnmi              ; $FFEA (nmi native)
        .addr   0                   ; $FFEC (not used)
        .addr   sysirq              ; $FFEE (irq native)
        .addr   0                   ; $FFF0 (not used)
        .addr   0                   ; $FFF2 (not used)
        .addr   sysreset            ; $FFF4 (cop emulation)
        .addr   0                   ; $FFF6 (not used)
        .addr   sysreset            ; $FFF8 (abort emulation)
        .addr   sysreset            ; $FFFA (nmi emulation)
        .addr   sysreset            ; $FFFC (reset)
        .addr   sysreset            ; $FFFE (irq emulation)
