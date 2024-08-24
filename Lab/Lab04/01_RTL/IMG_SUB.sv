module IMG_SUB(
    // Input signals
    clk,
    rst_n,
    in_valid,
    in_image,
    // Output signals
    out_valid,
    out_diff
);
 
//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION
//---------------------------------------------------------------------
input              clk, rst_n ;
input              in_valid ;
input        [3:0] in_image ;
output logic       out_valid ;
output logic [3:0] out_diff ;

//---------------------------------------------------------------------
//   LOGIC DECLARATION
//---------------------------------------------------------------------

logic [3:0] image_reg;
logic       valid;

logic [35:0] pipe_in_reg, pipe_in_comb;
logic [35:0] pipe_reg, pipe_comb;
logic [17:0] valid_comb, valid_reg;

logic [ 3:0] out_diff_comb;
logic        out_valid_comb;

//---------------------------------------------------------------------
//   Your design
//---------------------------------------------------------------------


always_ff @(posedge clk, negedge rst_n) begin : input_ff

    if(!rst_n) begin
        image_reg <= 0;
        valid <= 0;
    end

    else begin
        image_reg <= in_image;
        valid <= in_valid;
    end

end


always_comb begin : shift_comb
    
    valid_comb =  {valid_reg[16:0], valid};
    out_valid_comb = valid_reg[17] & valid_reg[8];

    pipe_comb = (valid | out_valid | valid_reg[0]) ? {pipe_reg[31:0], -pipe_reg[35:32]-image_reg} : 0;
    out_diff_comb = (out_valid_comb) ? pipe_reg[35:32] : 0;

end


always_ff @(posedge clk, negedge rst_n) begin : shift_ff

    if(!rst_n) begin
        out_valid <= 0;
        valid_reg <= 0;
        out_diff  <= 0;
        pipe_reg  <= 0;
    end

    else begin
        out_valid <= out_valid_comb;
        valid_reg <= valid_comb;
        out_diff <= out_diff_comb;
        pipe_reg <= pipe_comb;
    end

end


endmodule
