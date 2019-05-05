; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2018 Joshua M. Thompson *
; *******************************

        .include "common.s"

        .export via_init
        .export via_irq
        .export set_led
        .export get_console_mode
        .export avr_transfer
        .export packet_buffer

        .import kbd_handler

PB_ACT_LED = $80        ; Activity LED
PB_CONSOLE = $40        ; Console select jumper
PB_DDIR    = $20        ; AVR DDIR signal

PCR = %00101000         ; CB2 indep neg edge, CB1 neg edge, CA2 handshake, CA1 neg edge

INT_CB2 = %00001000     ; IER/IFR CB2 flag

;; AVR status register bits
AVR_INTERRUPTING        = $80
AVR_SPI_READY           = $04
AVR_MOUSE_DATA_READY    = $02
AVR_KBD_DATA_READY      = $01

MAX_PACKET = 1+2+4+512  ; Max AVR packet size

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

PT_GET_STATUS = $01
PT_STATUS     = $81

PT_GET_KBD_DATA = $10
PT_KBD_DATA     = $90

        .segment "BUFFERS"

packet_buffer: .res MAX_PACKET

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
        lda     #PB_ACT_LED|PB_DDIR
        sta     via1_base+via_ddrb

        ; VIA 2 ports A & B
        stz     via2_base+via_porta
        stz     via2_base+via_portb
        stz     via2_base+via_ddra
        stz     via2_base+via_ddrb

        ; Enable CB2 interrupt
        lda     #INT_CB2|$80
        sta     via1_base+via_ier
        lda     #PCR
        sta     via1_base+via_pcr

        rts

via_irq:
        lda     via1_base+via_ifr
        bit     #INT_CB2
        beq     @exit

        jsr     avr_irq

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

;;
; Send the packet in the packet buffer to the AVR, and receive the
; response back into the packet buffer.
;
; On exit A and X are undefined, and the packet buffer contains the
; response packet.
;
; This routine disables interrupts during execution, and re-enables
; them on exit if they were enabled on entry.
;
avr_transfer:
        php
        sei
        longx
        lda     via1_base+via_portb
        ora     #PB_DDIR
        sta     via1_base+via_portb     ; raise DDIR to start transaction
        stz     via1_base+via_pcr       ; disable handshaking
        lda     #$ff
        sta     via1_base+via_ddra      ; port A to output mode
        lda     #PCR
        sta     via1_base+via_pcr       ; enable port A handshaking
        lda     packet_buffer
        jsr     avr_send                ; send packet type
        lda     packet_buffer+1
        jsr     avr_send                ; send payload length (lo)
        lda     packet_buffer+2
        jsr     avr_send                ; send payload length (hi)
        ldxw    #0                      ; payload byte counter
@send:  cpx     packet_buffer+1         ; sent entire payload?
        beq     @recv                   ; if yes, go to receive
        lda     packet_buffer+3,x
        jsr     avr_send                ; send payload byte
        inx
        bra     @send                   ; and loop for next one
@recv:  stz     via1_base+via_pcr       ; disable handshaking to reset interrupts
        stz     via1_base+via_ddra      ; port A to input mode
        lda     via1_base+via_porta
        lda     #PCR
        sta     via1_base+via_pcr       ; re-enable handshake mode
        lda     via1_base+via_portb
        and     #~PB_DDIR&$FF
        sta     via1_base+via_portb     ; lower DDIR to indicate receive mode
        jsr     avr_receive             ; get length byte
        sta     packet_buffer
        jsr     avr_receive             ; get payload length (lo)
        sta     packet_buffer+1
        jsr     avr_receive             ; get payload length (hi)
        sta     packet_buffer+2
        ldxw    #0                      ; payload byte counter
@recv2: cpx     packet_buffer+1         ; received all payload bytes?
        beq     @done                   ; if yes then we're done here
        jsr     avr_receive             ; get next payload byte
        sta     packet_buffer+3,x
        inx
        bra     @recv2
@done:  stz     via1_base+via_ddra      ; port A to input mode
        lda     via1_base+via_porta     ; clear any remaining receive interrupt
        shortx
        plp
        rts

;;
; Send the byte in A to the AVR and wait for acknowledgement
;
; On exit A is undefined
;
avr_send:
        sta     via1_base+via_porta
@wait:  lda     via1_base+via_ifr
        and     #$02
        beq     @wait
        rts

;;
; Wait for a byte to be transmitted from the AVR and return
; the byte in A.
;
avr_receive:
        lda     via1_base+via_ifr
        and     #$02
        beq     avr_receive
        lda     via1_base+via_porta
        rts

;;
; Handle an interrupt from the AVR
;
avr_irq:
        pha
        lda     #INT_CB2
        sta     via1_base+via_ifr       ; Clear the interrupt

        lda     #PT_GET_STATUS
        sta     packet_buffer
        stz     packet_buffer+1
        stz     packet_buffer+2         ; no payload
        jsr     avr_transfer            ; Send the status request (also resets the interrupt)

        lda     packet_buffer
        cmp     #PT_STATUS
        bne     @exit                   ; should never happen

        lda     packet_buffer+3         ; get status byte
        bit     #AVR_KBD_DATA_READY
        beq     @exit

        lda     #PT_GET_KBD_DATA
        sta     packet_buffer
        stz     packet_buffer+1
        stz     packet_buffer+2         ; no payload
        jsr     avr_transfer

        lda     packet_buffer
        cmp     #PT_KBD_DATA
        bne     @exit                   ; should never happen

        ldy     #0
@keys:  lda     packet_buffer+3,y
        jsr     kbd_handler
        iny
        cpy     packet_buffer+1         ; done?
        bne     @keys

@exit:  pla
        rts
