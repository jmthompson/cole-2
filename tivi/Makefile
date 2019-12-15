# Makefile borrowed from https://github.com/cliffordwolf/icestorm/blob/master/examples/icestick/Makefile
#
# The following license is from the icestorm project and specifically applies to this file only:
#
#  Permission to use, copy, modify, and/or distribute this software for any
#  purpose with or without fee is hereby granted, provided that the above
#  copyright notice and this permission notice appear in all copies.
#
#  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
#  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
#  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
#  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
#  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
#  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

PROJ := tivi
TB   := vga_tb

VERILOG_SRC := tivi.v pll.v bus.v ram.v fb.v vga.v
PIN_DEF     := pins.pcf
DEVICE      := lp8k

VERILATOR      := verilator
VERILATOR_ROOT := $(shell bash -c 'verilator -V|grep VERILATOR_ROOT | head -1 | sed -e " s/^.*=\s*//"')

GFXFLAGS       := $(shell pkg-config gtkmm-3.0 --cflags)
GFXLIBS        := $(shell pkg-config gtkmm-3.0 --libs)

CXX            := g++
CFLAGS         := -Og -g $(GFXFLAGS) -I obj_dir -I$(VERILATOR_ROOT)/include 
OBJDIR         := obj_dir

all: $(PROJ).rpt $(PROJ).bin

tb: $(TB)

%.o: %.cpp testbench.h
	$(CXX) $(CFLAGS) -c $< -o $@

verilated.o: $(VERILATOR_ROOT)/include/verilated.cpp
	$(CXX) $(CFLAGS) -c $< -o $@

verilated_vcd_c.o: $(VERILATOR_ROOT)/include/verilated_vcd_c.cpp
	$(CXX) $(CFLAGS) -c $< -o $@

$(OBJDIR)/V%__ALL.a, $(OBJDIR)/V%.h: %.v
	$(VERILATOR) --Wall --trace --cc $<
	make -C $(OBJDIR)/ -f V$*.mk

bus_tb: $(OBJDIR)/Vbus.h $(OBJDIR)/Vbus__ALL.a verilated.o verilated_vcd_c.o bus_tb.o
	$(CXX) $(GFXLIBS) verilated.o verilated_vcd_c.o bus_tb.o $(OBJDIR)/Vbus__ALL.a -o $@

vga_tb: $(OBJDIR)/Vvga_tb.h $(OBJDIR)/Vvga_tb__ALL.a verilated.o verilated_vcd_c.o vgasim.o vga_tb.o
	$(CXX) $(GFXLIBS) verilated.o verilated_vcd_c.o vgasim.o vga_tb.o $(OBJDIR)/Vvga_tb__ALL.a -o $@

%.json: $(VERILOG_SRC)
	yosys -q -p "synth_ice40 -top $(PROJ) -json $@" $(VERILOG_SRC)

%.asc: $(PIN_DEF) $(PROJ).json
	nextpnr-ice40 --lp8k --package cm81 --json $(PROJ).json --pcf pins.pcf --asc $@

%.bin: %.asc
	icepack $< $@

%.rpt: %.asc
	icetime -d $(DEVICE) -mtr $@ $<

%_tb.vcd: %_tb
	vvp -N $< +vcd=$@

#%_syn.v: %.blif
#	yosys -p 'read_blif -wideports $^; write_verilog $@'

prog: $(PROJ).bin
	tinyprog -p $<

sudo-prog: $(PROJ).bin
	@echo 'Executing prog as root!!!'
	sudo tinyprog -p $<

clean:
	rm -f $(PROJ).json $(PROJ).asc $(PROJ).rpt $(PROJ).bin $(TB) *.o
	rm -rf $(OBJDIR)/

.SECONDARY:
.PHONY: all prog clean
