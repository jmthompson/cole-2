`default_nettype none

// look in pins.pcf for all the pin names on the TinyFPGA BX board
module vga_tb (
    input wire clk,
    input wire reset,
    input wire mode,
    input wire blink_on,
    input wire cursor_on,
    input wire [6:0] cursor_x,
    input wire [4:0] cursor_y,
    input wire [7:0] cursor_ch,
    output wire vsync,
    output wire hsync,
    output wire [1:0] red,
    output wire [1:0] green,
    output wire [1:0] blue,
    output wire hblank,
    output wire vblank,
    output wire [9:0] x,
    output wire [8:0] y
);

wire[13:0] vaddr;
wire[7:0] vdata;

vga vga(
    .clk(clk),
    .reset(reset),
    .mode(mode),
    .hsync(hsync),
    .vsync(vsync),
    .hblank(hblank),
    .vblank(vblank),
    .red(red),
    .green(green),
    .blue(blue),
    .blink_on(blink_on),
    .cursor_on(cursor_on),
    .cursor_x(cursor_x),
    .cursor_y(cursor_y),
    .cursor_ch(cursor_ch)
);

ram #(.addr_width(14), .init_file("vram-text.hex")) vram(
    .clk(clk),
    .addr(vaddr),
    .din(8'd0),
    .dout(vdata),
    .wen(1'b0)
);

endmodule
