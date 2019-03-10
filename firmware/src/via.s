; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2018 Joshua M. Thompson *
; *******************************

        .include "common.s"

        .export via_init
        .export via_irq
        .export wait_ms
        .export set_led
        .export spi_select
        .export spi_deselect
        .export spi_transfer

        .importzp jiffies

; Port B bit assignments
SPI_MISO     = $40
SPI_EN       = $20
SPI_SS       = $1C
SPI_MOSI     = $02
SPI_SCLK     = $01

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

spi_byte:   .res    1

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
        lda     #$80
        sta     via1_base+via_portb
        ;stz     via1_base+via_portb
        lda     #SPI_EN
        sta     via1_base+via_ddra
        ;stz     via1_base+via_ddra
        lda     #SPI_EN|SPI_SS|SPI_MOSI|SPI_SCLK|$80
        sta     via1_base+via_ddrb

        ; VIA 2 ports A & B
        stz     via2_base+via_porta
        stz     via2_base+via_portb
        stz     via2_base+via_ddra
        stz     via2_base+via_ddrb

        rts

via_irq:
        bit     via1_base+via_ifr
        bpl     @exit

        ; TODO handle this, and add via 2 once it exists
 
@exit:  rts

set_led:
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
;        stz     via1_base+via_t2cl
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
        ldx     #8          ; do 8 bits
@loop:  lda     via1_base+via_portb
        and     #<~SPI_MOSI
        bit     spi_byte    ; bit 7 => neg bit
        bpl     @out
        ora     #SPI_MOSI
@out:   sta     via1_base+via_portb  ; set MOSI
        inc     via1_base+via_portb  ; raise SCLK
        clc
        bit     via1_base+via_portb  ; MISO => overflow
        bvc     @shift
        sec 
@shift: rol     spi_byte    ; rotate MOSI out, and MISO (via carry) in
        dec     via1_base+via_portb  ; lower SCLK
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
        ora     #SPI_EN
        ora     via1_base+via_portb
        sta     via1_base+via_portb
        pla
        rts

; Deselect the currently selected SPI device

spi_deselect:
        pha
        lda     via1_base+via_portb
        and     #<~(SPI_EN|SPI_SS)
        sta     via1_base+via_portb
        pla
        rts
