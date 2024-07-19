//`timescale 1us/100ns
`timescale 1ns/1ps
`include "../00_TESTBENCH/PATTERN.sv"
`include "../01_RTL/CT.sv"

module TESTBENCH();

logic [3:0] in_n0, in_n1, in_n2, in_n3, in_n4, in_n5;
logic [4:0] opcode;
logic [8:0] out_n;

initial begin
	$dumpfile("../02_REPORT/WAVEFORM.vcd");
	$dumpvars(0,TESTBENCH);
end

CT I_CT
(
	.opcode(opcode),
	.in_n0(in_n0),
	.in_n1(in_n1),
	.in_n2(in_n2),
	.in_n3(in_n3),
	.in_n4(in_n4),
	.in_n5(in_n5),
	.out_n(out_n)
);

PATTERN I_PATTERN
(
	.opcode(opcode),
	.in_n0(in_n0),
	.in_n1(in_n1),
	.in_n2(in_n2),
	.in_n3(in_n3),
	.in_n4(in_n4),
	.in_n5(in_n5),
	.out_n(out_n)
);
endmodule

