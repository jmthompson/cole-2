`default_nettype none

parameter addr_width = 14;
parameter data_width = 8;

module fb (
    input wire clk,
    input wire reset,
    input wire[addr_width-1:0] vga_addr,
    input wire[addr_width-1:0] cpu_addr,
    input wire cpu_select,
    input wire wren,
    input wire [data_width-1:0] data_in,
    output wire [data_width-1:0] data_out,
);

reg [addr_width-1:0] ram_addr;

ram #(.addr_width(addr_width)) vram(
    .clk(clk),
    .addr(ram_addr),
    .din(data_in),
    .dout(data_out),
    .wen(wren && !cpu_select)
);

always @(posedge clk)
begin
    if (cpu_select == 1'b1) 
        ram_addr <= cpu_addr;
    else
        ram_addr <= vga_addr;
end

endmodule
