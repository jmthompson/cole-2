; *******************************
; *  COLE-2 65816 SBC Firmware  *
; * (C) 2018 Joshua M. Thompson *
; *******************************

        .include "common.s"
        .include "sys/ascii.s"
        .include "sys/io.s"

        .export console_init
        .export console_attach
        .export console_read
        .export console_readln
        .export console_write
        .export console_writeln
        .export print_hex

        .import vt100_reset
        .import getc_seriala
        .import vt100_write
        .import vga_reset
        .import kbd_read
        .import vga_write

.macro  set_vector  vector, address
        lda     #$5C    ; JML
        sta     vector
        lda     #<address
        sta     vector+1
        lda     #>address
        sta     vector+2
        lda     #^address
        sta     vector+3
.endmacro

        .segment "SYSDATA": far

reset_vec:  .res 4
read_vec:   .res 4
write_vec:  .res 4

        .segment "HIGHROM"

console_init:
        lda     #0
        jml     console_attach

console_attach:
        cmp     #0
        bne     @vt100
        set_vector  reset_vec, vga_reset
        ;set_vector  read_vec, kbd_read
        set_vector  read_vec, getc_seriala
        set_vector  write_vec, vga_write
        bra     @cont
@vt100: set_vector  reset_vec, vt100_reset
        set_vector  read_vec, getc_seriala
        set_vector  write_vec, vt100_write
@cont:  jml     console_reset

console_reset:
        set_kernel_dp
        jsl     reset_vec
        pld
        rtl
;;
; Try to read a character from the console. If data is availble,
; returns the char in A and carry is set. Otherwise, returns with
; carry clear.
;
console_read:
        set_kernel_dp
        jsl     read_vec
        pld
        rtl

;;
; Interactively read a line of text from the console into the given input
; buffer.
;
console_readln:

; Parameters
@buffer = $01

        ldy     #0
@loop:  jsl     console_read
        bcc     @loop
        cmp     #BS
        beq     @bs
        cmp     #CR
        beq     @eol
        cmp     #CLS
        beq     @cls
        cmp     #' '
        bcc     @loop
        sta     [@buffer],y
        jsl     console_write 
        iny
        bne     @loop
        dey
@eol:   lda     #0
        sta     [@buffer],y
        rtl
@bs:    cpy     #0
        beq     @loop
        jsl     console_write 
        dey
        bra     @loop
@cls:   jsl     console_write
        bra     @loop

;;
; Output character in A to the console
;
console_write:
        set_kernel_dp
        jsl     write_vec
        pld
        rtl

;;
; Print a null-terminated string up to 255 characters in length.
;
console_writeln:

; Parameters
@str = $01

        ldy     #0
@loop:  lda     [@str],y
        beq     @exit
        jsl     console_write
        iny
        bne     @loop
@exit:  rtl

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
