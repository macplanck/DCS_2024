module Sort(
    in_num0,
    in_num1,
    in_num2,
    in_num3,
    in_num4,
    out_num
);


//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION                         
//---------------------------------------------------------------------

input  logic [5:0] in_num0, in_num1, in_num2, in_num3, in_num4;
output logic [5:0] out_num;


//---------------------------------------------------------------------
//   LOGIC DECLARATION
//---------------------------------------------------------------------

logic [5:0] out1_0, out1_1, out1_2, out1_3;
logic [5:0] out2_1, out2_2, out2_3, out2_4;
logic [5:0] out3_0, out3_1, out3_2, out3_3;
logic [5:0] out4_2, out4_3;


//---------------------------------------------------------------------
//   Your DESIGN                        
//---------------------------------------------------------------------

// Layer 1
assign {out1_1, out1_0} = (in_num1 > in_num0) ? {in_num1, in_num0} : {in_num0, in_num1};
assign {out1_3, out1_2} = (in_num3 > in_num2) ? {in_num3, in_num2} : {in_num2, in_num3};

// Layer 2
assign {out2_2, out2_1} = (out1_2  > out1_1) ? {out1_2,  out1_1} : {out1_1,  out1_2};
assign {out2_4, out2_3} = (in_num4 > out1_3) ? {in_num4, out1_3} : {out1_3, in_num4};

// Layer 3
assign {out3_1, out3_0} = (out2_1 > out1_0) ? {out2_1, out1_0} : {out1_0, out2_1};
assign {out3_3, out3_2} = (out2_3 > out2_2) ? {out2_3, out2_2} : {out2_2, out2_3};

// Layer 4
assign out4_2 = (out3_1 >  out3_2) ? out3_1 : out3_2;
assign out4_3 = (out3_3 <= out2_4) ? out3_3 : out2_4;

// Layer 5
assign out_num = (out4_2 <= out4_3) ? out4_2 : out4_3;


endmodule
