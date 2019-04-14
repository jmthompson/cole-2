#ifndef __MPU_H
#define __MPU_H

#include "packet_types.h"

#define MAX_PAYLOAD 512             // max packet data size
#define MAX_PACKET (MAX_PAYLOAD+3)  // type byte + 2 bytes len + payload

typedef enum mpu_state_t {
    MPU_IDLE,
    MPU_RECEIVING,
    MPU_RECEIVED,
    MPU_SENDING
} mpu_state_t;

extern void mpuInit(void);
extern uint8_t mpuGetRequest(uint8_t *, uint16_t *);
extern void mpuSendResponse(uint8_t, uint8_t *, uint16_t);
extern void mpuSetBusy(uint8_t);

#endif // __MPU_H
