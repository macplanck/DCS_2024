`timescale 1ns/1ps
`include "../00_TESTBED/PATTERN.sv"
`include "../01_RTL/test.sv"

module TESTBED;

wire clk;
wire [3:0] in;

wire out_valid; 
wire [3:0] out;

initial begin
	$dumpfile("../02_REPORT/WAVEFORM.vcd");
	$dumpvars(0,TESTBED);
end


test I_TEST
(
	.clk(clk),
	.in(in),
	.out_valid(out_valid),
	.out(out)
);

PATTERN I_PATTERN
(
	.clk(clk),
	.in(in),
	.out_valid(out_valid),
	.out(out)
);


endmodule