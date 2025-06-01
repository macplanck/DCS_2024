`timescale 1ns/1ps
`include "PATTERN.sv"
`ifdef RTL
	`include "LP.sv"
`elsif GATE
	`include "LP_SYN.v"
`endif

module TESTBED();

logic clk, rst_n, in_valid;
logic signed [5:0] in_a1,in_a2;
logic signed [11:0] in_b;

logic out_valid;
logic signed [11:0] out_max_value;

initial begin
	`ifdef RTL
		$fsdbDumpfile("LP.fsdb");
		$fsdbDumpvars(0,"+mda");
	`elsif GATE
		$fsdbDumpfile("LP_SYN.fsdb");
		$sdf_annotate("LP_SYN.sdf", I_LP);
		$fsdbDumpvars(0,"+mda");
	`endif
end

LP I_LP
(
	clk,
	rst_n,
	in_valid,
    in_a1,
	in_a2,
	in_b,
    out_valid,
    out_max_value
);

PATTERN I_PATTERN
(
	clk,
	rst_n,
	in_valid,
    in_a1,
	in_a2,
	in_b,
    out_valid,
    out_max_value
);
endmodule
