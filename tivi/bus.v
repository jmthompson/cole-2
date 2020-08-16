/*
 * Bus interface module
 *
 * registers:
 *
 *  00 = vram data
 *  01 = vram addr lo
 *  02 = vram addr hi
 *  03 = ctrl
 *  04 = cursor char
 *  05 = cursor x
 *  06 = cursor y
 *  07-15 = unused
 */

/* verilator lint_off UNUSED */
module bus (
    // Design globals
    input wire clk,
    input wire reset,

    // CPU interface
    input wire csb,
    input wire rdb,
    input wire wrb,
    input wire [7:0] din,
    output reg [7:0] dout,
    output wire dout_en,
    input wire [3:0] rs,

    // RAM interface
    output reg [13:0] ram_addr,
    output reg [7:0] ram_data,
    output wire sram_wen,
    output wire cram_wen,
    output wire pram_wen,
    output wire fram_wen,

    // Interface to VGA module
    output reg vid_mode,
    output reg blink_on,
    output reg cursor_on,
    output reg [6:0] cursor_x,
    output reg [4:0] cursor_y,
    output reg [7:0] cursor_ch,
    output reg [3:0] hshift
);

parameter FSM_SIZE    = 5;
parameter IDLE        = 5'b00001;
parameter READ_START  = 5'b00010;
parameter READ_WAIT   = 5'b00100;
parameter WRITE_START = 5'b01000;
parameter WRITE_WAIT  = 5'b10000;

reg [FSM_SIZE-1:0] state;

reg ram_auto_inc;

reg [1:0] cs_buffer;
reg [1:0] rd_buffer;
reg [1:0] wr_buffer;

wire cs;
wire rd;
wire wr;

assign cs = cs_buffer[1];
assign rd = cs && rd_buffer[1];
assign wr = cs && wr_buffer[1];
assign dout_en = rd; //(state == READ_WAIT);

wire is_sram;
wire is_cram;
wire is_pram;
wire is_fram;
assign is_sram = (ram_addr[13] == 1'b0);
assign is_cram = (ram_addr[13:11] == 3'b100);
assign is_pram = (ram_addr[13:11] == 3'b101);
assign is_fram = (ram_addr[13:12] == 2'b11);

reg ram_write;
assign sram_wen = ram_write && is_sram;
assign cram_wen = ram_write && is_cram;
assign pram_wen = ram_write && is_pram;
assign fram_wen = ram_write && is_fram;

/**
 * Bring the /CS, /RD, and /WR signals into our clock domain and invert them
 */ 

always @(posedge clk)
begin
    if (reset == 1'b1) begin
        cs_buffer <= 2'b00;
        rd_buffer <= 2'b00;
        wr_buffer <= 2'b00;
    end else begin
        cs_buffer <= { cs_buffer[0], ~csb };
        rd_buffer <= { rd_buffer[0], ~rdb };
        wr_buffer <= { wr_buffer[0], ~wrb };
    end
end

/**
 * Handle bus requests
 */
always @(posedge clk)
begin
    if (reset) begin
        dout <= 8'b0000_0000;
        ram_addr <= 14'b00_0000_0000_0000;
        ram_write <= 1'b0;
        ram_auto_inc <= 1'b1;
        vid_mode <= 1'b0;
        blink_on <= 1'b1;
        cursor_on <= 1'b1;
        cursor_x <= 0;
        cursor_y <= 0;
        cursor_ch <= "_";
        hshift <= 4'b0111;

        state <= IDLE;
    end else begin
        case (state)
            IDLE :
                if (rd == 1'b1)
                    state <= READ_START;
                else if (wr == 1'b1)
                    state <= WRITE_START;
                else
                    state <= IDLE;
            READ_START : 
                begin
                    case (rs)
                        4'b0001:
                            dout <= ram_addr[7:0];
                        4'b0010:
                            dout <= { 2'b00, ram_addr[13:8] };
                        4'b0011:
                            dout <= { vid_mode, blink_on, 4'b0000, cursor_on, ram_auto_inc };
                        4'b0100:
                            dout <= cursor_ch;
                        4'b0101:
                            dout <= { 1'b0, cursor_x };
                        4'b0110:
                            dout <= { 3'b000, cursor_y };
                        4'b0111:
                            dout <= { 4'b0000, hshift };
                        default:
                            dout <= 8'b1111_1111;
                    endcase

                    state <= READ_WAIT;
                end
            READ_WAIT :
                if (rd == 1'b1)
                    state <= READ_WAIT; // hold data bus
                else
                    state <= IDLE;
            WRITE_START:
                begin
                    case (rs)
                        4'b0000:
                            ram_data <= din;
                        4'b0001:
                            ram_addr[7:0] <= din;
                        4'b0010:
                            ram_addr[13:8] <= din[5:0];
                        4'b0011:
                            { vid_mode, blink_on, 4'b0000, cursor_on, ram_auto_inc } <= din;
                        4'b0100:
                            cursor_ch <= din;
                        4'b0101:
                            cursor_x <= din[6:0];
                        4'b0110:
                            cursor_y <= din[4:0];
                        4'b0111:
                            hshift <= din[3:0];
                    endcase

                    ram_write <= (rs == 3'b000);

                    state <= WRITE_WAIT;
                end
            WRITE_WAIT:
                if (wr == 1'b1)
                    state <= WRITE_WAIT;
                else begin
                    if ((ram_auto_inc == 1'b1) && (ram_write == 1'b1)) ram_addr <= ram_addr + 1;

                    ram_write <= 1'b0;

                    state <= IDLE;
                end
            default:
                state <= IDLE;
        endcase
    end
end

endmodule
