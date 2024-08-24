`timescale 1ns/1ps
`include "../00_TESTBED/PATTERN.sv"
`include "../01_RTL/Sort.sv"

module TESTBED();

initial begin
	$dumpfile("../02_REPORT/WAVEFORM.vcd");
	$dumpvars(0,TESTBED);
end


logic [5:0] in_num0, in_num1, in_num2, in_num3, in_num4;
logic [5:0] out_num;


Sort I_Sort
(
	.in_num0(in_num0),
	.in_num1(in_num1),
	.in_num2(in_num2),
	.in_num3(in_num3),
	.in_num4(in_num4),
	.out_num(out_num)
);

PATTERN I_PATTERN
(
	.in_num0(in_num0),
	.in_num1(in_num1),
	.in_num2(in_num2),
	.in_num3(in_num3),
	.in_num4(in_num4),
	.out_num(out_num)
);

endmodule

