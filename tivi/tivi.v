`default_nettype none

// look in pins.pcf for all the pin names on the TinyFPGA BX board
module tivi (
    input wire CLK16,    // 16MHz clock
    input wire CSB,
    input wire RWB,
    input wire [3:0] RS,
    inout wire [7:0] DB,
    input wire RESETB,
    output wire PHI2,
    output wire VSYNC,
    output wire HSYNC,
    output wire [1:0] RED,
    output wire [1:0] GREEN,
    output wire [1:0] BLUE,
    output wire USBPU  // USB pull-up resistor
);

wire clk;
wire locked;
wire reset;
wire cs;

wire hsync;
wire vsync;
wire hblank;
wire vblank;
wire [9:0] x;
wire [8:0] y;

// Active high chip select
assign cs = !CSB;

// Hsync and Vsync are negative polarity
assign HSYNC = ~hsync;
assign VSYNC = vsync;

// Active high reset for core logic
assign reset = !RESETB;

// drive USB pull-up resistor to '0' to disable USB
assign USBPU = 0;

wire vid_mode;

// Cursor
wire cursor_on;
wire [6:0] cursor_x;
wire [4:0] cursor_y;
wire [7:0] cursor_ch;

/**
 * Create the bidirectional data bus
 */

wire [7:0] din;
wire [7:0] dout;
wire dout_en;

// Enable output only during a valid read cycle
assign dout_en = PHI2 && RWB && cs;

/**
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
    .clock_out(clk),
    .locked(locked)
);

reg pixel_clk;

always @(posedge clk)
begin
    if (reset == 1'b1)
        pixel_clk <= 0;
    else
        pixel_clk <= ~pixel_clk;
end

/**
 * Frame buffer
 */

wire[13:0] vga_addr;
wire[13:0] cpu_addr;
wire[7:0] fb_data_in;
wire[7:0] fb_data_out;
wire fb_wren;

fb fb(
    .clk(clk),
    .reset(reset),
    .vga_addr(vga_addr),
    .cpu_addr(cpu_addr),
    .cpu_select(pixel_clk),
    .wren(fb_wren),
    .data_in(fb_data_in),
    .data_out(fb_data_out)
);

/**
 * VGA tming generator
 */

vga vga(
    .clk(pixel_clk),
    .reset(reset),
    .mode(vid_mode),
    .cursor_on(cursor_on),
    .cursor_x(cursor_x),
    .cursor_y(cursor_y),
    .cursor_ch(cursor_ch),
    .hsync(hsync),
    .vsync(vsync),
    .hblank(hblank),
    .vblank(vblank),
    .x(x),
    .y(y),
    .vdata(fb_data_out),
    .vaddr(vga_addr),
    .red(RED),
    .green(GREEN),
    .blue(BLUE),
);

/**
 * 65xx bus interface logic
 */
bus _bus(
    .clk(clk),
    .locked(locked),
    .reset(reset),
    .cs(cs),
    .rwb(RWB),
    .rs(RS),
    .din(din),
    .dout(dout),
    .vaddr(cpu_addr),
    .vdata_in(fb_data_out),
    .vdata_out(fb_data_in),
    .vdata_valid(pixel_clk),
    .vwren(fb_wren),
    .vid_mode(vid_mode),
    .cursor_on(cursor_on),
    .cursor_x(cursor_x),
    .cursor_y(cursor_y),
    .cursor_ch(cursor_ch),
    .phi2(PHI2)
);

endmodule
