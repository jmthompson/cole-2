; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2018 Joshua M. Thompson *
; *******************************
;
; Most of this is a rough translation of the C++ code in the
; XGS debugger

        .include "common.s"
        .include "sys/console.s"
        .include "disasm_constants.s"

        .import length_table
        .import opcode_table
        .import am_table
        .import mnemonic_table
        .import print_spaces

        .importzp start_loc

        .export disassemble

instr = start_loc

        .segment "ZEROPAGE"

tmp:    .res    1
mwidth: .res    1
xwidth: .res    1
opcode: .res    1
am:     .res    1
len:    .res    1

        .segment "HIGHROM"

;;
; Entry point for the monitor's (L)ist command
;;
disassemble:
        lda     #2
        sta     mwidth
        sta     xwidth              ; Default to m=1, x=1
        ldx     #20
@loop:  phx
        jsr     print_instruction
        plx
        dex
        bne     @loop
        rts

;;
; Disassemble the instruction at [instr], and increment instr to
; point to the start of the next instruction.
;;
print_instruction:
        lda     [instr]
        tax
        lda     f:opcode_table,x
        sta     opcode
        lda     f:am_table,x
        sta     am
        cmp     #AM_immediate_m
        beq     @im
        cmp     #AM_immediate_x
        beq     @xm
        tax
        lda     f:length_table,x
        bra     @len
@im:    lda     mwidth
        bra     @len
@xm:    lda     xwidth
@len:   sta     len
        puthex  instr+2
        putc    #'/'
        puthex  instr+1
        puthex  instr
        ldx     #2
        jsr     print_spaces
        ldy     #0
@hex:   lda     [instr],y
        jsl     print_hex
        putc    #' '
        iny
        cpy     len
        bne     @hex
        lda     #4
        sec
        sbc     len                 ; If len < 4 then we need filler spaces
        bcc     :+
        sta     tmp
        asl                         ; x2
        clc
        adc     tmp                 ; x3
        tax
        jsr     print_spaces        ; fill in the blanks
:       lda     opcode
        longm
        andw    #$FF                ; mask high byte garbage
        asl
        asl                         ; x4
        clc
        adcw    #(mnemonic_table & $ffff)
        pea     ^mnemonic_table     ; high word
        pha                         ; low word
        shortm
        jsl     console_writeln

        ldx     #3
        jsr     print_spaces

        lda     am
        jsr     am_dispatch

        puteol
        longm
        ldx     len
        txa                         ; m is 16 bits but len is 8
        clc
        adc     instr
        sta     instr
        shortm

        rts

;;
; Print the immediate mode operand
;
; On entry:
;
; Y = instruction length
;;
print_immediate_operand:
        putc    #'#'    ; fall through to print_operand

;;
; Print the operand
;
; On entry:
;
; Y = instruction length
;;
print_operand:
        putc    #'$'
@loop:  dey
        beq     @done
        lda     [instr],y
        jsl     print_hex
        bra     @loop
@done:  rts
        rts

;;
; Dispatch to address mode handler
;
; On entry
; A = addressing mode
;;
am_dispatch:
        asl
        tax
        longm
        lda     f:am_handlers,x
        pha
        shortm
        rts

;;
; Handlers for displaying the operands for all possible addressing modes
;;

am_handlers:
        .addr   disp_am_immediate-1
        .addr   disp_am_immediate-1
        .addr   disp_am_a-1
        .addr   disp_am_al-1
        .addr   disp_am_d-1
        .addr   disp_am_accumulator-1
        .addr   disp_am_implied-1
        .addr   disp_am_dix-1
        .addr   disp_am_dixl-1
        .addr   disp_am_dxi-1
        .addr   disp_am_dxx-1
        .addr   disp_am_dxy-1
        .addr   disp_am_axx-1
        .addr   disp_am_alxx-1
        .addr   disp_am_axy-1
        .addr   disp_am_pcr-1
        .addr   disp_am_pcrl-1
        .addr   disp_am_ai-1
        .addr   disp_am_di-1
        .addr   disp_am_dil-1
        .addr   disp_am_axi-1
        .addr   disp_am_stack-1
        .addr   disp_am_sr-1
        .addr   disp_am_srix-1
        .addr   disp_am_blockmove-1
        .addr   disp_am_immediate_m-1
        .addr   disp_am_immediate_x-1

disp_am_immediate:
        ldy     len
        jmp     print_immediate_operand

disp_am_immediate_m:
        ldy    mwidth
        jmp     print_immediate_operand

disp_am_immediate_x:
        ldy     xwidth
        jmp     print_immediate_operand

disp_am_a:
disp_am_al:
disp_am_d:
        ldy     len
        jmp     print_operand

disp_am_accumulator:
disp_am_implied:
disp_am_stack:
        rts

disp_am_dix:
        putc    #'('
        ldy     len
        jsr     print_operand
        putc    #')'
        putc    #','
        putc    #'Y'
        rts

disp_am_dixl:
        putc    #'['
        ldy     len
        jsr     print_operand
        putc    #']'
        putc    #','
        putc    #'Y'
        rts

disp_am_dxi:
        putc    #'('
        ldy     len
        jsr     print_operand
        putc    #')'
        putc    #','
        putc    #'X'
        rts

disp_am_dxx:
disp_am_axx:
disp_am_alxx:
        ldy     len
        jsr     print_operand
        putc    #','
        putc    #'X'
        rts

disp_am_dxy:
disp_am_axy:
        ldy     len
        jsr     print_operand
        putc    #','
        putc    #'Y'
        rts

disp_am_pcr:
        rts

disp_am_pcrl:
        rts

disp_am_ai:
disp_am_di:
        putc    #'('
        ldy     len
        jsr     print_operand
        putc    #')'
        rts

disp_am_dil:
        putc    #'['
        ldy     len
        jsr     print_operand
        putc    #']'
        rts

disp_am_axi:
        putc    #'('
        ldy     len
        jsr     print_operand
        putc    #','
        putc    #'X'
        putc    #')'
        rts

disp_am_sr:
        ldy     len
        jsr     print_operand
        putc    #','
        putc    #'S'
        rts

disp_am_srix:
        putc    #'('
        ldy     len
        jsr     print_operand
        putc    #','
        putc    #'S'
        putc    #')'
        putc    #','
        putc    #'Y'
        rts

disp_am_blockmove:
        putc    #'$'
        ldy     #1
        lda     [instr],y
        jsl     print_hex
        putc    #','
        putc    #'$'
        iny
        lda     [instr],y
        jsl     print_hex
        rts
