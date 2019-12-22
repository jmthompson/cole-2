/* bus */
/* verilator lint_off UNUSED */
module bus (
    input wire clk,
    input wire locked,
    input wire reset,
    input wire cs,
    input wire rwb,
    input wire [7:0] din,
    input wire [3:0] rs,
    input wire [7:0] vdata_in,
    input wire vdata_valid,
    output reg [7:0] dout,
    output reg [7:0] vdata_out,
    output reg [13:0] vaddr,
    output reg vwren,
    output reg phi2,
    output reg vid_mode,
    output reg cursor_on,
    output reg [6:0] cursor_x,
    output reg [4:0] cursor_y,
    output reg [7:0] cursor_ch
);

parameter phi2_ctr_width = 8;

wire is_read;
wire is_write;
reg do_inc;

assign is_read = cs && rwb && phi2 && vdata_valid;
assign is_write = cs && !rwb && phi2;

reg[phi2_ctr_width-1:0] phi2_ctr;
reg[phi2_ctr_width-1:0] phi2_div;
reg[phi2_ctr_width-1:0] clk_register;

reg vram_auto_inc;

/**
* registers:
*
*  00 = vram read/write
*  01 = vram addr lo
*  02 = vram addr hi
*  03 = ctrl (b0 = auto inc, b1 = cursor on/off)
*  04 = cursor char
*  05 = cursor x
*  06 = cursor y
*  07 = clock divisor
*/

/**
 * Handle bus transfers
 */
always @(posedge clk)
begin
    if (!locked) begin
        clk_register <= 24;
    end else if (reset == 1'b1) begin
        dout <= 8'b0000_0000;
        vaddr <= 14'b00_0000_0000_0000;
        vram_auto_inc <= 1'b1;
        vwren <= 1'b0;
        vid_mode <= 0'b0;
        cursor_on <= 1'b1;
        cursor_x <= 0;
        cursor_y <= 0;
        cursor_ch <= "_";
        clk_register <= 24;
        do_inc <= 1'b0;
    end else if (is_read) begin
        case (rs)
             0 : dout <= vdata_in;
             1 : dout <= vaddr[7:0];
             2 : dout <= { 2'b00, vaddr[13:8] };
             3 : begin
                    dout[0] <= vram_auto_inc;
                    dout[1] <= cursor_on;
                    dout[6:2] <= 6'b00_00_00;
                    dout[7] <= vid_mode;
                 end
             4 : dout <= cursor_ch;
             5 : dout <= cursor_x;
             6 : dout <= cursor_y;
             7 : dout <= clk_register;
             default: dout <= 8'b1111_1111;
        endcase
    end else if (is_write) begin
        case (rs)
             0 : vdata_out <= din;
             1 : vaddr[7:0] <= din;
             2 : vaddr[13:8] <= din[5:0];
             3 : begin
                    vram_auto_inc <= din[0];
                    cursor_on <= din[1];
                    vid_mode <= din[7];
                 end
             4 : cursor_ch <= din;
             5 : cursor_x <= din[6:0];
             6 : cursor_y <= din[4:0];
             7 : clk_register <= din;
        endcase
    end else
        vwren <= 1'b0;

    if ((is_read || is_write) && (rs == 0)) begin
        do_inc <= vram_auto_inc;
        vwren  <= is_write;
    end

    if (phi2 == 1'b0) begin
        if (do_inc)
            vaddr <= vaddr + 1'b1;

        do_inc <= 1'b0;
    end
end

/**
 * Generate the PHI2 clock by dividing
 * the 63 MHz master clock by 2*phi2_dev
 */
always @(posedge clk)
begin
    if (locked) begin
        if (phi2_ctr == phi2_div) begin
            phi2_ctr <= 0;
            phi2_div <= clk_register;
            phi2     <= ~phi2;
        end else begin
            phi2_ctr <= phi2_ctr + 1'b1;
        end
    end
end

endmodule
