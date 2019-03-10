cole-2
======

The COLE-2 is, as its name implies, the next evolution of the COLE-1 SBC. It
is a modest upgrade, the main change being that it uses a 65816 instead of
a 6502 CPU, and has considerably more RAM.

I have tried to keep this as retro as possible but there are some usages of
more modern hardware in the interest of robustness and ease of interfacing
to modern peripherals (ie PS/2 keyboards, VGA monitors, etc).

* Hardware

65C816 CPU @ 6 MHz (currently running at 2 MHz on breadboard)
1 MB of 55ns SRAM
256K of 90ns EEPROM (currently using a 32K ROM)
65C22S  Versatile Interface Adapter
NXP 28L92 dual UART
80 MHz Propeller (not yet implemented)

* Interface ports

User port with 20 I/O
Two DB-9 RS-232 ports
PS/2 keybord/mouse port
SPI
FM Synth Sound
DB-15 VGA
1/8" audio output
SD card slot

* Features

80 column CGA-style text (16 foreground and background colors)
Low-res graphics (TBD, 320x200 possibly)
FM synth sound (emulated SID or OPL-3)
