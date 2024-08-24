`timescale 1ns/1ps
`include "../00_TESTBED/PATTERN.sv"
`include "../01_RTL/IMG_SUB.sv"


module TESTBED();

logic clk, rst_n ;
logic in_valid ;
logic [3:0] in_image ;
logic out_valid ;
logic [3:0] out_diff ;


initial begin
	$dumpfile("../02_REPORT/WAVEFORM.vcd");
	$dumpvars(0,TESTBED);
end


IMG_SUB I_SUB
(
	.clk(clk),
	.rst_n(rst_n),
	.in_valid(in_valid),
	.in_image(in_image),
	.out_valid(out_valid),
	.out_diff(out_diff)
);

PATTERN I_PATTERN
(
	.clk(clk),
	.rst_n(rst_n),
	.in_valid(in_valid),
	.in_image(in_image),
	.out_valid(out_valid),
	.out_diff(out_diff)
);

endmodule