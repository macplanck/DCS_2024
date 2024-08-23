`timescale 1ns/1ps
`include "../00_TESTBED/PATTERN.sv"
`include "../01_RTL/PIPE.sv"


module TESTBED();

logic clk,rst_n,in_valid;
logic out_valid;

logic [26:0] out_value; 
logic [5:0] in_1, in_2, in_3, in_4;
logic [1:0] mode;

initial begin
	$dumpfile("../02_REPORT/WAVEFORM.vcd");
	$dumpvars(0,TESTBED);
end


PIPE I_design
(
  .clk(clk),
  .rst_n(rst_n),
  .in_valid(in_valid),
  .in_1(in_1),
  .in_2(in_2),
  .in_3(in_3),
  .in_4(in_4),
  .mode(mode),

  .out_valid(out_valid),
  .out_value(out_value)
);


PATTERN I_PATTERN
(   
  .clk(clk),
  .rst_n(rst_n),
  .in_valid(in_valid),
  .in_1(in_1),
  .in_2(in_2),
  .in_3(in_3),
  .in_4(in_4),
  .mode(mode),

  .out_valid(out_valid),
  .out_value(out_value)
);

endmodule

