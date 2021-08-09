cole-2
======

The COLE-2 is, as its name implies, the next evolution of the COLE-1 SBC. It
is a modest upgrade, the main change being that it uses a 65816 instead of
a 6502 CPU, and has considerably more RAM.

I have tried to keep this as retro as possible but there are some usages of
more modern hardware in the interest of robustness and ease of interfacing
to modern peripherals (ie PS/2 keyboards, VGA monitors, etc).

* Hardware

65C816 CPU
1 MB RAM (2 x AS6C4008 512 KB 55ns SRAM)
512 KB ROM (SST39LF040 70 ns NOR flash)
65C22S VIA
NXP 28L92 dual UART
2 x Xilinx XC9572XL CPLD (bus logic and hardware SPI)
TinyFPGA BX (video display)
ATmega328p (input device handling)

* Interface ports

User port with 19 I/O
Two DB-9 RS-232 ports
PS/2 keybord/mouse port
SPI
DB-15 VGA
1/8" audio output
SD card slot

* Features

80 column CGA-style text (16 foreground / 8 background colors plus blink)
320x200 bitmapped graphics, 1bpp, distinct foreground/background colors per 4x8 pixel region
FM synth sound (emulated SID or OPL-3)
