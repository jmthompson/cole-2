#ifndef __KEYBOARD_H
#define __KEYBOARD_H

// LED bits

#define LED_SCROLL  (1 << 0)
#define LED_NUM     (1 << 1)
#define LED_CAPS    (1 << 2)

extern void kbdInit(void);
extern void kbdReset(void);
extern void kbdUpdate(void);
extern void kbdProcessData(uint8_t);

#endif // __KEYBOARD_H
