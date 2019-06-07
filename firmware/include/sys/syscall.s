
.macro  call    funcid
        cop     funcid
.endmacro

SYS_CONSOLE_ATTACH  = $00
SYS_CONSOLE_READ    = $01
SYS_CONSOLE_WRITE   = $02
SYS_CONSOLE_READLN  = $03
SYS_CONSOLE_WRITELN = $04
