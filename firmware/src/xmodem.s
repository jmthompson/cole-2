; XMODEM/CRC Sender/Receiver for the 65816
;
; By Daryl Rictor Aug 2002
;
; A simple file transfer program to allow transfers between the SBC and a 
; console device utilizing the x-modem/CRC transfer protocol.  Requires 
; ~1200 bytes of either RAM or ROM, 132 bytes of RAM for the receive buffer,
; and 12 bytes of zero page RAM for variable storage.
;
;**************************************************************************
; This implementation of XMODEM/CRC does NOT conform strictly to the 
; XMODEM protocol standard in that it (1) does not accurately time character
; reception or (2) fall back to the Checksum mode.

; (1) For timing, it uses a crude timing loop to provide approximate
; delays.  These have been calibrated against a 1MHz CPU clock.  I have
; found that CPU clock speed of up to 5MHz also work but may not in
; every case.  Windows HyperTerminal worked quite well at both speeds!
;
; (2) Most modern terminal programs support XMODEM/CRC which can detect a
; wider range of transmission errors so the fallback to the simple checksum
; calculation was not implemented to save space.
;**************************************************************************
;
; Files transferred via XMODEM-CRC will have the load address contained in
; the first two bytes in little-endian format:  
;  FIRST BLOCK
;     offset(0) = lo(load start address),
;     offset(1) = hi(load start address)
;     offset(2) = data byte (0)
;     offset(n) = data byte (n-2)
;
; Subsequent blocks
;     offset(n) = data byte (n)
;
; One note, XMODEM send 128 byte blocks.  If the block of memory that
; you wish to save is smaller than the 128 byte block boundary, then
; the last block will be padded with zeros.  Upon reloading, the
; data will be written back to the original location.  In addition, the
; padded zeros WILL also be written into RAM, which could overwrite other
; data.   
;
        .include "common.s"
        .include "sys/ascii.s"

        .import getc_seriala
        .import putc_seriala

        .export XModemSend
        .export XModemRcv
        .exportzp xmptr
        .exportzp xmeofp

; Get a single character
.macro  getc
        jsl     getc_seriala
.endmacro

; Output a single character
.macro  putc    char
        lda     char
        jsl     putc_seriala
.endmacro

; Output a null-terminated string
.macro  puts    string
        pea     ^string
        pea     string
        call    SYS_CONSOLE_WRITELN
.endmacro

;-------------------------- The Code ----------------------------
;
; zero page variables (adjust these to suit your needs)
;
;
        .segment "ZEROPAGE"

lastblk: .res   1   ; flag for last block
blkno:  .res    1   ; block number 
errcnt: .res    1   ; error counter 10 is the limit

crc:    .res    2   ; CRC

xmptr:  .res    3   ; data pointer (two byte variable)
xmeofp: .res    3   ; end of file address pointer (2 bytes)

retry:  .res    1   ; retry counter 
retry2: .res    1   ; 2nd counter 

;
;
; non-zero page variables and buffers
;
;
        .segment "BUFFERS"
        .align 256

Rbuff:  .res    132

        .segment "HIGHROM"
;
;^^^^^^^^^^^^^^^^^^^^^^ Start of Program ^^^^^^^^^^^^^^^^^^^^^^
;
; Xmodem/CRC transfer routines
; By Daryl Rictor, August 8, 2002
;
; v1.0  released on Aug 8, 2002.
;
; Enter this routine with the beginning address stored in the zero page address
; pointed to by xmptr and the ending address stored in the zero page address
; pointed to by xmeofp & xmeofph.
;
;
;
XModemSend:
        jsr     PrintMsg    ; send prompt and info
        stz     errcnt      ; error counter set to 0
        stz     lastblk     ; set flag to false
        lda     #$01
        sta     blkno       ; set block # to 1
@wait4crc:
        lda     #$ff        ; 3 seconds
        sta     retry2
        jsr     GetByte
        bcc     @wait4crc   ; wait for something to come in...
        cmp     #'C'        ; is it the "C" to start a CRC xfer?
        beq     @ldbuffer
        cmp     #ESC        ; is it a cancel? <Esc> Key
        bne     @wait4crc   ; No, wait for another character
        jmp     @prtabort   ; Print abort msg and exit
@ldbuffer:
        lda     lastblk     ; Was the last block sent?
        beq     @ldbuff0    ; no, send the next one    
        jmp     @done       ; yes, we're done
@ldbuff0:
        ldx     #$02        ; init pointers
        ldy     #$00
        inc     blkno       ; inc block counter
        lda     blkno
        sta     Rbuff       ; save in 1st byte of buffer
        eor     #$FF
        sta     Rbuff+1     ; save 1's comp of blkno next
@ldbuff1:
        lda     [xmptr],Y   ; save 128 bytes of data
        sta     Rbuff,X
@ldbuff2:
        sec
        lda     xmeofp
        sbc     xmptr       ; Are we at the last address?
        bne     @ldbuff4    ; no, inc pointer and continue
        lda     xmeofp+1
        sbc     xmptr+1
        bne     @ldbuff4
        inc     lastblk     ; Yes, Set last byte flag
@ldbuff3:
        inx
        cpx     #$82        ; Are we at the end of the 128 byte block?
        beq     @calc_crc   ; Yes, calc CRC
        lda     #$00        ; Fill rest of 128 bytes with $00
        sta     Rbuff,X
        beq     @ldbuff3    ; Branch always
@ldbuff4:
        inc     xmptr       ; Inc address pointer
        bne     @ldbuff5
        inc     xmptr+1
@ldbuff5:
        inx
        cpx     #$82        ; last byte in block?
        bne     @ldbuff1    ; no, get the next
@calc_crc:
        jsr     CalcCRC
        lda     crc+1       ; save Hi byte of CRC to buffer
        sta     Rbuff,Y
        iny
        lda     crc         ; save lo byte of CRC to buffer
        sta     Rbuff,Y
@resend:
        ldx     #$00
        putc    #SOH        ; send SOH
@sendblk:
        lda     Rbuff,X     ; Send 132 bytes in buffer to the console
        jsr     putc_seriala
        inx
        cpx     #$84        ; last byte?
        bne     @sendblk    ; no, get next
        lda     #$FF        ; yes, set 3 second delay 
        sta     retry2      ; and
        jsr     GetByte     ; Wait for Ack/Nack
        bcc     @seterror   ; No chr received after 3 seconds, resend
        cmp     #ACK        ; Chr received... is it:
        beq     @ldbuffer   ; ACK, send next block
        cmp     #NAK
        beq     @seterror   ; NAK, inc errors and resend
        cmp     #ESC
        beq     @prtabort   ; Esc pressed to abort
                            ; fall through to error counter
@seterror:
        inc     errcnt      ; Inc error counter
        lda     errcnt      ; 
        cmp     #$0A        ; are there 10 errors? (Xmodem spec for failure)
        bne     @resend     ; no, resend block
@prtabort:
        jsr     Flush       ; yes, too many errors, flush buffer,
        jmp     Print_Err   ; print error msg and exit
@done:  Jmp     Print_Good  ; All Done..Print msg and exit

;
;
;
XModemRcv:
        jsr     PrintMsg    ; send prompt and info
        lda     #$01
        sta     blkno       ; set block # to 1
@startcrc:
        putc    #'C'        ; "C" start with CRC mode
        lda     #$FF    
        sta     retry2      ; set loop counter for ~3 sec delay
        jsr     GetByte     ; wait for input
        bcs     @gotbyte    ; byte received, process it
        bra     @startcrc   ; resend "C"
@startblk:
        lda     #$FF
        sta     retry2      ; set loop counter for ~3 sec delay
        jsr     GetByte     ; get first byte of block
        bcc     @startblk   ; timed out, keep waiting...
@gotbyte:
        cmp     #ESC        ; quitting?
        bne     @gotbyte1   ; no
        rts                 ; YES - return to caller
@gotbyte1:
        cmp     #SOH        ; start of block?
        beq     @begin
        cmp     #EOT
        bne     @bad        ; Not SOH or EOT, so flush buffer & send NAK    
        jmp     @done       ; EOT - all done!
@begin:
        ldx     #$00
@getblk:
        lda     #$ff        ; 3 sec window to receive characters
        sta     retry2
@getblk1:
        jsr     GetByte     ; get next character
        bcc     @bad
@getblk2:
        sta     Rbuff,X     ; good char, save it in the rcv buffer
        inx                 ; inc buffer pointer    
        cpx     #$84        ; <01> <FE> <128 bytes> <CRCH> <CRCL>
        bne     @getblk     ; get 132 characters
        ldx     #$00
        lda     Rbuff,X     ; get block # from buffer
        cmp     blkno       ; compare to expected block #    
        beq     @goodblk1   ; matched!
        jsr     Print_Err   ; Unexpected block number - abort    
        jsr     Flush       ; mismatched - flush buffer and then do BRK
        rts                 ; abort, return to caller
@goodblk1:
        eor     #$ff        ; 1's comp of block #
        inx
        cmp     Rbuff,X     ; compare with expected 1's comp of block #
        beq     @goodblk2   ; matched!
        jsr     Print_Err   ; Unexpected block number - abort    
        jsr     Flush       ; mismatched - flush buffer and then do BRK
        rts
@goodblk2:
        jsr     CalcCRC     ; calc CRC
        lda     Rbuff,Y     ; get hi CRC from buffer
        cmp     crc+1       ; compare to calculated hi CRC
        bne     @bad        ; bad crc, send NAK
        iny
        lda     Rbuff,Y     ; get lo CRC from buffer
        cmp     crc         ; compare to calculated lo CRC
        beq     @good       ; good CRC
@bad:   jsr     Flush       ; flush the input buffer
        putc    #NAK        ; send NAK to resend block
        jmp     @startblk   ; start over, get the block again            
@good:  ldy     #$00        ; set offset to zero
@copy:  lda     Rbuff+2,Y   ; get data byte from buffer
        sta     [xmptr],Y   ; save to target
        iny
        bpl     @copy       ; stop when Y=$80
        tya
        clc
        adc     xmptr
        sta     xmptr
        lda     xmptr+1
        adc     #0
        sta     xmptr+1
        inc     blkno       ; done.  Inc the block #
        putc    #ACK        ; send ACK
        jmp     @startblk   ; get next block
@done:  putc    #ACK        ; last block, send ACK and exit.
        jsr     Flush       ; get leftover characters, if any
        jsr     Print_Good  ;
        rts

;=========================================================================
;
; subroutines
;

; wait for chr input and cycle timing loop
GetByte:
        stz     retry       ; set low value of timing loop
@loop:  getc                ; get chr from serial port, don't wait 
        bcs     @ok         ; got one, so exit
        dec     retry       ; no character received, so dec counter
        bne     @loop
        dec     retry2      ; dec hi byte of counter
        bne     @loop       ; look for character again
        clc                 ; if loop times out, CLC, else SEC and return
@ok:    rts                 ; with character in "A"

;
Flush:
        lda     #$70        ; flush receive buffer
        sta     retry2      ; flush until empty for ~1 sec.
        getc
        bcs     Flush       ; if chr recvd, wait for another
        rts                 ; else done

;
PrintMsg:
        puts    @msg
        rts
@msg:   .byte   "Begin XMODEM/CRC transfer.  Press <Esc> to abort...", $0d, $00

;
Print_Err:
        puts    @msg
        rts
@msg:   .byte   "Transfer Error!", $0d, 00

;
Print_Good:
        puts    @msg
        rts
@msg:   .byte   EOT,CR,EOT,CR,EOT,CR,CR
        .byte   "Transfer Successful!", $0d, 00

;;
; Calculate block CRC
;
CalcCRC:
        stz     crc
        stz     crc+1
        ldy     #$02
@loop:  lda     Rbuff,Y
        eor     crc+1   ; Quick CRC computation with lookup tables
        tax             ; updates the two bytes at crc & crc+1
        lda     crc     ; with the byte send in the "A" register
        eor     f:crchi,X
        sta     crc+1
        lda     f:crclo,X
        sta     crc
        iny
        cpy    #$82     ; done yet?
        bne    @loop    ; no, get next
        rts             ; y=82 on exit

; low byte CRC lookup table
crclo:
        .byte  $00,$21,$42,$63,$84,$A5,$C6,$E7,$08,$29,$4A,$6B,$8C,$AD,$CE,$EF
        .byte  $31,$10,$73,$52,$B5,$94,$F7,$D6,$39,$18,$7B,$5A,$BD,$9C,$FF,$DE
        .byte  $62,$43,$20,$01,$E6,$C7,$A4,$85,$6A,$4B,$28,$09,$EE,$CF,$AC,$8D
        .byte  $53,$72,$11,$30,$D7,$F6,$95,$B4,$5B,$7A,$19,$38,$DF,$FE,$9D,$BC
        .byte  $C4,$E5,$86,$A7,$40,$61,$02,$23,$CC,$ED,$8E,$AF,$48,$69,$0A,$2B
        .byte  $F5,$D4,$B7,$96,$71,$50,$33,$12,$FD,$DC,$BF,$9E,$79,$58,$3B,$1A
        .byte  $A6,$87,$E4,$C5,$22,$03,$60,$41,$AE,$8F,$EC,$CD,$2A,$0B,$68,$49
        .byte  $97,$B6,$D5,$F4,$13,$32,$51,$70,$9F,$BE,$DD,$FC,$1B,$3A,$59,$78
        .byte  $88,$A9,$CA,$EB,$0C,$2D,$4E,$6F,$80,$A1,$C2,$E3,$04,$25,$46,$67
        .byte  $B9,$98,$FB,$DA,$3D,$1C,$7F,$5E,$B1,$90,$F3,$D2,$35,$14,$77,$56
        .byte  $EA,$CB,$A8,$89,$6E,$4F,$2C,$0D,$E2,$C3,$A0,$81,$66,$47,$24,$05
        .byte  $DB,$FA,$99,$B8,$5F,$7E,$1D,$3C,$D3,$F2,$91,$B0,$57,$76,$15,$34
        .byte  $4C,$6D,$0E,$2F,$C8,$E9,$8A,$AB,$44,$65,$06,$27,$C0,$E1,$82,$A3
        .byte  $7D,$5C,$3F,$1E,$F9,$D8,$BB,$9A,$75,$54,$37,$16,$F1,$D0,$B3,$92
        .byte  $2E,$0F,$6C,$4D,$AA,$8B,$E8,$C9,$26,$07,$64,$45,$A2,$83,$E0,$C1
        .byte  $1F,$3E,$5D,$7C,$9B,$BA,$D9,$F8,$17,$36,$55,$74,$93,$B2,$D1,$F0 

; hi byte CRC lookup table
crchi:
        .byte  $00,$10,$20,$30,$40,$50,$60,$70,$81,$91,$A1,$B1,$C1,$D1,$E1,$F1
        .byte  $12,$02,$32,$22,$52,$42,$72,$62,$93,$83,$B3,$A3,$D3,$C3,$F3,$E3
        .byte  $24,$34,$04,$14,$64,$74,$44,$54,$A5,$B5,$85,$95,$E5,$F5,$C5,$D5
        .byte  $36,$26,$16,$06,$76,$66,$56,$46,$B7,$A7,$97,$87,$F7,$E7,$D7,$C7
        .byte  $48,$58,$68,$78,$08,$18,$28,$38,$C9,$D9,$E9,$F9,$89,$99,$A9,$B9
        .byte  $5A,$4A,$7A,$6A,$1A,$0A,$3A,$2A,$DB,$CB,$FB,$EB,$9B,$8B,$BB,$AB
        .byte  $6C,$7C,$4C,$5C,$2C,$3C,$0C,$1C,$ED,$FD,$CD,$DD,$AD,$BD,$8D,$9D
        .byte  $7E,$6E,$5E,$4E,$3E,$2E,$1E,$0E,$FF,$EF,$DF,$CF,$BF,$AF,$9F,$8F
        .byte  $91,$81,$B1,$A1,$D1,$C1,$F1,$E1,$10,$00,$30,$20,$50,$40,$70,$60
        .byte  $83,$93,$A3,$B3,$C3,$D3,$E3,$F3,$02,$12,$22,$32,$42,$52,$62,$72
        .byte  $B5,$A5,$95,$85,$F5,$E5,$D5,$C5,$34,$24,$14,$04,$74,$64,$54,$44
        .byte  $A7,$B7,$87,$97,$E7,$F7,$C7,$D7,$26,$36,$06,$16,$66,$76,$46,$56
        .byte  $D9,$C9,$F9,$E9,$99,$89,$B9,$A9,$58,$48,$78,$68,$18,$08,$38,$28
        .byte  $CB,$DB,$EB,$FB,$8B,$9B,$AB,$BB,$4A,$5A,$6A,$7A,$0A,$1A,$2A,$3A
        .byte  $FD,$ED,$DD,$CD,$BD,$AD,$9D,$8D,$7C,$6C,$5C,$4C,$3C,$2C,$1C,$0C
        .byte  $EF,$FF,$CF,$DF,$AF,$BF,$8F,$9F,$6E,$7E,$4E,$5E,$2E,$3E,$0E,$1E 
