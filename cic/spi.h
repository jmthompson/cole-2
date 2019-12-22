#ifndef __SPI_H
#define	__SPI_H

#define SPI_STATUS_KBD_IN_FULL    BIT(0)
#define SPI_STATUS_MOUSE_IN_FULL  BIT(1)
#define SPI_STATUS_KBD_OUT_FULL   BIT(2)
#define SPI_STATUS_MOUSE_OUT_FULL BIT(3)
#define SPI_STATUS_INTERRUPTING BIT(7)

#define SPI_CTRL_ENABLE_KBD_INT   BIT(0)
#define SPI_CTRL_ENABLE_MOUSE_INT BIT(1)
#define SPI_CTRL_ENABLE_INT       BIT(7)

#define SPI_CMD_STATUS      0x00
#define SPI_CMD_READ_KBD    0x01
#define SPI_CMD_READ_MOUSE  0x02
#define SPI_CMD_READ_GP0    0x03
#define SPI_CMD_READ_GP1    0x04

#define SPI_CMD_SET_CTRL    0x80
#define SPI_CMD_WRITE_KBD   0x81
#define SPI_CMD_WRITE_MOUSE 0x82

extern void spiInit(void);
extern void spiUpdate(void);
extern void spiSetKbdData(uint8_t);
extern void spiSetMouseData(uint8_t);

#endif  /* __SPI_H */
