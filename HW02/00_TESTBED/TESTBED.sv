`timescale 1ns/1ps
`include "../00_TESTBED/PATTERN.sv"
`include "../01_RTL/IDC.sv"


module TESTBED();

logic clk, rst_n, in_valid;
logic [5:0] in_id;

logic out_valid, out_legal_id;

initial begin
	$dumpfile("../02_REPORT/WAVEFORM.vcd");
	$dumpvars(0,TESTBED);
end

IDC I_IDC
(
	.clk(clk),
	.rst_n(rst_n),
	.in_valid(in_valid),
	.in_id(in_id),
	.out_valid(out_valid),
	.out_legal_id(out_legal_id)
);

PATTERN I_PATTERN
(
	.clk(clk),
	.rst_n(rst_n),
	.in_valid(in_valid),
	.in_id(in_id),
	.out_valid(out_valid),
	.out_legal_id(out_legal_id)
);
endmodule
