module SIPO(
	// input signals
	clk,
	rst_n,
	in_valid,
	s_in,
	
	// output signals
	out_valid,
	p_out
);

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION                         
//---------------------------------------------------------------------
input clk, rst_n;
input in_valid;
input s_in;
output logic out_valid;
output logic [3:0] p_out;

//---------------------------------------------------------------------
//   LOGIC DECLARATION
//---------------------------------------------------------------------

logic [3:0] p_out_comb;
logic [2:0] valid_reg, valid_comb;
logic out_valid_comb;

//---------------------------------------------------------------------
//   Your design                        
//---------------------------------------------------------------------

assign p_out_comb =  {p_out[2:0], s_in};
assign valid_comb =  {valid_reg[1:0], in_valid};
assign out_valid_comb = & {valid_reg, in_valid};

always_ff @(posedge clk, negedge rst_n) begin

    if(!rst_n) begin
        p_out <= 0;
        valid_reg <= 0;
        out_valid <= 0;
    end

    else begin
        p_out <= p_out_comb;
        valid_reg <= valid_comb;
        out_valid <= out_valid_comb;
    end
end

endmodule




