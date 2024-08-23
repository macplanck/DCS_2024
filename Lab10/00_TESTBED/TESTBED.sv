`timescale 1ns/1ps
`include "../00_TESTBED/PATTERN.sv"
`include "../01_RTL/CDC.sv"


module TESTBED();


wire	clk_1,clk_2,rst_n,in_valid;
wire	[7:0] in_data;

wire	out_valid;
wire 	[4:0]out_data;

initial begin
	$dumpfile("../02_REPORT/WAVEFORM.vcd");
	$dumpvars(0,TESTBED);
end

CDC I_CDC
(
  // Input signals
	.clk_1(clk_1),
	.clk_2(clk_2),
	.rst_n(rst_n),
	.in_valid(in_valid),
	.in_data(in_data),
  // Output signals
	.out_valid(out_valid),
	.out_data(out_data)
);


PATTERN I_PATTERN
(
 // Input signals
	.clk_1(clk_1),
	.clk_2(clk_2),
	.rst_n(rst_n),
	.in_valid(in_valid),
	.in_data(in_data),
  // Output signals
	.out_valid(out_valid),
	.out_data(out_data)
);


endmodule
