; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2018 Joshua M. Thompson *
; *******************************

        .include "common.s"

        .export via_init
        .export via_irq
        .export set_led
        .export get_console_mode

        .import kbd_handler

PB_ACT_LED = $80        ; Activity LED
PB_CONSOLE = $40        ; Console select jumper

PCR     = %00101001     ; CB2 indep neg edge, CB1 neg edge, CA2 handshake, CA1 positive edge
INT_CA1 = %00000010     ; IER/IFR CA1 flag

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
; Return the status of the console select jumper. On
; exit A will be non-zero if the jumper is installed.
;
get_console_mode:
        lda     via1_base+via_portb
        and     #PB_CONSOLE
        rts

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
