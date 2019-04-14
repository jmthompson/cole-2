#ifndef __TIMERS_H
#define	__TIMERS_H

extern void initTimers(void);
extern uint32_t millis(void);
extern uint32_t micros(void);
extern void delayMicroseconds(int us);
extern void delay(unsigned long ms);

#endif  /* __TIMERS_H */
