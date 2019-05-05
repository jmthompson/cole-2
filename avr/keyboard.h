#ifndef __KEYBOARD_H
#define __KEYBOARD_H

#define MAX_KBD_BYTES 32

// LED bits

#define LED_SCROLL  (1 << 0)
#define LED_NUM     (1 << 1)
#define LED_CAPS    (1 << 2)

// Bits in the modifiers bitmap

#define MOD_ALT     (1 << 0)
#define MOD_CTRL    (1 << 1)
#define MOD_SHIFT   (1 << 2)
#define MOD_CAPS    (1 << 3)
#define MOD_NUM     (1 << 4)
#define MOD_SCROLL  (1 << 5)
#define MOD_KEYUP   (1 << 7)

extern void kbdInit(void);
extern void kbdReset(void);
extern void kbdUpdate(void);
extern uint8_t kbdDataReady(void);
extern uint8_t kbdGetData(uint8_t *);
extern void kbdSetLeds(uint8_t);
extern void kbdProcessData(uint8_t);

#endif // __KEYBOARD_H
