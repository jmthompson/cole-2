`default_nettype none

/*****************************************************************************
 * VGA Timing Module
 *
 * This module generates the counters and timing signals for a basic VGA
 * signal. It takes as input the pixel clock and reset signals, and as
 * output provides sync, blanking, and h/v counters.
 ****************************************************************************/

// This entity implements the basic display timing for VESA 640x400 @ 75 Hz

module vga_timing (
    input wire  clk,
    input wire  reset,
    output wire hsync,              // Horizontal sync
    output wire vsync,              // Vertical sync
    output wire hblank,             // True if we are in the horizontal blanking interval
    output wire vblank,             // True if we are in the horizontal blanking interval
    output reg  [9:0] hcount,       // Horizontal pixel counter
    output reg  [8:0] vcount,       // Vertical pixel counter
    output reg  [5:0] frame         // frame counter
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
 * Calculations for the start/end of various phases of the video signal.
 * Don't change these unless you really know what you're doing!
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

// Blanking signals
assign hblank = (hcount >= hvid_end);
assign vblank = (vcount >= vvid_end);

// Sync signals
assign hsync  = ((hcount >= hsync_start) && (hcount < hsync_end));
assign vsync  = ((vcount >= vsync_start) && (vcount < vsync_end));

/**
 * Horizontal and vertical counters
 */
always @(posedge clk)
begin
    if (reset) begin
        hcount <= 0;
        vcount <= 0;
        frame  <= 0;
    end else begin
        if (hcount < hsize - 1)
            hcount <= hcount + 1;
        else begin
            hcount <= 0;
                        
            if (vcount < vsize - 1)
                vcount <= vcount + 1;
            else begin
                vcount <= 0;
                frame  <= frame + 1;
            end
        end
    end
end

endmodule
