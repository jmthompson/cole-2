`default_nettype none

/*****************************************************************************
 * VGA Timing Module
 *
 * This module generates the counters and timing signals for a basic VGA
 * signal. It takes as input the pixel clock and reset signals, and as
 * output provides sync, blanking, and x/y counters
 ****************************************************************************/

// This entity implements the basic display timing for VESA 640x400 @ 75 Hz

module vga (
    input wire  clk,
    input wire  reset,
    input wire  mode,
    input wire  cursor_on,
    input wire  [6:0] cursor_x,     // Cursor horizonal position (column)
    input wire  [4:0] cursor_y,     // Cursor vertical position (row)
    input wire  [7:0] cursor_ch,    // Character code to use for cursor
    output wire hsync,              // Horizontal sync
    output wire vsync,              // Vertical sync
    output wire hblank,             // True if we are in the horizontal blanking interval
    output wire vblank,             // True if we are in the horizontal blanking interval
    output wire [1:0] red,
    output wire [1:0] green,
    output wire [1:0] blue,
    output wire [9:0] x,            // Horizontal pixel counter
    output wire [8:0] y,            // Vertical pixel counter
    input wire  [7:0] vdata,
    output reg  [13:0] vaddr
);
        
/**
 * These parameters determine the actual video mode that will be produced.
 * Horizontal measurements are in pixels; vertical measurements are in lines.
 */
parameter width        = 640;   // Width of active display area
parameter height       = 400;   // Height of active display area
parameter hfp_length   = 32;    // Length of horizontal front porch
parameter hsync_length = 64;    // Length of horizontal sync pulse
parameter hbp_length   = 96;    // Length of horizontal back porch
parameter vfp_length   = 1;     // Length of vertical front porch
parameter vsync_length = 3;     // Length of vertical sync pulse
parameter vbp_length   = 41;    // Length of vertical back porch

/**
 * Calculations for the start/end of various phases of the video signal. Don't
 * change these unless you really know what you're doing!
 */
parameter hvid_start  = 0;
parameter hvid_end    = hvid_start + width;
parameter hfp_start   = hvid_end;
parameter hfp_end     = hfp_start + hfp_length;
parameter hsync_start = hfp_end;
parameter hsync_end   = hsync_start + hsync_length;
parameter hbp_start   = hsync_end;
parameter hbp_end     = hbp_start + hbp_length;
parameter vvid_start  = 0;
parameter vvid_end    = vvid_start + height;
parameter vfp_start   = vvid_end;
parameter vfp_end     = vfp_start + vfp_length;
parameter vsync_start = vfp_end;
parameter vsync_end   = vsync_start + vsync_length;
parameter vbp_start   = vsync_end;
parameter vbp_end     = vbp_start + vbp_length;

// Size of the entire video frame, including porches and sync pulses
parameter hsize = width + hfp_length + hsync_length + hbp_length;
parameter vsize = height + vfp_length + vsync_length + vbp_length;

// How many pixel clocks to delay hsync/vsync/hblank/vblank
parameter delay = 8;

// Upper two bits of starting address of the text font in VRAM
parameter font_prefix = 2'b11;

// Pixel counters
reg[9:0] hcount;
reg[8:0] vcount;

// frame counter (used for blinking text)
reg [5:0] frames;
wire blink_on;
assign blink_on = frames[5];

// Cycle counter, which counts from 0-7 within each group of 8 pixels
wire [2:0] cycle;
assign cycle = hcount[2:0];

// Register pipelines for signal delays
reg hblanks [16];
reg vblanks [16];
reg hsyncs [16];
reg vsyncs [16];

assign hsync  = hsyncs[delay-1];
assign vsync  = vsyncs[delay-1];
assign hblank = hblanks[delay-1];
assign vblank = vblanks[delay-1];

assign x = (mode == 0)? { 3'b000, hcount[9:3] } : hcount;
assign y = (mode == 0)? { 4'b00000, vcount[8:4] } : vcount;

wire in_cursor;
assign in_cursor = (mode == 0) && cursor_on && (hcount[9:3] == cursor_x) && (vcount[8:4] == cursor_y);

reg [5:0] pixel;
assign red = pixel[5:4];
assign green = pixel[3:2];
assign blue = pixel[1:0];

/**
 * Conver a text color into RRGGBB
 */
function [5:0] text_color;
    input [3:0] index;

    begin
        case (index)
            0  : text_color = 6'b00_00_00;  // black
            1  : text_color = 6'b00_00_10;  // blue
            2  : text_color = 6'b00_10_00;  // green
            3  : text_color = 6'b00_10_10;  // cyan
            4  : text_color = 6'b10_00_00;  // red
            5  : text_color = 6'b10_00_10;  // magenta
            6  : text_color = 6'b10_01_00;  // yellow/brown
            7  : text_color = 6'b10_10_10;  // light grey
            8  : text_color = 6'b01_01_01;  // dark grey
            9  : text_color = 6'b01_01_11;  // bright blue
            10 : text_color = 6'b01_11_01;  // bright green
            11 : text_color = 6'b01_11_11;  // bright cyan
            12 : text_color = 6'b11_01_01;  // bright red
            13 : text_color = 6'b11_01_11;  // bright magenta
            14 : text_color = 6'b11_11_01;  // bright yellow
            15 : text_color = 6'b11_11_11;  // white
        endcase
    end
endfunction

/**
 * Create the delays in the sync signals
 */

reg [3:0] idx;

always @(posedge clk)
begin
    if (reset) begin
        for (idx = 0 ; idx < delay ; idx++) begin
            hblanks[idx] <= 0;
            vblanks[idx] <= 0;
            hsyncs[idx]  <= 0;
            vsyncs[idx]  <= 0;
        end
    end else begin
        hblanks[0] <= (hcount >= hvid_end);
        vblanks[0] <= (vcount >= vvid_end);
        hsyncs[0]  <= ((hcount >= hsync_start) && (hcount < hsync_end));
        vsyncs[0]  <= ((vcount >= vsync_start) && (vcount < vsync_end));

        for (idx = 0 ; idx < (delay - 1) ; idx++) begin
            hblanks[idx+1] <= hblanks[idx];
            vblanks[idx+1] <= vblanks[idx];
            hsyncs[idx+1]  <= hsyncs[idx];
            vsyncs[idx+1]  <= vsyncs[idx];
        end
    end
end

/**
 * Horizontal and vertical pixel counters
 */
always @(posedge clk)
begin
    if (reset) begin
        hcount <= 0;
        vcount <= 0;
        frames <= 0;
    end else begin
        if (hcount < hsize - 1)
            hcount <= hcount + 1;
        else begin
            hcount <= 0;
                        
            if (vcount < vsize - 1)
                vcount <= vcount + 1;
            else begin
                vcount <= 0;
                frames <= frames + 1;
            end
        end
    end
end

reg [7:0] data [2];
reg [7:0] data_next [2];
reg [7:0] font;
reg [7:0] font_next;

/**
 * VRAM data fetch
 */
always @(posedge clk)
begin
    if (cycle == 0) begin
        if (mode == 0)
            vaddr <= ((vcount[8:4]) * 160) + { 6'b000000, hcount[9:2] };
        else
            vaddr <= ((vcount[8:2]) * 160) + { 6'b000000, hcount[9:2] };
    end else if (cycle == 2) begin
        data_next[0] <= vdata;

        vaddr <= vaddr + 1;
    end else if (cycle == 4) begin
        data_next[1] <= vdata;

        vaddr <= { font_prefix, in_cursor && blink_on? cursor_ch : data_next[0], vcount[3:0] };
    end else if (cycle == 6)
        font_next <= vdata;
    else if (cycle == 7) begin
        data[0] <= data_next[0];
        data[1] <= data_next[1];
        font    <= font_next;
    end
end

/**
 * Output the pixel to the hardware
 */
always @(posedge clk)
begin
    if (reset || hblank || vblank)
        pixel <= 0;
    else if (mode == 0) begin
        if ((font[cycle] == 0) || ((data[1][7] == 1) && (blink_on == 0)))
            pixel <= text_color({ 1'b0, data[1][6:4] });
        else
            pixel <= text_color(data[1][3:0]);
    end else
        pixel <= data[cycle[2]][5:0];
end

endmodule
