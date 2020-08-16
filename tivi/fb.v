`default_nettype none

parameter addr_width = 14;
parameter data_width = 8;

module fb (
    input wire clk,
    input wire reset,
    input wire cpu_req,
    input wire cpu_write,
    output reg cpu_ack,
    input wire[addr_width-1:0] cpu_addr,
    input wire [data_width-1:0] cpu_data_in,
    output reg [data_width-1:0] cpu_data_out,
    input wire vga_req,
    output reg vga_ack,
    input wire[addr_width-1:0] vga_addr,
    output reg [data_width-1:0] vga_data_out
);

reg busy;
reg wen;

reg [addr_width-1:0] ram_addr;
reg wire [data_width-1:0] data_in;
reg wire [data_width-1:0] data_out;

ram #(.addr_width(addr_width)) vram(
    .clk(clk),
    .addr(ram_addr),
    .din(data_in),
    .dout(data_out),
    .wen(wen)
);

always @(posedge clk)
begin
    if (reset) begin
        busy <= 0;
        cpu_ack <= 0;
        vga_ack <= 0;
        wen <= 0;
    end else if (busy) begin
        if (vga_req) begin
            vga_data_out <= data_out;
            cpu_ack <= 0;
            vga_ack <= 1;
        end else if (cpu_req) begin
            cpu_data_out <= data_out;
            cpu_ack <= 1;
            vga_ack <= 0;
        end else begin
            cpu_ack <= 0;
            vga_ack <= 0;
        end
    end else begin
        if (vga_req) begin
            ram_addr <= vga_addr;
            wen <= 0;
            busy <= 1;
        end else if (cpu_req) begin
            ram_addr <= cpu_addr;
            data_in <= cpu_data_in;
            wen <= cpu_write;
            busy <= 1;
        end
    end
end

endmodule
