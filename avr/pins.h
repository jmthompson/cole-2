#ifndef __PINS_H
#define __PINS_H

#define BIT(B)  (1 << (uint8_t)(B))

/* Port B pin assignments */

#define PB_RECV_DATA_RDY BIT(1)     // Receive mode data ready
#define PB_RECV_DATA_ACK BIT(0)     // Receive mode data ack
#define PB_SEND_DATA_RDY BIT(0)     // Send mode data ready
#define PB_SEND_DATA_ACK BIT(1)     // Send mode data ack
#define PB_SS       BIT(2)  // SD card slave select
#define PB_MOSI     BIT(3)  // SD card MOSI
#define PB_MISO     BIT(4)  // SD card MISO
#define PB_SCLK     BIT(5)  // SD card SCLK

/* Port C pin assignments */

#define PC_IRQ          BIT(0)  // IRQ to VIA
#define PC_DDIR         BIT(1)  // Data direction signal from VIA
#define PC_PS2_CLOCK    BIT(4)  // PS/2 keyboard clock
#define PC_PS2_DATA     BIT(5)  // PS/2 keyboard data

/* Port D is 8-bit data bus with VIA */

#endif // __PINS_H
