`timescale 1ns/1ps
`include "../00_TESTBED/PATTERN.sv"
`include "../01_RTL/DCSformer.sv"


module TESTBED();

logic clk, rst_n, i_valid, w_valid;
logic [7:0] i_data, w_data;
logic w_ready, o_valid;
logic [31:0] o_data;


initial begin
	$dumpfile("../02_REPORT/WAVEFORM.vcd");
	$dumpvars(0,TESTBED);
end

	
DCSformer I_design
(
	.clk(clk),
	.rst_n(rst_n),
	.i_valid(i_valid),
	.w_valid(w_valid),	
	.i_data(i_data),
	.w_data(w_data),
	.w_ready(w_ready),
	.o_valid(o_valid),
	.o_data(o_data)
);


PATTERN I_PATTERN
(
	.clk(clk),
	.rst_n(rst_n),
	.i_valid(i_valid),
	.w_valid(w_valid),	
	.i_data(i_data),
	.w_data(w_data),
	.w_ready(w_ready),
	.o_valid(o_valid),
	.o_data(o_data)
);

endmodule

