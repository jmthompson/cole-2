`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:14:42 08/03/2019 
// Design Name: 
// Module Name:    csc 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module csc (
	 input wire A0,
	 input wire A1,
    input wire A5,
    input wire A6,
	 input wire A7,
    input wire A11,
    input wire A12,
    input wire A13,
    input wire A14,
    input wire A15,
	 input wire [7:0] DB,
    input wire PHI2,
    input wire RWB,
    input wire VDA,
    input wire RESETB,
    output reg A16,
    output reg A17,
    output reg A18,
    output wire RDB,
    output wire WRB,
    output wire ROMCSB,
    output wire RAM1CSB,
    output wire RAM2CSB,
    output wire IO1SELB,
    output wire IO2SELB,
    output wire IO3SELB,
    output wire IO4SELB
);

reg A19;
reg A20;
reg A21;
reg A22;
reg A23;

wire reset;
wire rd;
wire wr;

wire bank0;
wire lowrom;
wire highrom;
wire io;
wire io1;
wire io2;
wire io3;
wire io4;
wire io8;
wire ram;
wire ram1;
wire ram2;

// These signals are active low
assign RDB = !rd;
assign WRB = !wr;
assign ROMCSB = !(lowrom || highrom);
assign RAM1CSB = !(ram1 && !io && !lowrom);
assign RAM2CSB = !ram2;
assign IO1SELB = !io1;
assign IO2SELB = !io2;
assign IO3SELB = !io3;
assign IO4SELB = !io4;
assign reset = !RESETB;

// rd is only active during phi2 high
assign rd = PHI2 && RWB;

// wr is only active during phi2 high, but not for rom
assign wr = PHI2 && !RWB && !lowrom && !highrom;

// True if current acess is in bank 0
assign bank0 = !A23 && !A22 && !A21 && !A20 && !A19 && !A18 && !A17 && !A16; 

// True if current acess is the LOWROM area ($00/F800 - $FFFF)
assign lowrom = bank0 && A15 && A14 && A13 && A12 && A11;

// True if the current acess is in HIGHROM ($F8-$FF)
assign highrom = A23 && A22 && A21 && A20 && A19;

// True if current acess is in RAM
assign ram = !A23 && !A22 && !A21 && !A20;

// True if the current access is in RAM 1
assign ram1 = ram && !A19;

// True if the current access is in RAM 2
assign ram2 = ram && A19;

// True if the current acess is in the I/O area ($00/F000 - $F7FF)
assign io = bank0 && A15 && A14 && A13 && A12 && !A11 && VDA;

// True if I/O device 1 is being accessed
assign io1 = io && !A7 && !A6 && !A5;

// True if I/O device 2 is being accessed
assign io2 = io && !A7 && !A6 && A5;

// True if I/O device 3 is being accessed
assign io3 = io && !A7 && A6 && !A5;

// True if I/O device 4 is being accessed
assign io4 = io && !A7 && A6 && A5;

// True if I/O device 8 is being accessed
assign io8 = io && A7 && A6 && A5;

always @(posedge PHI2)
begin
   if (reset == 1) begin
		A16 <= A0;
		A17 <= A1;
		A18 <= 0;
		A19 <= 0;
		A20 <= 0;
		A21 <= 0;
		A22 <= 0;
		A23 <= 0;
	end else begin
		A16 <= DB[0];
		A17 <= DB[1];
		A18 <= DB[2];
		A19 <= DB[3];
		A20 <= DB[4];
		A21 <= DB[5];
		A22 <= DB[6];
		A23 <= DB[7];
	end
end

endmodule
