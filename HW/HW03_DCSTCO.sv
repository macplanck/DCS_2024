// Latency: 1540670
// Area: 13388.760152

module DCSTCO(
    // Input signals
	clk,
	rst_n,
    in_valid,
	target_product,
    // Output signals
    out_valid,
	ten,
	five,
	one,
	run_out_ing,
	// AHB-interconnect input signals
	ready_refri,
	ready_kitch,
	// AHB-interconnect output signals
	valid_refri,
	valid_kitch,
	product_out,
	number_out
);

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION                         
//---------------------------------------------------------------------
input        clk, rst_n ;
input        in_valid ;
input        [11:0] target_product ;
input        ready_refri ;
input        ready_kitch ;
output logic out_valid ;
output logic [3:0] ten ;
output logic five ;
output logic [2:0] one ;
output logic run_out_ing ;
output logic valid_refri ;
output logic valid_kitch ;
output logic product_out ;
output logic [5:0] number_out ; 

//---------------------------------------------------------------------
//   PARAMETER
//---------------------------------------------------------------------
parameter S_IDLE = 3'd0, S_NUG = 3'd1, S_FRIED = 3'd2, S_APPLE = 3'd3, S_PEACH = 3'd4, S_OUT = 3'd5;

//---------------------------------------------------------------------
//   LOGIC DECLARATION
//---------------------------------------------------------------------

logic out_valid_comb;

logic        enough, enough_comb;
logic [ 2:0] state, next, temp, temp_comb;
logic [ 1:0] cnt,   cnt_comb;
logic [11:0] input_reg, input_reg_comb;

logic [3:0] ten_comb;
logic [1:0] ten_temp;

logic [2:0] one_temp, one_comb;

logic       valid_refri_comb;
logic       valid_kitch_comb;
logic       product_out_comb;
logic [5:0] number_out_comb;


logic [1:0] five_temp_2;
logic       five_temp_1, five_comb;

logic [6:0] shop_reg;

logic [6:0] sum_reg, sum_comb;

logic [6:0] nug_comb, fried_comb ;
logic [6:0] apple_comb , peach_comb;

logic run_out_ing_comb;

//---------------------------------------------------------------------
//   DON'T MODIFIED THE REGISTER'S NAME (PRODUCT REGISTER)
//---------------------------------------------------------------------
logic [6:0] nugget_in_shop, fried_rice_in_shop ;
logic [6:0] apple_in_shop , peach_in_shop ;

//---------------------------------------------------------------------

//---------------------------------------------------------------------
//   FSM
//---------------------------------------------------------------------



//---------------------------------------------------------------------
//   Your design                        
//---------------------------------------------------------------------


always_ff @(posedge clk, negedge rst_n) begin: init_ff

	if(~rst_n) begin
		state <= S_IDLE;
		temp  <= S_IDLE;
		fried_rice_in_shop <= 0;
		nugget_in_shop     <= 0;
		apple_in_shop      <= 0;
		peach_in_shop      <= 0;
	end

	else begin
		state <= next;
		temp  <= temp_comb;
		fried_rice_in_shop <= fried_comb;
		nugget_in_shop     <= nug_comb;
		apple_in_shop      <= apple_comb;
		peach_in_shop      <= peach_comb;
	end
	
end


always_comb begin : init_comb

	input_reg_comb = input_reg;
	temp_comb = temp;
	next = state;

	// five_reg_comb = 0;
	// one_reg_comb  = 0;
	// ten_reg_comb  = 0;

	valid_kitch_comb = 0;
	valid_refri_comb = 0;
	run_out_ing_comb = 0;
	out_valid_comb   = 0;
	enough_comb = enough;

	product_out_comb = 0;
	number_out_comb  = 0;


	sum_comb = sum_reg;

	// one_temp = 0;
	
	// one_reg_comb = 0;

	// ten_temp  = 0;
	ten_comb  = 0;
	one_comb  = 0;
	five_comb = 0;
	
	// five_temp_1 = 0;
	// five_temp_2 = 0;

	fried_comb = fried_rice_in_shop;
	nug_comb   = nugget_in_shop;
	apple_comb = apple_in_shop;
	peach_comb = peach_in_shop;

	if(in_valid) begin
		input_reg_comb = target_product;
		enough_comb = 1;
		next = S_PEACH;
	end

	

	else begin

		case(state)

			S_PEACH: begin

				if(input_reg[2:0] > peach_in_shop && ready_refri) begin

					number_out_comb  = 50 - peach_in_shop;
					valid_refri_comb = 1; 
					product_out_comb = 0;
					enough_comb      = 0;
					peach_comb       = 50;

					ten_comb  = 0;
					one_comb  = 0;
					five_comb = 0;

					next = S_FRIED;

				end

				// else if(!enough && peach_in_shop >= input_reg[2:0]) begin
				// 	ten_comb  = 0;
				// 	one_comb  = 0;
				// 	five_comb = 0;
				// 	next = S_FRIED;
				// end

				else if(enough && peach_in_shop >= input_reg[2:0]) begin
					sum_comb    = input_reg[2:0] * 4;
					enough_comb = 1;
					next = S_FRIED; 
				end

			end

			S_APPLE: begin

				if(input_reg[5:3] > apple_in_shop && ready_refri) begin
					number_out_comb  = 50 - apple_in_shop;
					valid_refri_comb = 1;
					product_out_comb = 1;
					enough_comb      = 0;
					apple_comb       = 50;

					ten_comb  = 0;
					one_comb  = 0;
					five_comb = 0;

					next = S_NUG; 

				end

				else if(!enough && apple_in_shop >= input_reg[5:3]) begin
					ten_comb  = 0;
					one_comb  = 0;
					five_comb = 0;
					next = S_NUG;
				end

				else if(enough && apple_in_shop >= input_reg[5:3]) begin
					sum_comb    = sum_reg + input_reg[5:3] * 2;
					enough_comb = 1;
					next = S_NUG; 
				end

			end

			S_FRIED: begin

				if(input_reg[8:6] > fried_rice_in_shop && ready_kitch) begin

					// fried_comb = fried_rice_in_shop - input_reg[8:6];

					number_out_comb  = 50 - fried_rice_in_shop;
					valid_kitch_comb = 1;
					product_out_comb = 0;
					enough_comb      = 0;
					fried_comb       = 50;

					ten_comb  = 0;
					one_comb  = 0;
					five_comb = 0;

					next = S_APPLE;

				end

				else if(!enough && fried_rice_in_shop >= input_reg[8:6]) begin
					ten_comb  = 0;
					one_comb  = 0;
					five_comb = 0;
					next = S_APPLE;
				end

				else if(enough && fried_rice_in_shop >= input_reg[8:6]) begin
					sum_comb    = sum_reg + input_reg[8:6] * 5;
					enough_comb = 1;
					next = S_APPLE; 
				end

			end

			S_NUG: begin

				if(input_reg[11:9] > nugget_in_shop && ready_kitch) begin

					number_out_comb  = 50 - nugget_in_shop;
					valid_kitch_comb = 1;
					product_out_comb = 1;
					
					enough_comb      = 0;
					nug_comb         = 50;
					out_valid_comb   = 1;
					run_out_ing_comb = 1;

					ten_comb  = 0;
					one_comb  = 0;
					five_comb = 0;

					next = S_IDLE; 

				end

				else if(!enough && nugget_in_shop >= input_reg[11:9]) begin
					ten_comb  = 0;
					one_comb  = 0;
					five_comb = 0;
					out_valid_comb   = 1;
					run_out_ing_comb = 1;
					next = S_IDLE; 
				end

				else if(enough && nugget_in_shop >= input_reg[11:9]) begin
					sum_comb    = sum_reg + input_reg[11:9] * 3;
					enough_comb = 1;
					next        = S_OUT; 
				end

			end

		endcase

		if(next == S_OUT) begin

			nug_comb   = nugget_in_shop     - input_reg[11:9];
			fried_comb = fried_rice_in_shop - input_reg[ 8:6];
			apple_comb = apple_in_shop      - input_reg[ 5:3];
			peach_comb = peach_in_shop      - input_reg[ 2:0];
			
			out_valid_comb = 1;
			{ten_comb, five_comb}  = sum_comb / 5;
			// ten_comb  = (sum_comb / 10);
			// five_comb = (sum_comb % 10) > 4;
			one_comb  = (sum_comb % 5);

			sum_comb = 0;
			next = S_IDLE;
			
		end

	end

end

always_ff @(posedge clk, negedge rst_n) begin: temp_ff

	if(~rst_n) begin

		five <= 0;
		one  <= 0;
		ten  <= 0;

		sum_reg <= 0;

		out_valid <= 0;
		enough    <= 0;

		input_reg <= 0;

		valid_kitch <= 0;
		valid_refri <= 0;

		number_out  <= 0;
		product_out <= 0;

		run_out_ing <= 0;

	end

	else begin

		// five_reg <= five_reg_comb;
		// one_reg  <= one_reg_comb;
		// ten_reg  <= ten_reg_comb;

		five <= five_comb;
		one  <= one_comb;
		ten  <= ten_comb;
		sum_reg <= sum_comb;

		out_valid <= out_valid_comb;
		enough    <= enough_comb;
		input_reg <= input_reg_comb;

		valid_kitch <= valid_kitch_comb;
		valid_refri <= valid_refri_comb;

		number_out  <= number_out_comb;
		product_out <= product_out_comb;

		run_out_ing <= run_out_ing_comb;

	end
	
end


endmodule