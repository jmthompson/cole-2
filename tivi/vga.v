`default_nettype none

/*****************************************************************************
 * VGA
 ****************************************************************************/

// This entity implements the basic display timing for VESA 640x400 @ 75 Hz

module vga(
    // Design globals
    input wire clk,
    input wire reset,

    // Inputs from configuration registers
    input wire mode,                // Video mode, 0 = text, 1 = bitmap
    input wire blink_on,            // Blink enable
    input wire cursor_on,           // Cursor enable
    input wire [6:0] cursor_x,      // Cursor horizonal position (column)
    input wire [4:0] cursor_y,      // Cursor vertical position (row)
    input wire [7:0] cursor_ch,     // Character code to use for cursor
    input wire [3:0] hshift,        // Horizontal shift

    // Screen RAM interface
    output reg [12:0] saddr,
    input wire [7:0] sdata,

    // Color RAM interface
    output reg [10:0] caddr,
    input wire [7:0] cdata,

    // Sprite RAM interface
    output reg [10:0] paddr,
    input wire [7:0] pdata,

    // Font RAM interface
    output reg [11:0] faddr,
    input wire [7:0] fdata,

    // The video data
    output wire hsync,
    output wire vsync,
    output wire [1:0] red,
    output wire [1:0] green,
    output wire [1:0] blue,

    // Outputs passed up from timing module
    output wire hblank,             // True if we are in the horizontal blanking interval
    output wire vblank,             // True if we are in the horizontal blanking interval
    output wire [9:0] hcount,       // Horizontal pixel counter
    output wire [8:0] vcount        // Vertical pixel counter
);
        
vga_timing timing(
    .clk(clk),
    .reset(reset),
    .hsync(hsync_in),
    .vsync(vsync_in),
    .hblank(hblank_in),
    .vblank(vblank_in),
    .hcount(hcount),
    .vcount(vcount),
    .frame(frame)
);

wire [2:0] state;
assign state = hcount[2:0];

reg [7:0] pixels;
reg [7:0] colors;
wire [5:0] frame;

reg [5:0] opixel;
assign red   = opixel[5:4];
assign green = opixel[3:2];
assign blue  = opixel[1:0];

wire show_blink;
assign show_blink = frame[5];

wire [6:0] x;
wire [4:0] y;

assign x = hcount[9:3];     // 8 pixels per character cell
assign y = vcount[8:4];     // 16 rows per character cell

wire in_cursor;
assign in_cursor = cursor_on && (x == cursor_x) && (y == cursor_y);

wire hsync_in;
wire vsync_in;
wire hblank_in;
wire vblank_in;

parameter DELAY = 16;

reg [DELAY-1:0] hsync_delayed;
reg [DELAY-1:0] vsync_delayed;
reg [DELAY-1:0] hblank_delayed;
reg [DELAY-1:0] vblank_delayed;

assign hsync = ~hsync_delayed[hshift];
assign vsync = vsync_delayed[hshift];
assign hblank = hblank_delayed[hshift];
assign vblank = vblank_delayed[hshift];

/**
 * Conver a 4-bit RGBI color into 6-bit RRGGBB
 */
function [5:0] get_color;
    input [3:0] index;

    begin
        case (index)
            0  : get_color = 6'b00_00_00;  // black
            1  : get_color = 6'b00_00_10;  // blue
            2  : get_color = 6'b00_10_00;  // green
            3  : get_color = 6'b00_10_10;  // cyan
            4  : get_color = 6'b10_00_00;  // red
            5  : get_color = 6'b10_00_10;  // magenta
            6  : get_color = 6'b10_01_00;  // yellow/brown
            7  : get_color = 6'b10_10_10;  // light grey
            8  : get_color = 6'b01_01_01;  // dark grey
            9  : get_color = 6'b01_01_11;  // bright blue
            10 : get_color = 6'b01_11_01;  // bright green
            11 : get_color = 6'b01_11_11;  // bright cyan
            12 : get_color = 6'b11_01_01;  // bright red
            13 : get_color = 6'b11_01_11;  // bright magenta
            14 : get_color = 6'b11_11_01;  // bright yellow
            15 : get_color = 6'b11_11_11;  // white
        endcase
    end
endfunction

// Handle the delayed hsync/vsync signals
always @(posedge clk)
begin
    if (reset) begin
        hsync_delayed <= 0;
        vsync_delayed <= 0;
        hblank_delayed <= 0;
        vblank_delayed <= 0;
    end else begin
        hsync_delayed <= { hsync_delayed[DELAY-2:0], hsync_in };
        vsync_delayed <= { vsync_delayed[DELAY-2:0], vsync_in };
        hblank_delayed <= { hblank_delayed[DELAY-2:0], hblank_in };
        vblank_delayed <= { vblank_delayed[DELAY-2:0], vblank_in };
    end
end

// Make sure pram synthesizes by giving it some data
always @(posedge clk)
begin
    if (reset)
        paddr <= 11'b000_0000_0000;
    else
        paddr <= caddr;
end

always @(posedge clk)
begin
    if (state == 3'b000) begin
        if (mode == 1'b1)
            saddr <= ((vcount >> 1) * 40) + (hcount >> 4);
        else
            saddr <= ((vcount >> 4) * 80) + (hcount >> 3);

        caddr <= ((vcount >> 4) * 80) + (hcount >> 3);
    end else if (state == 3'b010) begin
        if (in_cursor && show_blink)
            faddr <= { cursor_ch, vcount[3:0] };
        else
            faddr <= { sdata, vcount[3:0] };
    end
end

// Shifter
always @(posedge clk)
begin
    if (reset) begin
        pixels <= 6'b00_00_00;
        colors <= 6'b00_00_00;
    end else if (mode == 0'b0) begin
        if (state == 3'b111) begin
            pixels <= fdata;
            colors <= cdata;
        end else begin
            pixels[6:0] <= pixels[7:1];
        end
    end else begin
        if (state == 3'b111) begin
            if (hcount[3] == 1'b0) begin
                pixels[0] <= sdata[0];
                pixels[1] <= sdata[0];
                pixels[2] <= sdata[1];
                pixels[3] <= sdata[1];
                pixels[4] <= sdata[2];
                pixels[5] <= sdata[2];
                pixels[6] <= sdata[3];
                pixels[7] <= sdata[3];
            end else begin
                pixels[0] <= sdata[4];
                pixels[1] <= sdata[4];
                pixels[2] <= sdata[5];
                pixels[3] <= sdata[5];
                pixels[4] <= sdata[6];
                pixels[5] <= sdata[6];
                pixels[6] <= sdata[7];
                pixels[7] <= sdata[7];
            end

            colors <= cdata;
        end else begin
            pixels[6:0] <= pixels[7:1];
        end
    end
end

// Output pixels
always @(posedge clk)
begin
    if (reset)
        opixel <= 6'b00_00_00;
    else begin
        if (hblank || vblank)
            opixel <= 6'b00_00_00;
        else if (blink_on == 1'b1) begin
            if ((pixels[0] == 1'b0) || ((colors[7] == 1'b1) && (show_blink == 1'b0)))
                opixel <= get_color({ 1'b0, colors[6:4] });
            else
                opixel <= get_color(colors[3:0]);
        end else begin
            if (pixels[0] == 1'b1)
                opixel <= get_color(colors[3:0]);
            else
                opixel <= get_color(colors[7:4]);
        end
    end
end

endmodule
