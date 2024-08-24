module P_MUL(
    // input signals
	in_1,
	in_2,
	in_3,
	in_4,
	in_valid,
	rst_n,
	clk,
	
    // output signals
    out_valid,
	out
);

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION                         
//---------------------------------------------------------------------

input [47:0] in_1, in_2;
input [47:0] in_3, in_4;
input in_valid, rst_n, clk;
output logic out_valid;
output logic [95:0] out;


//---------------------------------------------------------------------
//   LOGIC DECLARATION
//---------------------------------------------------------------------

logic valid, in_valid_reg_1, in_valid_reg_2, in_valid_reg_3;

logic [47:0] in_1_reg_1, in_2_reg_1, in_3_reg_1, in_4_reg_1;
logic [47:0] in_1_reg_2, in_2_reg_2, in_3_reg_2, in_4_reg_2;

logic [47:0] max_1, max_1_comb;
logic [47:0] max_2, max_2_comb;

logic [11:0] PA1, PA2, PA3, PA4;
logic [11:0] PB1, PB2, PB3, PB4;

logic [95:0] mult11, mult21, mult31, mult41, mult11_comb, mult21_comb, mult31_comb, mult41_comb;
logic [95:0] mult12, mult22, mult32, mult42, mult12_comb, mult22_comb, mult32_comb, mult42_comb;
logic [95:0] mult13, mult23, mult33, mult43, mult13_comb, mult23_comb, mult33_comb, mult43_comb;
logic [95:0] mult14, mult24, mult34, mult44, mult14_comb, mult24_comb, mult34_comb, mult44_comb;
logic [95:0] sum_comb, sum;



//---------------------------------------------------------------------
//   Your design                        
//---------------------------------------------------------------------


assign valid = in_valid;

always_ff @(posedge clk, negedge rst_n) begin : init_ff
	
	if(!rst_n) begin
		in_valid_reg_1 <= 0;
		in_1_reg_1 <= 0;
		in_2_reg_1 <= 0;
		in_3_reg_1 <= 0;
		in_4_reg_1 <= 0;
	end

	else begin      
		in_valid_reg_1 <= valid;
		in_1_reg_1 <= in_1;
		in_2_reg_1 <= in_2;
		in_3_reg_1 <= in_3;
		in_4_reg_1 <= in_4;
	end

end


assign max_1_comb = (in_1_reg_1 > in_2_reg_1) ? in_1_reg_1 : in_2_reg_1;
assign max_2_comb = (in_3_reg_1 > in_4_reg_1) ? in_3_reg_1 : in_4_reg_1;

always_ff @(posedge clk, negedge rst_n) begin : max_ff

	if(!rst_n) begin
		in_valid_reg_2 <= 0;
		max_1 <= 0;
		max_2 <= 0;
	end

	else begin
		in_valid_reg_2 <= in_valid_reg_1;
		max_1 <= max_1_comb;
		max_2 <= max_2_comb;
	end


end

always_comb begin : mult_comb_1

	PA1 = max_1[11: 0];
	PA2 = max_1[23:12];
	PA3 = max_1[35:24];
	PA4 = max_1[47:36];

	PB1 = max_2[11: 0];
	PB2 = max_2[23:12];
	PB3 = max_2[35:24];
	PB4 = max_2[47:36];

	mult11_comb = PA1 * PB1;
	mult21_comb = PA2 * PB1;
	mult31_comb = PA3 * PB1;
	mult41_comb = PA4 * PB1;

	mult12_comb = PA1 * PB2;
	mult22_comb = PA2 * PB2;
	mult32_comb = PA3 * PB2;
	mult42_comb = PA4 * PB2;

	mult13_comb = PA1 * PB3;
	mult23_comb = PA2 * PB3;
	mult33_comb = PA3 * PB3;
	mult43_comb = PA4 * PB3;

	mult14_comb = PA1 * PB4;
	mult24_comb = PA2 * PB4;
	mult34_comb = PA3 * PB4;
	mult44_comb = PA4 * PB4;

end

always_ff @(posedge clk, negedge rst_n) begin

	if(!rst_n) begin

		in_valid_reg_3 <= 0;

		mult11 <= 0;
		mult21 <= 0;
		mult31 <= 0;
		mult41 <= 0;

		mult12 <= 0;
		mult22 <= 0;
		mult32 <= 0;
		mult42 <= 0;

		mult13 <= 0;
		mult23 <= 0;
		mult33 <= 0;
		mult43 <= 0;

		mult14 <= 0;
		mult24 <= 0;
		mult34 <= 0;
		mult44 <= 0;

	end

	else begin

		in_valid_reg_3 <= in_valid_reg_2;

		mult11 <= mult11_comb;
		mult21 <= mult21_comb;
		mult31 <= mult31_comb;
		mult41 <= mult41_comb;

		mult12 <= mult12_comb;
		mult22 <= mult22_comb;
		mult32 <= mult32_comb;
		mult42 <= mult42_comb;

		mult13 <= mult13_comb;
		mult23 <= mult23_comb;
		mult33 <= mult33_comb;
		mult43 <= mult43_comb;

		mult14 <= mult14_comb;
		mult24 <= mult24_comb;
		mult34 <= mult34_comb;
		mult44 <= mult44_comb;

	end

end


always_comb begin

	sum_comb = (mult11 + (mult12 << 12) + (mult21<<12) + (mult31<<24) + (mult13<<24) + (mult22<<24) + (mult14<<36) + (mult41<<36) + (mult23<<36) + (mult32<<36) + (mult42<<48) + (mult24<<48) + (mult33<<48) + (mult43<<60) + (mult34<<60) + (mult44<<72));

	// sum_comb = (mult11 + ((mult12 + mult21)<<12) + ((mult31 + mult13 + mult22)<<24) + ((mult14 + mult41 + mult23 + mult32)<<36)) + ((mult42 + mult42 + mult33)<<48) + ((mult43 + mult43)<<60) + (mult44<<72);
	// sum_comb = (mult11 + {(mult12 + mult21), 12'd0} + {(mult31 + mult13 + mult22), 24'd0} + {(mult14 + mult41 + mult23 + mult32), 36'd0} + {(mult42 + mult42 + mult33), 48'd0} + {(mult43 + mult43), 60'd0} + {mult44, 72'd0});
end


always_ff @(posedge clk, negedge rst_n) begin : out_ff

	if(!rst_n) begin
		out_valid <= 0;
		out       <= 0;
	end

	else begin
		out_valid <= in_valid_reg_3;
		out       <= sum_comb;
	end

end


endmodule