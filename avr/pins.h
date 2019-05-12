#ifndef __PINS_H
#define __PINS_H

#define BIT(B)  (1 << (uint8_t)(B))

/* Port B pin assignments */

#define PB_SR_DATA  BIT(0)  // Shift register data line
#define PB_SR_CLK   BIT(1)  // Shift register data line
#define PB_SS       BIT(2)  // SD card slave select
#define PB_MOSI     BIT(3)  // SD card MOSI
#define PB_MISO     BIT(4)  // SD card MISO
#define PB_SCLK     BIT(5)  // SD card SCLK
// PB6 & PB7 are the external oscillator

/* Port C pin assignments */

#define PC_GAME_LATCH BIT(0)    // Game pad latch signal
#define PC_GAME_CLK   BIT(1)    // Game pad clock signal
#define PC_GAME_DATA0 BIT(2)    // Game pad #0 data signal
#define PC_GAME_DATA1 BIT(3)    // Game pad #1 data signal
#define PC_DATA_RDY   BIT(4)    // Data ready signal to VIA
#define PC_DATA_ACK   BIT(5)    // Data ack signal from VIA

// PC7 is reset

/* Port D pin assignments */

// PD0,PD1,PD4 are serial
#define PD_KBD_CLK      BIT(2)  // Keyboard clock line
#define PD_MOUSE_CLK    BIT(3)  // Mouse clock line
#define PD_KBD_DATA     BIT(5)  // Keyboard data line
#define PD_MOUSE_DATA   BIT(6)  // Mouse data line
// PD7 open

#endif // __PINS_H
