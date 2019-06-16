; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2018 Joshua M. Thompson *
; *******************************

        .include "common.s"

        .import kbd_handler

        .export via_init
        .export via_irq
        .export set_led
        .export wait_ms
        .export spi_select
        .export spi_deselect
        .export spi_transfer

PB_ACT_LED = $80        ; Activity LED
PB_CONSOLE = $40        ; Console select jumper

PCR     = %00101001     ; CB2 indep neg edge, CB1 neg edge, CA2 handshake, CA1 positive edge
INT_CA1 = %00000010     ; IER/IFR CA1 flag

; Port B pin assignments
PORTB_MISO  = $40
PORTB_EN    = $20
PORTB_SS    = $1C
PORTB_MOSI  = $02
PORTB_SCLK  = $01

; VIA register numbers
via_portb  = $00
via_porta  = $01
via_ddrb   = $02
via_ddra   = $03
via_t1cl   = $04
via_t1ch   = $05
via_t1ll   = $06
via_t1lh   = $07
via_t2cl   = $08
via_t2ch   = $09
via_sr     = $0A
via_acr    = $0B
via_pcr    = $0C
via_ifr    = $0D
via_ier    = $0E
via_portax = $0F

via1_base := $F000
via2_base := $F010

        .segment "ZEROPAGE"

spi_byte:   .res 1

        .segment "LOWROM"

        .a8
        .i8

via_init:
        ; Disable all interrupts
        lda     #$7F
        sta     via1_base+via_ier
        sta     via2_base+via_ier

        ; Disable timers & shift registers
        stz     via1_base+via_acr
        stz     via2_base+via_acr

        ; VIA 1 ports A & B
        stz     via1_base+via_porta
        stz     via1_base+via_portb
        stz     via1_base+via_ddra
        lda     #PB_ACT_LED
        sta     via1_base+via_ddrb

        ; VIA 2 ports A & B
        stz     via2_base+via_porta
        stz     via2_base+via_portb
        stz     via2_base+via_ddra
        stz     via2_base+via_ddrb

        ; Enable CA1 interrupt
        lda     #INT_CA1|$80
        sta     via1_base+via_ier
        lda     #PCR
        sta     via1_base+via_pcr

        ; This lowers CA2 to get things going
        lda     via1_base+via_porta

        rts

via_irq:
        lda     via1_base+via_ifr
        bit     #INT_CA1
        beq     @exit

        lda     via1_base+via_porta
        jsr     kbd_handler

        ; TODO other interrupts, including via 2
 
@exit:  rts

;;
; Set the status of the activity LED to the value
; in A. This should be called with interrupts
; disabled to avoid corrupting the port B register.
;
; Preserves X,Y and trashes A.
;
set_led:
        cmp     #0
        beq     @clr
        lda     via1_base+via_portb
        ora     #PB_ACT_LED
        sta     via1_base+via_portb
        rts
@clr:   lda     via1_base+via_portb
        and     #~PB_ACT_LED&$FF
        sta     via1_base+via_portb
        rts

; Wait up to 15ms (assuming 4MHz phi2 clock), with about 3% error because
; we use a x4096 multiplier instead of x4000.
;
; Inputs:
; A = number of ms to wait

wait_ms:
        and     #$0f        ; can't wait more than about 15 ms
        asl
        asl
        asl
        asl                 ; x4096 because this will be the upper byte
        stz     via1_base+via_t2cl
        sta     via1_base+via_t2ch
@wait:  lda     via1_base+via_ifr
        and     #$20
        beq     @wait
        rts

; Perform a single byte transfer to the specified SPI device.
;
; Inputs:
; A = byte to transmit
;
; Output:
; A = byte receiv,ed

spi_transfer:
        phx
        sta     spi_byte
        ldx     #8                  ; do 8 bits
@loop:  lda     via1_base+via_portb
        and     #<~PORTB_MOSI
        bit     spi_byte            ; bit 7 => neg bit
        bpl     @out
        ora     #PORTB_MOSI
@out:   sta     via1_base+via_portb ; set MOSI
        inc     via1_base+via_portb ; raise SCLK
        clc
        bit     via1_base+via_portb ; MISO => overflow
        bvc     @shift
        sec 
@shift: rol     spi_byte            ; rotate MOSI out, and MISO (via carry) in
        dec     via1_base+via_portb ; lower SCLK
        dex
        bne     @loop
        plx
        lda     spi_byte
        rts

; Open communications to the selected SPI device
;
; Inputs:
; X = device to select (0-4)
;
; Outputs:
; None

spi_select:
        pha
        txa
        and     #7
        asl
        asl
        ora     #PORTB_EN
        ora     via1_base+via_portb
        sta     via1_base+via_portb
        pla
        rts

; Deselect the currently selected SPI device

spi_deselect:
        pha
        lda     via1_base+via_portb
        and     #<~(PORTB_EN|PORTB_SS)
        sta     via1_base+via_portb
        pla
        rts
