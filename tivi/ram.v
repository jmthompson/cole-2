`default_nettype none

/**
 * RAM module
 *
 * This module implements a dual-port RAM with a single read
 * port and single write port, compatible with iCE40 block RAM.
 */

module ram
    #(parameter addr_width = 12, parameter data_width = 8, parameter init_file = "")
(
    // Design globals
    input wire clk,

    // Read port
    input wire[addr_width-1:0] raddr,
    output reg [7:0] dout,

    // Write port
    input wire[addr_width-1:0] waddr,
    input wire [7:0] din,
    input wire wen
);

reg[data_width-1:0] mem [0:(1<<addr_width)-1];

/* verilator lint_off WIDTH */
initial begin
  if (init_file != "")
    $readmemh(init_file, mem);
end
/* verilator lint_on WIDTH */

always @(posedge clk)
begin
    dout <= mem[raddr];
end

always @(posedge clk)
begin
    if (wen) mem[waddr] <= din;
end

endmodule
