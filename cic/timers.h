#ifndef __TIMERS_H
#define	__TIMERS_H

extern void timerInit(void);
extern void setTimer(uint8_t);
extern uint8_t timerExpired(void);
extern void delayMicroseconds(uint8_t);
extern void delayTicks(uint8_t);

#endif  /* __TIMERS_H */
