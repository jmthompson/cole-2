ROM_VERSION := 04
HW_REVISION := 03

AS := ca65
LD := ld65

SRCS     := $(wildcard src/*.s) buildinfo.s vga_font.s
OBJS   	 := ${SRCS:.s=.o}
FONT	 := IBM_VGA_8x16.png
LISTINGS := ${SRCS:.s=.l}
ROMFILE  := rom.bin
DUMPFILE := dump.bin
RAMFILE  := ram.bin
MAPFILE  := cole-2.map

CHIP     := SST39LF040@PLCC32

${ROMFILE}: ${OBJS}
	${LD} ${OBJS} -o ${ROMFILE} -C cole-2.cfg -m ${MAPFILE}

all: ${ROMFILE}

dump:
	minipro -p ${CHIP} -r ${DUMPFILE}

prog: ${ROMFILE}
	minipro -p ${CHIP} -w ${ROMFILE}

clean:
	rm -f buildinfo.s vga_font.s ${OBJS} ${LISTINGS} ${MAPFILE} ${ROMFILE} ${RAMFILE}

buildinfo.s:
	echo ".segment \"LOWROM\"" > buildinfo.s
	echo ".export hw_revision" >> buildinfo.s
	echo ".export rom_version" >> buildinfo.s
	echo ".export rom_date" >> buildinfo.s
	echo "hw_revision: .byte \$$${HW_REVISION}" >> buildinfo.s
	echo "rom_version: .byte \$$${ROM_VERSION}" >> buildinfo.s
	date "+rom_date: .byte \"%Y-%m-%d\",0" >> buildinfo.s

vga_font.s: ${FONT}
	./gen_font ${FONT} > vga_font.s
%.o: %.s
	${AS} -I ./include --listing ${<:.s=.l} $<

.PHONY: dump buildinfo.s
