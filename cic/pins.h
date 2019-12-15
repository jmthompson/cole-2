#ifndef __PINS_H
#define __PINS_H

#define BIT(B)  (1 << (uint8_t)(B))

/* Port B pin assignments */

#define PB_NMI      BIT(0)  // CPU /NMI
#define PB_SPIINT   BIT(1)  // SPI interrupt to system
#define PB_SS       BIT(2)  // SPI SS
#define PB_MOSI     BIT(3)  // SPI MOSI
#define PB_MISO     BIT(4)  // SPI MISO
#define PB_SCLK     BIT(5)  // SPI SCLK
#define PB_RESET    BIT(6)  // System RESET
#define PB_RESETB   BIT(7)  // System /RESET

/* Port C pin assignments */

#define PC_GAME_LATCH BIT(0)    // Game pad latch signal
#define PC_GAME_CLK   BIT(1)    // Game pad clock signal
#define PC_GAME_DATA0 BIT(2)    // Game pad #0 data signal
#define PC_GAME_DATA1 BIT(3)    // Game pad #1 data signal
#define PC_DATA_RDY   BIT(4)    // Data ready signal to VIA
#define PC_DATA_ACK   BIT(5)    // Data ack signal from VIA
#define PC_RESET_SW   BIT(6)    // reset switch

/* Port D pin assignments */

#define PD_UNUSED0      BIT(0)  // unused
#define PD_UNUSED1      BIT(1)  // unused
#define PD_KBD_CLK      BIT(2)  // Keyboard clock line
#define PD_MOUSE_CLK    BIT(3)  // Mouse clock line
#define PD_UNUSED4      BIT(4)  // unused
#define PD_KBD_DATA     BIT(5)  // Keyboard data line
#define PD_MOUSE_DATA   BIT(6)  // Mouse data line
#define PD_UNUSED7      BIT(7)  // unused

#endif // __PINS_H
