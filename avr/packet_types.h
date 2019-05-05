#ifndef __PACKET_TYPES_H
#define __PACKET_TYPES_H

#define PT_NO_DATA          0x00
#define PT_PROTOCOL_ERROR   0xFF
#define PT_UNKNOWN_CMD      0xFE
#define PT_BUSY             0xFD

#define PT_GET_STATUS       0x01
#define PT_STATUS           0x81

#define PT_GET_KBD_DATA     0x10
#define PT_KBD_DATA         0x90

#define PT_SET_KBD_LEDS     0x11
#define PT_PS2_RESPONSE     0x91

#define PT_TEST             0x70
#define PT_TEST_RESPONSE    0xF0

#endif // __PACKET_TYPES_H
