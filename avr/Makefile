# Makefile:
# Make m328p firmware for Gir

TARGET=avr

MCU=atmega328p
FREWQ=16000000

# Debug
#DEBUG	= -gstabs

# C flags

CC	= avr-gcc
#CFLAGS	= $(DEBUG) -O3                  -Wall -std=gnu99 -mmcu=$(MCU) -DF_CPU=$(FREWQ) $(INCLUDE)
CFLAGS	= $(DEBUG) -O2 -mcall-prologues -Wall -std=gnu99 -mmcu=$(MCU) -DF_CPU=$(FREWQ) $(INCLUDE)

LD	= avr-gcc
LDFLAGS = -Wl,-Map,$(TARGET).map -mmcu=$(MCU) -lm $(LIBS)

#################################################################################

SRC	=	main.c mpu.c ps2.c timers.c
 
OBJ	=	$(SRC:.c=.o)

all:	$(TARGET).bin

$(TARGET).bin: $(TARGET).elf
	@echo [bin] $<
	@avr-objcopy -j .text -j .data --pad-to=32768 -O binary $(TARGET).elf $(TARGET).bin

$(TARGET).elf:	$(OBJ)
	@echo [Link] $<
	@$(LD) -o $@ $(OBJ) $(LDFLAGS) $(LIBS)
	@avr-size $(TARGET).elf

# Generate .lst file rule

%.lst : %.o
	@echo [lst] $<
	@avr-objdump -h -S $< > $@

.c.o:
	@echo [CC] $<
	@$(CC) -c $(CFLAGS) $< -o $@

.c.s:
	$(CC) -S $(CFLAGS) $< -o $@


.PHONEY:	clean
clean:
	rm -f *.o *.elf *.bin *.hex *.lst *.map Makefile.bak *~

.PHONEY:	depend
depend:
	makedepend -Y $(SRC)

.PHONEY:	upload
upload:	$(TARGET).bin
	@minipro -p atmega328p -I -c code -w $(TARGET).bin
	@echo Done.

.PHONEY:	fuses
fuses:	fuses.txt
	@minipro -p atmega328p -I -c config -w fuses.txt
	@echo Done.
