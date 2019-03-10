; Get a single character
.macro  getc
        lda     (ibuffp)
.endmacro

; Advance to the next character
.macro  nextc
        inc     ibuffp
.endmacro

; Output a single character
.macro  putc    char
        lda     char
        jsl     console_write
.endmacro

; Output a CR
.macro  puteol
        putc    #CR
.endmacro

; Read a single line of input into the input buffer
.macro  gets
        jsl     console_readln
.endmacro

; Output a null-terminated string
.macro  puts    string
        pea     ^string
        pea     string
        jsl     console_writeln
.endmacro

; Output a 2-digit hex value
.macro  puthex  value
        lda     value
        jsl     print_hex
.endmacro

