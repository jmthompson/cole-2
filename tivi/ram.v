module ram
    #(parameter addr_width = 12, parameter data_width = 8, parameter init_file = "")
(
    input[addr_width-1:0] addr,
    input[data_width-1:0] din,
    input clk,
    input wen,
    output reg[data_width-1:0] dout 
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
    dout <= mem[addr];
end

always @(posedge clk)
begin
    if (wen)
        mem[addr] <= din;
end

endmodule
