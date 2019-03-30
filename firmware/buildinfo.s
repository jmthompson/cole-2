.segment "LOWROM"
.export hw_revision
.export rom_version
.export rom_date
hw_revision: .byte $01
rom_version: .byte $02
rom_date: .byte "2019-03-30",0
