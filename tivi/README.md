# TIVI

The (TI)ny (VI)ideo controller

## Overview

The TIVI is a simple video controller chip buit around the TinyFPGA BX and
its iCE40 FPGA. It generates a VESA 640x400 VGA signal at 85 Hz.

TIVI supports both an 80x25 text mode and a 320x200 bitmapped mode. 

## Video Memory

Due to the limited number of available I/O pins on the BX the TIVI cannot
interface to any external memory. Instead, it uses the iCE40's built-in
block RAM to provide 16K of video memory, which can be written to using a
set of three registers, similar to the TMS9918. It does not, however,
support reading the video memory.

The video memory is divided into four zones:

0x0000 - 0x2000 : (8K) Screen RAM
0x2000 - 0x2800 : (2K) Color RAM
0x2800 - 0x3000 : (2K) Sprite RAM. Not currently used
0x3000 - 0x4000 : (4K) Font RAM

The screen RAM holds the actual video data, either character codes or pixel
data.

The color RAM stores foreground and background color for the pixels. In text
mode, each byte in color RAM provides color for one character. In bitmap
mode it instead provides colors for a 4x8 pixel region.

The sprite memory is currently unused and is reserved for possible future
hardware sprite ability.

Finally, font RAM, as its name implies, stores the current text mode font.

## Video Modes

### Text Mode

In text mode, the first 2000 bytes of screen memory store the character
codes for every character cell on the screen. The upper left corner is at
location 0x0000, and progresses linearly from left to right and top to
bottom.

### Bitmap Mode

The bitmap mode occupies 8000 bytes of screen RAM. Each byte holds eight
monochrome pixels, with the LSB being on the left and the MSB on the right.
Each of these pixels is doubled horizontally and vertically, giving an
effective resolution of 320x200.

### Color

The data in color RAM is used to apply color data to the generated pixels
in both text and bitmap modes. Every byte of color RAM provides a foreground
and background color value for an 8x16 block of pixels, which corresponds to
a single character cell in text mode or a 4x8 pixel block in bitmapped mode
due to pixel doubling.

Each byte of color RAM contains two four-bit colors. The lower four bits are
the foreground color, and the upper four bits are the background color.
Alternatively, blink mode can be enabled, in which case the MSB becomes the
blink bit, and the foreground color is restricted to only the first 8 colors.
In blink mode the color of the "1" pixels will alternate between the FG and
BG colors.
