module PIPE(
  // Input signals
  clk,
  rst_n,
  in_valid,
  in_1,
  in_2,
  in_3,
  in_4,
  mode,
  // Output signals
  out_valid,
  out_value
);

//---------------------------------------------------------------------
//   PORT DECLARATION
//---------------------------------------------------------------------
input  logic clk,rst_n,in_valid;
input  logic [5:0] in_1,in_2,in_3,in_4;
input  logic [1:0] mode;

output logic out_valid;

output logic [26:0]out_value;

logic [1:0] mode_reg_1, mode_reg_2, mode_reg_3;
logic in_valid_reg_1, in_valid_reg_2, in_valid_reg_3;

logic [5:0] in_1_reg_1, in_1_reg_2, in_1_reg_3;
logic [5:0] in_2_reg_1, in_2_reg_2, in_2_reg_3;
logic [5:0] in_3_reg_1, in_3_reg_2, in_3_reg_3;
logic [5:0] in_4_reg_1, in_4_reg_2, in_4_reg_3;

logic [11:0] out_1_comb_1, out_1_1, out_1_comb_2, out_1_2; 
logic [11:0] out_2_comb_1, out_2_1, out_2_comb_2;
logic [23:0] out_3_comb_1;

//---------------------------------------------------------------------
//   Design
//---------------------------------------------------------------------

always_ff @(posedge clk, negedge rst_n) begin

  if(~rst_n) begin
    in_valid_reg_1 <= 0;
    mode_reg_1 <= 0;
    in_1_reg_1 <= 0;
    in_2_reg_1 <= 0;
    in_3_reg_1 <= 0;
    in_4_reg_1 <= 0;
  end

  else begin
    in_valid_reg_1 <= in_valid;
    mode_reg_1 <= mode;
    in_1_reg_1 <= in_1;
    in_2_reg_1 <= in_2;
    in_3_reg_1 <= in_3;
    in_4_reg_1 <= in_4;
  end
  
end


always_comb begin : stage_1_comb

  out_1_comb_1 = in_1_reg_1 * in_2_reg_1;

  case(mode_reg_1)

    0: out_1_comb_1 = in_1_reg_1 * in_2_reg_1;
    1: out_1_comb_1 = in_3_reg_1 + in_4_reg_1;
    2: out_1_comb_1 = in_1_reg_1 * in_2_reg_1;

  endcase

end

always_ff @(posedge clk, negedge rst_n) begin

  if(~rst_n) begin
    in_valid_reg_2 <= 0;
    mode_reg_2 <= 0;
    in_3_reg_2 <= 0;
    in_4_reg_2 <= 0;
    out_1_1 <= 0;
  end

  else begin
    in_valid_reg_2 <= in_valid_reg_1;
    mode_reg_2 <= mode_reg_1;
    in_3_reg_2 <= in_3_reg_1;
    in_4_reg_2 <= in_4_reg_1;
    out_1_1 <= out_1_comb_1;
  end
  
end

always_comb begin : stage_2_comb

  out_1_comb_2 = out_1_1;
  out_2_comb_1 = 1;

  if(mode_reg_2 == 2) begin
    out_2_comb_1 = in_3_reg_2 * in_4_reg_2;
  end

end

always_ff @(posedge clk, negedge rst_n) begin

  if(~rst_n) begin
    in_valid_reg_3 <= 0;
    mode_reg_3 <= 0;
    out_1_2 <= 0;
    out_2_1 <= 0;
  end

  else begin
    in_valid_reg_3 <= in_valid_reg_2;
    mode_reg_3 <= mode_reg_1;
    out_1_2 <= out_1_comb_2;
    out_2_1 <= out_2_comb_1;
  end
  
end

always_comb begin : stage_3_comb

  out_3_comb_1 = out_2_1 * out_1_2;

end

always_ff @(posedge clk, negedge rst_n) begin

  if(~rst_n) begin
    out_valid <= 0;
    out_value <= 0;
  end

  else begin
    out_valid <= in_valid_reg_3;
    out_value <= out_3_comb_1;
  end
  
end

endmodule
