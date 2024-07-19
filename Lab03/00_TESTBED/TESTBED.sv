`timescale 1ns/1ps
`include "../00_TESTBED/PATTERN.sv"
`include "../01_RTL/SIPO.sv"


module TESTBED();

logic clk, rst_n, in_valid;
logic out_valid;

logic s_in;
logic [3:0] p_out; 


initial begin
	$dumpfile("../02_REPORT/WAVEFORM.vcd");
	$dumpvars(0,TESTBED);
end


SIPO I_SIPO (
	.clk(clk),
	.rst_n(rst_n),
	.in_valid(in_valid),
	.s_in(s_in),
	.out_valid(out_valid),
	.p_out(p_out)
);

PATTERN I_PATTERN (
	.clk(clk),
	.rst_n(rst_n),
	.in_valid(in_valid),
	.s_in(s_in),
	.out_valid(out_valid),
	.p_out(p_out)	
);
endmodule