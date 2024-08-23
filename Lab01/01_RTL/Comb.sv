module Comb(
  // Input signals
	in_num0,
	in_num1,
	in_num2,
	in_num3,
  // Output signals
	out_num0,
	out_num1
);

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION                         
//---------------------------------------------------------------------
input        [3:0] in_num0, in_num1, in_num2, in_num3;
output logic [4:0] out_num0, out_num1;

//---------------------------------------------------------------------
//   LOGIC DECLARATION
//---------------------------------------------------------------------
logic [3:0] num_and, num_or, num_xnor, num_xor;
logic [4:0] num_add1, num_add2;

//---------------------------------------------------------------------
//   Your DESIGN                        
//---------------------------------------------------------------------
assign num_xnor = in_num0  ~^ in_num1;
assign num_or   = in_num1  |  in_num3;
assign num_and  = in_num2  &  in_num0;
assign num_xor  = in_num3  ^  in_num2;

assign num_add1 = num_xnor + num_or;
assign num_add2 = num_and  + num_xor;

assign out_num0 = (num_add1 > num_add2) ? num_add2 : num_add1;
assign out_num1 = (num_add1 > num_add2) ? num_add1 : num_add2;


endmodule