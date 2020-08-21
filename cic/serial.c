/*
 * Copyright 2013 Alan Burlison, alan@bleaklow.com.  All rights reserved.
 * Use is subject to license terms.  See LICENSE.txt for details.
 */

/*
 * Interrupt-driven USART for avr-libc stdio.  Only supports the first USART
 * as stdin/stdout/stderr, IO streams other than those will all end up being
 * sent to the standard streams attached to the first USART.
 */

#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/cpufunc.h>

#include "serial.h"

/*
 * Convenience types.
 */
typedef uint8_t uchar_t;
typedef unsigned int  uint_t;

/*
 * Set/clear bits - force 8-bit operands to prevent 8 -> 16 bit promotion.
 * BIT versions take a bit number, MASK versions take a bitmask.
 */

#define BIT(B)              (1 << (uint8_t)(B))       // Bit number.
#define GET_BIT(V, B)       ((V) & (uint8_t)BIT(B))   // Get bit number.
#define GET_BIT_HI(V, B)    ((V) | (uint8_t)BIT(B))   // Get with bit number hi.
#define GET_BIT_LO(V, B)    ((V) & (uint8_t)~BIT(B))  // Get with bit number lo.
#define SET_BIT_HI(V, B)    (V) |= (uint8_t)BIT(B)    // Set bit number hi.
#define SET_BIT_LO(V, B)    (V) &= (uint8_t)~BIT(B)   // Set bit number lo.
#define MASK(V, M)          ((V) & (uint8_t)(M))      // Mask bits.
#define GET_MASK(V, M)      ((V) & (uint8_t)(M))      // Get mask bits.
#define GET_MASK_HI(V, M)   ((V) | (uint8_t)(M))      // Get with mask bits hi.
#define GET_MASK_LO(V, M)   ((V) & (uint8_t)~(M))     // Get with mask bits lo.
#define SET_MASK_HI(V, M)   (V) |= (uint8_t)(M)       // Set mask bits hi.
#define SET_MASK_LO(V, M)   (V) &= (uint8_t)~(M)      // Set mask bits lo.

// Duemilanove.
#if defined(__AVR_ATmega328P__)
#define SER_INST   0
#define SER_RX_VEC USART_RX_vect
#define SER_TX_VEC USART_UDRE_vect
// Mega.
#elif defined(__AVR_ATmega1280__) || defined(__AVR_ATmega644P__)
#define SER_INST   0
#define SER_RX_VEC USART0_RX_vect
#define SER_TX_VEC USART0_UDRE_vect
// Minimus V1 & V2.
#elif defined(__AVR_AT90USB162__) || defined(__AVR_ATmega32U2__)
#define SER_INST   1
#define SER_RX_VEC USART1_RX_vect
#define SER_TX_VEC USART1_UDRE_vect

// Otherwise, unknown.
#else
#error "Unknown MCU type"
#endif

/*
 * Macro pasting macros - 2 levels needed to get expansion to work.
 */
#define _PASTE2(A, B) A ## B
#define PASTE2(A, B) _PASTE2(A, B)
#define _PASTE3(A, B, C) A ## B ## C
#define PASTE3(A, B, C) _PASTE3(A, B, C)

// Derived serial registers.
#define SER_UDR    PASTE2(UDR,   SER_INST)
#define SER_UCSRA  PASTE3(UCSR,  SER_INST, A)
#define SER_UCSRB  PASTE3(UCSR,  SER_INST, B)
#define SER_UCSRC  PASTE3(UCSR,  SER_INST, C)
#define SER_UCSRD  PASTE3(UCSR,  SER_INST, D)
#define SER_UBRRH  PASTE3(UBRR,  SER_INST, H)
#define SER_UBRRL  PASTE3(UBRR,  SER_INST, L)
#define SER_UDRIE  PASTE2(UDRIE, SER_INST)

// Derived serial register bits.
#define SER_FE     PASTE2(FE,    SER_INST)
#define SER_DOR    PASTE2(DOR,   SER_INST)
#define SER_UPE    PASTE2(UPE,   SER_INST)
#define SER_UDRIE  PASTE2(UDRIE, SER_INST)
#define SER_U2X    PASTE2(U2X,   SER_INST)
#define SER_UCSZ0  PASTE3(UCSZ,  SER_INST, 0)
#define SER_UCSZ1  PASTE3(UCSZ,  SER_INST, 1)
#define SER_RXEN   PASTE2(RXEN,  SER_INST)
#define SER_TXEN   PASTE2(TXEN,  SER_INST)
#define SER_RXCIE  PASTE2(RXCIE, SER_INST)
#define SER_TXC    PASTE2(TXC,   SER_INST)

// Delete character.
#define DEL 0x7F

// IO buffer - circular queue.
typedef struct {
    char              *start;
    char              *end;
    volatile char     *head;
    volatile char     *tail;
    volatile uint16_t len;
} iobuf_t;

// Forward declarations.
static int file_putchar(char c, FILE *__restrict__ file);
static int file_getchar(FILE *__restrict__ file);

// Globals.
static volatile uint8_t ilines;

// Output data structures.
static char out[SERIAL_OBUFSZ];
static iobuf_t obuf = { out, out + SERIAL_OBUFSZ - 1, out, out, 0 };
static FILE output = {
  .put = &file_putchar,
  .get = NULL,
  .flags = _FDEV_SETUP_WRITE,
  .udata = &obuf
};

// Input data structures.
static char in[SERIAL_IBUFSZ];
static iobuf_t ibuf = { in, in + SERIAL_IBUFSZ - 1, in, in, 0 };
static FILE input = {
  .put = NULL,
  .get = &file_getchar,
  .flags = _FDEV_SETUP_READ,
  .udata = &ibuf
};

/*
 * Enqueue a character.  Assumes there is enough space.
 */
static void enqueue(char c, iobuf_t *__restrict__ iobuf)
{
    *iobuf->head++ = c;
    if (iobuf->head > iobuf->end) {
        iobuf->head = iobuf->start;
    }
    iobuf->len++;
}

/*
 * Dequeue a character.  Assumes there is one available.
 */
static int dequeue(iobuf_t *__restrict__ iobuf)
{
    char c = *iobuf->tail++;
    if (iobuf->tail > iobuf->end) {
        iobuf->tail = iobuf->start;
    }
    iobuf->len--;
    return c;
}

/*
 * Save a character into the output stream buffer.  Blocks if necessary.
 */
static void iobuf_putchar(char c)
{
    // Lock - disable interrupts.
    uchar_t sreg = SREG;
    cli();

    // Busy wait until we have enough free space.
    uint_t len = SERIAL_OBUFSZ - 1;
    while (obuf.len > len) {
        SREG = sreg;
        _NOP();
        sreg = SREG;
        cli();
    }

    // Save the character(s).
    if (len == SERIAL_OBUFSZ - 2) {
        enqueue('\r', &obuf);
    }
    enqueue(c, &obuf);

    // Start TX interrupts - a NOP if they are already active.
    SET_BIT_HI(SER_UCSRB, SER_UDRIE);

    // Unlock and return.
    SREG = sreg;
}

/*
 * Get a character from the input stream buffer.  Blocks if necessary.
 */
static int iobuf_getchar(void)
{
    // Lock - disable interrupts.
    uchar_t sreg = SREG;
    cli();

    while (ibuf.len == 0) {
        SREG = sreg;
        _NOP();
        sreg = SREG;
        cli();
    }

    // Get the next character.
    char c = dequeue(&ibuf);
    if (c == '\n') {
        ilines--;
    }

    // Unlock and return.
    SREG = sreg;
    return c;
}

/*
 * Wrapper for avr-libc FILE structure.
 */
static int file_putchar(char c, FILE *file)
{
    iobuf_putchar(c);
    return c;
}

/*
 * Wrapper for avr-libc FILE structure.
 */
static int file_getchar(FILE *file)
{
    return iobuf_getchar();
}

/*
 * Receive character ISR.
 */
ISR(SER_RX_VEC)
{
    // Read the status and RX registers.
    uchar_t s = SER_UCSRA;
    uchar_t c = SER_UDR;

    // Framing error - treat as EOF.
    if (MASK(s, BIT(SER_FE))) {
        SET_MASK_HI(input.flags, __SEOF);
    }

    // Overrun or parity error.
    if (MASK(s, BIT(SER_DOR) | BIT(SER_UPE))) {
        SET_MASK_HI(input.flags, __SERR);
    }

    if (obuf.len < SERIAL_OBUFSZ) {
        // Save the character, update the line count if necessary.
        enqueue(c, &ibuf);
        if (c == '\n') {
             ilines++;
        }
    } else {
        SET_MASK_HI(input.flags, __SERR);
    }
}

/*
 * Transmit character ISR.
 */
ISR(SER_TX_VEC)
{
    // Disable interrupts if no more characters.
    if (obuf.len == 0) {
        SET_BIT_LO(SER_UCSRB, SER_UDRIE);

    // Transmit the next character.
    } else {
        SER_UDR = dequeue(&obuf);
    }
}

/*
 * Initialise the serial port.
 */
void serial_start(uint8_t ubrrh, uint8_t ubrrl, uint8_t use2x, FILE **in, FILE **out) {

    // Disable the USART.
    SER_UCSRB = 0x00;

    // Initialise avr-libc streams.
    *in  = &input;
    *out = &output;

    // Initialise the USART baud rate.
    SER_UBRRH = ubrrh;
    SER_UBRRL = ubrrl;
    if (use2x) {
        SET_BIT_HI(SER_UCSRA, SER_U2X);
    } else {
        SET_BIT_LO(SER_UCSRA, SER_U2X);
    }

    // Async, 8-bit, no parity, 1 stop.
    SER_UCSRC = BIT(SER_UCSZ0) | BIT(SER_UCSZ1);

    // Enable RX/TX and RX interrupts.
    SER_UCSRB = BIT(SER_RXEN) | BIT(SER_TXEN) | BIT(SER_RXCIE);
}

void serial_start_stdio(uint8_t ubrrh, uint8_t ubrrl, uint8_t use2x) {
    serial_start(ubrrh, ubrrl, use2x, &stdin, &stdout);
    stderr = stdout;
}

/*
 * Disable the serial port,
 */
void serial_stop(void)
{
    // Wait for the TX buffer to empty.
    uchar_t sreg = SREG;
    cli();
    while (obuf.len != 0 || SER_UCSRA & BIT(SER_TXC)) {
        SREG = sreg;
        _NOP();
        sreg = SREG;
        cli();
    }

    // Reset the buffer pointers.
    obuf.head = out;
    obuf.tail = out;
    obuf.len = 0;
    ibuf.head = in;
    ibuf.tail = in;
    ibuf.len = 0;

    // Disable the USART and reenable interrupts.
    SER_UCSRB = 0x00;
    sreg = SREG;
}

/*
 * Get the number of input characters available.
 */
int serial_input_chars(void)
{
    uchar_t sreg = SREG;
    cli();
    int ret = ibuf.len;
    SREG = sreg;
    return ret;
}

/*
 * Get the number of input lines available.
 */
int serial_input_lines(void)
{
    uchar_t sreg = SREG;
    cli();
    int ret = ilines;
    SREG = sreg;
    return ret;
}
