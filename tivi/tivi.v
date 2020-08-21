`default_nettype none

// look in pins.pcf for all the pin names on the TinyFPGA BX board
module tivi (
    input wire CLK16,    // 16MHz clock
    input wire CSB,
    input wire RDB,
    input wire WRB,
    input wire [3:0] RS,
    inout wire [7:0] DB,
    input wire RESETB,
    output wire VSYNC,
    output wire HSYNC,
    output wire [1:0] RED,
    output wire [1:0] GREEN,
    output wire [1:0] BLUE,
    output wire USBPU  // USB pull-up resistor
);

wire clk;
wire reset;

// Active high reset for core logic
assign reset = !RESETB;

// drive USB pull-up resistor to '0' to disable USB
assign USBPU = 0;

wire vid_mode;
wire blink_on;
wire cursor_on;
wire [6:0] cursor_x;
wire [4:0] cursor_y;
wire [7:0] cursor_ch;
wire [3:0] hshift;
wire [7:0] first_row;

// Bidirectional data bus
wire [7:0] din;
wire [7:0] dout;
wire dout_en;

/*
 * Instantiate the data bus pins as bidirectional
 */

SB_IO #(
    .PIN_TYPE(6'b1010_01),
    .PULLUP(1'b0)
) db [7:0] (
    .PACKAGE_PIN(DB),
    .OUTPUT_ENABLE(dout_en),
    .D_OUT_0(dout),
    .D_IN_0(din)
);

/**
 * Generate our 31.5 MHz system clock from the 16 MHz input clock.
 */
pll u_pll(
    .clock_in(CLK16),
    .clock_out(clk)
);

wire [12:0] saddr;
wire [7:0] sdata;
wire [10:0] caddr;
wire [7:0] cdata;
wire [10:0] paddr;
wire [7:0] pdata;
wire [11:0] faddr;
wire [7:0] fdata;

wire [13:0] cpu_addr;
wire [7:0] cpu_data;
wire sram_wen;
wire cram_wen;
wire pram_wen;
wire fram_wen;

wire hblank;
wire vblank;
wire [8:0] vcount;
wire [9:0] hcount;

// 8K of screen RAM
ram #(.addr_width(13), .init_file("sram.hex")) screen_ram(
    .clk(clk),
    .raddr(saddr),
    .dout(sdata),
    .waddr(cpu_addr[12:0]),
    .din(cpu_data),
    .wen(sram_wen)
);

// 2K of color RAM
ram #(.addr_width(11), .init_file("cram.hex")) color_ram(
    .clk(clk),
    .raddr(caddr),
    .dout(cdata),
    .waddr(cpu_addr[10:0]),
    .din(cpu_data),
    .wen(cram_wen)
);

// 2K of sprite RAM
ram #(.addr_width(11)) sprite_ram(
    .clk(clk),
    .raddr(paddr),
    .dout(pdata),
    .waddr(cpu_addr[10:0]),
    .din(cpu_data),
    .wen(pram_wen)
);

// 4K of font RAM

ram #(.addr_width(12), .init_file("fram.hex")) font_ram(
    .clk(clk),
    .raddr(faddr),
    .dout(fdata),
    .waddr(cpu_addr[11:0]),
    .din(cpu_data),
    .wen(fram_wen)
);

/**
 * VGA generator
 */

vga vga(
    .clk(clk),
    .reset(reset),
    .hsync(HSYNC),
    .vsync(VSYNC),
    .red(RED),
    .green(GREEN),
    .blue(BLUE),
    .hblank(hblank),
    .vblank(vblank),
    .hcount(hcount),
    .vcount(vcount),
    .mode(vid_mode),
    .blink_on(blink_on),
    .cursor_on(cursor_on),
    .cursor_x(cursor_x),
    .cursor_y(cursor_y),
    .cursor_ch(cursor_ch),
    .hshift(hshift),
    .first_row(first_row),
    .saddr(saddr),
    .sdata(sdata),
    .caddr(caddr),
    .cdata(cdata),
    .paddr(paddr),
    .pdata(pdata),
    .faddr(faddr),
    .fdata(fdata),
);

/**
 * Bus interface logic
 */
bus bus(
    .clk(clk),
    .reset(reset),
    .csb(CSB),
    .rdb(RDB),
    .wrb(WRB),
    .rs(RS),
    .din(din),
    .dout(dout),
    .dout_en(dout_en),
    .ram_addr(cpu_addr),
    .ram_data(cpu_data),
    .sram_wen(sram_wen),
    .cram_wen(cram_wen),
    .pram_wen(pram_wen),
    .fram_wen(fram_wen),
    .vid_mode(vid_mode),
    .blink_on(blink_on),
    .cursor_on(cursor_on),
    .cursor_x(cursor_x),
    .cursor_y(cursor_y),
    .cursor_ch(cursor_ch),
    .hshift(hshift),
    .first_row(first_row)
);

endmodule
