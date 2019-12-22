#include <stdio.h>
#include <avr/interrupt.h>

#include "pins.h"
#include "ps2.h"
#include "spi.h"

static uint8_t op;
static uint8_t in_txn;

static uint8_t status;
static uint8_t control;
static uint8_t kbd_in, kbd_out;
static uint8_t mouse_in, mouse_out;
static uint8_t gamepad_in[2];

static void updateInterruptState(void)
{
    if (control & SPI_CTRL_ENABLE_INT) {
        if ((control & SPI_CTRL_ENABLE_KBD_INT) && (status & SPI_STATUS_KBD_IN_FULL)) {
            status |= SPI_STATUS_INTERRUPTING;
        }
        if ((control & SPI_CTRL_ENABLE_MOUSE_INT) && (status & SPI_STATUS_MOUSE_IN_FULL)) {
            status |= SPI_STATUS_INTERRUPTING;
        }

        if (status |= SPI_STATUS_INTERRUPTING) {
            PORTB |= PB_SPIINT;
        }
        else {
            PORTB &= ~PB_SPIINT;
        }
    }
}

void spiInit(void)
{
    in_txn = 0;
    status = 0;
    control = 0;
    gamepad_in[0] = 0;
    gamepad_in[1] = 0;

    // Set SPIINT, and MISO as outputs, all others are inputs
    DDRB |= (PB_SPIINT|PB_MISO);

    //Enable SPI && interrupt enable bit
    SPCR=(1<<SPE)|(1<<SPIE);

    // Enable pin change interrupt on SS line
    PCICR  |= BIT(PCIE0);
	PCMSK0 |= BIT(PCINT0);
}

void spiSetKbdData(uint8_t data)
{
    kbd_in = data;

    status |= SPI_STATUS_KBD_IN_FULL;

    updateInterruptState();
}

void spiSetMouseData(uint8_t data)
{
    mouse_in = data;

    status |= SPI_STATUS_MOUSE_IN_FULL;

    updateInterruptState();
}

void spiUpdate(void)
{
    if (status & SPI_STATUS_KBD_OUT_FULL) {
        spiSetKbdData(ps2SendByte(PS2_PORT_KBD, kbd_out));

        status &= ~SPI_STATUS_KBD_OUT_FULL;
    }
    if (status & SPI_STATUS_MOUSE_OUT_FULL) {
        spiSetMouseData(ps2SendByte(PS2_PORT_MOUSE, mouse_out));

        status &= ~SPI_STATUS_MOUSE_OUT_FULL;
    }
}

/**
 * Monitor the /SS line, and if it goes high
 * then cancel any in-progress transaction.
 */
ISR(PCINT0_vect)
{
    if (PINB & PB_SS) {
        in_txn = 0;
    }
}

ISR(SPI_STC_vect)
{
    if (!in_txn) {
        in_txn = 1;

        op = SPDR;

        switch(op) {
            case SPI_CMD_STATUS:
                SPDR = status;
                break;
            case SPI_CMD_READ_KBD:
                SPDR = kbd_in;
                status &= ~SPI_STATUS_KBD_IN_FULL;
                break;
            case SPI_CMD_READ_MOUSE:
                SPDR = mouse_in;
                status &= ~SPI_STATUS_MOUSE_IN_FULL;
                break;
            case SPI_CMD_READ_GP0:
                SPDR = gamepad_in[0];
                break;
            case SPI_CMD_READ_GP1:
                SPDR = gamepad_in[1];
                break;
            default:
                SPDR = 0xFF;
        }
    }
    else {
        switch(op) {
            case SPI_CMD_SET_CTRL:
                control = SPDR & (SPI_CTRL_ENABLE_INT|SPI_CTRL_ENABLE_KBD_INT|SPI_CTRL_ENABLE_MOUSE_INT);
                break;
            case SPI_CMD_WRITE_KBD:
                kbd_out = SPDR;
                status |= SPI_STATUS_KBD_OUT_FULL;
                break;
            case SPI_CMD_WRITE_MOUSE:
                mouse_out = SPDR;
                status |= SPI_STATUS_MOUSE_OUT_FULL;
                break;
            default:
                /* not a write command, ignore the data */
                break;
        }

        SPDR = 0xFF;

        in_txn = 0;
    }
}
