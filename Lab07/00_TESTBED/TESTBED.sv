`timescale 1ns/1ps
`include "../00_TESTBED/PATTERN.sv"
`include "../01_RTL/P_MUL.sv"


module TESTBED();

logic [47:0] in_1, in_2;
logic [47:0] in_3, in_4;
logic in_valid, rst_n, clk;

logic [95:0] out;
logic out_valid;

initial begin
	$dumpfile("../02_REPORT/WAVEFORM.vcd");
	$dumpvars(0,TESTBED);
end

P_MUL I_P_MUL
(
	.in_1(in_1),
	.in_2(in_2),
	.in_3(in_3),
	.in_4(in_4),
	.in_valid(in_valid),
	.rst_n(rst_n),
	.clk(clk),
	.out_valid(out_valid),
	.out(out)
);

PATTERN I_PATTERN
(
	.in_1(in_1),
	.in_2(in_2),
	.in_3(in_3),
	.in_4(in_4),
	.in_valid(in_valid),
	.rst_n(rst_n),
	.clk(clk),
	.out_valid(out_valid),
	.out(out)
);
endmodule
