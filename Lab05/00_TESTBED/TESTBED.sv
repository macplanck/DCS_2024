`timescale 1ns/1ps
`include "../00_TESTBED/PATTERN.sv"
`include "../01_RTL/inter.sv"


module TESTBED();


logic clk,rst_n,in_valid_1,in_valid_2;
logic [6:0] data_1, data_2;
logic valid_master2slave1, valid_master2slave2, ready_slave1, ready_slave2;
logic [2:0] addr_master2slave, value_master2slave;
logic [2:0] golden0[7:0], golden1[7:0];
logic interconnect2master_ready1, interconnect2master_ready2;


initial begin
	$dumpfile("../02_REPORT/WAVEFORM.vcd");
	$dumpvars(0,TESTBED);
end


//================================================================
// parameters & integer
//================================================================


inter I_interconnect
(
  .clk(clk),
  .rst_n(rst_n),
  .in_valid_1(in_valid_1),
  .in_valid_2(in_valid_2),
  .data_in_1(data_1),
  .data_in_2(data_2),
  .valid_slave1(valid_master2slave1),
  .valid_slave2(valid_master2slave2),
  .ready_slave1(ready_slave1),
  .ready_slave2(ready_slave2),
  .addr_out(addr_master2slave),
  .value_out(value_master2slave),
  .handshake_slave1(interconnect2master_ready1),
  .handshake_slave2(interconnect2master_ready2)
);



PATTERN I_PATTERN
(
  .clk(clk),
  .rst_n(rst_n),
  .in_valid_1(in_valid_1),
  .in_valid_2(in_valid_2),
  .data_in_1(data_1),
  .data_in_2(data_2),
  .valid_slave1(valid_master2slave1),
  .valid_slave2(valid_master2slave2),
  .ready_slave1(ready_slave1),
  .ready_slave2(ready_slave2),
  .addr_out(addr_master2slave),
  .value_out(value_master2slave),
  .handshake_slave1(interconnect2master_ready1),
  .handshake_slave2(interconnect2master_ready2)
);
endmodule
