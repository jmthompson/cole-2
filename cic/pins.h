#ifndef __PINS_H
#define __PINS_H

#define BIT(B)  (1 << (uint8_t)(B))

/* Port B pin assignments */

#define PB_GAME_DATA0   BIT(0)  // Game pad #0 data signal
#define PB_GAME_DATA1   BIT(1)  // Game pad #1 data signal
#define PB_SS           BIT(2)  // SPI SS
#define PB_MOSI         BIT(3)  // SPI MOSI
#define PB_MISO         BIT(4)  // SPI MISO
#define PB_SCLK         BIT(5)  // SPI SCLK
#define PB_XTAL1        BIT(6)  // XTAL
#define PB_XTAL2        BIT(7)  // XTAL

/* Port C pin assignments */

#define PC_RESET      BIT(0)    // System RESET
#define PC_SPIINT     BIT(1)    // SPI interrupt to system
#define PC_NMI        BIT(2)    // CPU /NMI
#define PC_UNUSED3    BIT(3)    // unused
#define PC_UNUSED4    BIT(4)    // unused
#define PC_UNUSED5    BIT(5)    // unused
#define PC_RESET_SW   BIT(6)    // reset switch

/* Port D pin assignments */

#define PD_UNUSED0      BIT(0)  // unused
#define PD_UNUSED1      BIT(1)  // unused
#define PD_KBD_CLK      BIT(2)  // Keyboard clock line
#define PD_MOUSE_CLK    BIT(3)  // Mouse clock line
#define PD_GAME_LATCH   BIT(4)  // Game pad latch signal
#define PD_GAME_CLK     BIT(5)  // Game pad clock signal
#define PD_KBD_DATA     BIT(6)  // Keyboard data line
#define PD_MOUSE_DATA   BIT(7)  // Mouse data line

#endif // __PINS_H
