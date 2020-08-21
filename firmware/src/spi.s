; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2019 Joshua M. Thompson *
; *******************************

        .include "common.s"

        .export spi_init
        .export spi_irq
        .export spi_select
        .export spi_deselect
        .export spi_transfer

        .import cic_irq

; VIA register numbers
spi_data   = $00    ; (R/W) SPI data register
spi_status = $01    ; (R) SPI status register
spi_ctrl   = $01    ; (R/W) SPI control register
spi_isr    = $02    ; (R) interrupt status register
spi_clk    = $02    ; (W) SPI clock control
spi_sctrl  = $03    ; (R/W) slave select / interrupt enable

spi_base := $F020

; Bits in the control/status register
SPI_TC      = $80   ; transmission complete
SPI_IER     = $40   ; interrupt enable
SPI_BSY     = $20   ; busy flag
SPI_FRX     = $10   ; Fast receive mode enable
SPI_TMO     = $08   ; Tri-state MOSI enable
SPI_ECE     = $04   ; External clock enable
SPI_CPOL    = $02   ; Clock polarity
SPI_CPHA    = $01   ; Clock phase

SPI_INT0    = $10   ; /INT0
SPI_INT1    = $20   ; /INT1
SPI_INT2    = $40   ; /INT2
SPI_INT3    = $80   ; /INT3
SPI_SS0     = $01   ; /SS0 (keyboard)
SPI_SS1     = $02   ; /SS1 (SD card)
SPI_SS2     = $04   ; /SS2
SPI_SS3     = $08   ; /SS3

        .segment "LOWROM"

        .a8
        .i8

spi_init:
        ; Enable interrupts, no FRX, no tristate, SPI mode 0, use external clock (3.6864 MHz)
        lda     #SPI_ECE|SPI_IER
        sta     spi_base+spi_ctrl

        ; Clock is phi2/2
        stz     spi_base+spi_clk

        ; Disable all slaves and enable kbd controller interrupt
        lda     #SPI_INT0|SPI_SS0|SPI_SS1|SPI_SS2|SPI_SS3
        sta     spi_base+spi_sctrl

        rts

spi_irq:
        lda     #SPI_INT0
        bit     spi_base+spi_isr
        beq     @exit

        ; TODO: handle other interrupts
        jsr     cic_irq
 
@exit:  rts

;;
; Select slave 0-3. Slave number is in A
;
spi_select:
        phx
        and     #$03
        tax
        lda     spi_base+spi_sctrl  ; get current value
        and     #$F0                ; mask off slave selects
        ora     @slave,X            ; and select the new slave
        sta     spi_base+spi_sctrl
        plx
        rts
@slave: .byte   SPI_SS0^$0F
        .byte   SPI_SS1^$0F
        .byte   SPI_SS2^$0F
        .byte   SPI_SS3^$0F

;;
; Deselect all slaves
;
spi_deselect:
        pha
        lda     spi_base+spi_ctrl
        ora     #SPI_SS0|SPI_SS1|SPI_SS2|SPI_SS3
        sta     spi_base+spi_ctrl
        pla
        rts

;;
; Send byte in A to the currently selected slave,
; and return the received byte back in A
;
spi_transfer:
        sta     spi_base+spi_data   ; send byte
        lda     #SPI_TC
@wait:  bit     spi_base+spi_status
        beq     @wait               ; wait for TC=1
        lda     spi_base+spi_data   ; get received byte
        rts
