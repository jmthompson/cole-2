/*
 * Copyright 2012 Alan Burlison, alan@bleaklow.com.  All rights reserved.
 * Use is subject to license terms.  See LICENSE.txt for details.
 */

/*
 * Serial IO management for the first USART.  Allows C stdio functions to be
 * used, e.g. printf(), scanf() etc.  Define BAUD to specify the required baud
 * rate before including this file, otherwise it defaults to 57600 baud.
 * See avr-libc <util/setbaud.h>.
 */

#ifndef SERIAL_H
#define	SERIAL_H

#include <stdint.h>
#include <stdio.h>

// Default output buffer size.
#ifndef SERIAL_OBUFSZ
#define SERIAL_OBUFSZ 256
#endif

// Default input buffer size.
#ifndef SERIAL_IBUFSZ
#define SERIAL_IBUFSZ 256
#endif

// Default baud rate.
#ifndef BAUD
#define BAUD 57600
#endif
#include <util/setbaud.h>

// Start the USART in the required mode.
extern void serial_start(uint8_t ubrrh, uint8_t ubrrl, uint8_t use2x, FILE **in, FILE **out);

// Start the USART in the required mode running at BAUD.
#define serial_start_baud(IN, OUT) serial_start(UBRRH_VALUE, UBRRL_VALUE, USE_2X, IN, OUT)

// Start the USART in the required mode, connecting to stdin, stdout & stderr.
extern void serial_start_stdio(uint8_t ubrrh, uint8_t ubrrl, uint8_t use2x);

// Start the USART in the required mode, connecting to stdin, stdout & stderr
// and running at BAUD.
#define serial_start_stdio_baud() serial_start_stdio(UBRRH_VALUE, UBRRL_VALUE, USE_2X)

// Stop the USART.
extern void serial_stop(void);

// Return the number of input characters available.
extern int serial_input_chars(void);

// Return the number of input lines available.
extern int serial_input_lines(void);

#endif	/* SERIAL_H */
