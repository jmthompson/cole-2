#ifndef __SR_H
#define __SR_H

#define SR_BUFFER_SIZE  16

extern void srInit(void);
extern void srUpdate(void);
extern void srQueueByte(uint8_t);

#endif // __SR_H
