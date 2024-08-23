`timescale 1ns/1ps
`include "../00_TESTBED/PATTERN.sv"
`include "../01_RTL/Comb.sv"

module TESTBED();

initial begin
	$dumpfile("../02_REPORT/WAVEFORM.vcd");
	$dumpvars(0,TESTBED);
end

logic [3:0] in_num0, in_num1, in_num2, in_num3;
logic [4:0] out_num0, out_num1;

Comb I_Comb
(
	.in_num0 (in_num0 ),
	.in_num1 (in_num1 ),
	.in_num2 (in_num2 ),
	.in_num3 (in_num3 ),
	.out_num0(out_num0),
	.out_num1(out_num1)
);

PATTERN I_PATTERN
(
	.in_num0 (in_num0 ),
	.in_num1 (in_num1 ),
	.in_num2 (in_num2 ),
	.in_num3 (in_num3 ),
	.out_num0(out_num0),
	.out_num1(out_num1)
);

endmodule

