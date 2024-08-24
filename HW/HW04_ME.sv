module ME(
    // Input signals
	clk,
	rst_n,
    block_valid,
	area_valid,
    in_data,
    // Output signals
    out_valid,
    out_vector
);

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION                         
//---------------------------------------------------------------------
input clk, rst_n, block_valid, area_valid;
input [7:0] in_data;

output logic out_valid;
output logic signed [2:0] out_vector;

parameter S_IDLE = 2'd3, S_IN = 2'd0, S_OUT = 2'd1;


logic [ 11:0] search_0      [4:0];
logic [ 11:0] search_1      [4:0];
logic [ 10:0] search_2      [4:0];
logic [  9:0] search_3      [4:0];

logic [ 11:0] search_0_comb [4:0];
logic [ 11:0] search_1_comb [4:0];
logic [ 10:0] search_2_comb [4:0];
logic [  9:0] search_3_comb [4:0];

logic [ 11:0] CalA_0_comb   [7:0];
logic [ 11:0] CalA_1_comb   [7:0];
logic [ 10:0] CalA_2_comb   [7:0];
logic [  9:0] CalA_3_comb   [7:0];

logic [ 11:0] CalB_0_comb   [7:0];
logic [ 11:0] CalB_1_comb   [7:0];
logic [ 10:0] CalB_2_comb   [7:0];
logic [  9:0] CalB_3_comb   [7:0];

logic [  7:0] curr_block        [15:0];  
logic [  7:0] curr_block_comb   [15:0];


logic [ 11:0] smallest_val, smallest_val_comb;
logic [  5:0] smallest_pos, smallest_pos_comb;
logic [  2:0] xpos, ypos;

logic [  5:0] input_cnt,   input_cnt_comb; // original [63:0] slack met
logic [  1:0] state,       next;

logic signed [2:0] out_vector_comb;
logic              out_valid_comb;


//---------------------------------------------------------------------
//   Your design                        
//---------------------------------------------------------------------

always_ff @(posedge clk, negedge rst_n) begin : Init_ff
    if(!rst_n) state = S_IDLE;
    else       state = next;
end

always_comb begin : State_comb

    // register
	search_0_comb[0] = search_0[0];	search_0_comb[1] = search_0[1];	search_0_comb[2] = search_0[2];	search_0_comb[3] = search_0[3];	search_0_comb[4] = search_0[4];
	search_1_comb[0] = search_1[0];	search_1_comb[1] = search_1[1];	search_1_comb[2] = search_1[2];	search_1_comb[3] = search_1[3];	search_1_comb[4] = search_1[4];
	search_2_comb[0] = search_2[0];	search_2_comb[1] = search_2[1];	search_2_comb[2] = search_2[2];	search_2_comb[3] = search_2[3];	search_2_comb[4] = search_2[4];
	search_3_comb[0] = search_3[0];	search_3_comb[1] = search_3[1];	search_3_comb[2] = search_3[2];	search_3_comb[3] = search_3[3];	search_3_comb[4] = search_3[4];

	curr_block_comb[ 0] = curr_block[ 0];	curr_block_comb[ 1] = curr_block[ 1];	curr_block_comb[ 2] = curr_block[ 2];	curr_block_comb[ 3] = curr_block[ 3];
	curr_block_comb[ 4] = curr_block[ 4];	curr_block_comb[ 5] = curr_block[ 5];	curr_block_comb[ 6] = curr_block[ 6];	curr_block_comb[ 7] = curr_block[ 7];
	curr_block_comb[ 8] = curr_block[ 8];	curr_block_comb[ 9] = curr_block[ 9];	curr_block_comb[10] = curr_block[10];	curr_block_comb[11] = curr_block[11];
	curr_block_comb[12] = curr_block[12];	curr_block_comb[13] = curr_block[13];	curr_block_comb[14] = curr_block[14];	curr_block_comb[15] = curr_block[15];

    smallest_pos_comb = smallest_pos;
    smallest_val_comb = smallest_val;

    // counter
    input_cnt_comb = input_cnt;
    
    // state
    next = state;

    // Output
    out_valid_comb  = out_valid;
    out_vector_comb = out_vector;

    // comb logic
	CalA_0_comb[0] = 0;	CalA_0_comb[1] = 0;	CalA_0_comb[2] = 0;	CalA_0_comb[3] = search_0[0];	CalA_0_comb[4] = search_0[1];	CalA_0_comb[5] = search_0[2];	CalA_0_comb[6] = search_0[3];	CalA_0_comb[7] = search_0[4];
	CalA_1_comb[0] = 0;	CalA_1_comb[1] = 0;	CalA_1_comb[2] = 0;	CalA_1_comb[3] = search_1[0];	CalA_1_comb[4] = search_1[1];	CalA_1_comb[5] = search_1[2];	CalA_1_comb[6] = search_1[3];	CalA_1_comb[7] = search_1[4];
	CalA_2_comb[0] = 0;	CalA_2_comb[1] = 0;	CalA_2_comb[2] = 0;	CalA_2_comb[3] = search_2[0];	CalA_2_comb[4] = search_2[1];	CalA_2_comb[5] = search_2[2];	CalA_2_comb[6] = search_2[3];	CalA_2_comb[7] = search_2[4];
	CalA_3_comb[0] = 0;	CalA_3_comb[1] = 0;	CalA_3_comb[2] = 0;	CalA_3_comb[3] = search_3[0];	CalA_3_comb[4] = search_3[1];	CalA_3_comb[5] = search_3[2];	CalA_3_comb[6] = search_3[3];	CalA_3_comb[7] = search_3[4];

	CalB_0_comb[0] = 0;	CalB_0_comb[1] = 0;	CalB_0_comb[2] = 0;	CalB_0_comb[3] = search_0[0];	CalB_0_comb[4] = search_0[1];	CalB_0_comb[5] = search_0[2];	CalB_0_comb[6] = search_0[3];	CalB_0_comb[7] = search_0[4];
	CalB_1_comb[0] = 0;	CalB_1_comb[1] = 0;	CalB_1_comb[2] = 0;	CalB_1_comb[3] = search_1[0];	CalB_1_comb[4] = search_1[1];	CalB_1_comb[5] = search_1[2];	CalB_1_comb[6] = search_1[3];	CalB_1_comb[7] = search_1[4];
	CalB_2_comb[0] = 0;	CalB_2_comb[1] = 0;	CalB_2_comb[2] = 0;	CalB_2_comb[3] = search_2[0];	CalB_2_comb[4] = search_2[1];	CalB_2_comb[5] = search_2[2];	CalB_2_comb[6] = search_2[3];	CalB_2_comb[7] = search_2[4];
	CalB_3_comb[0] = 0;	CalB_3_comb[1] = 0;	CalB_3_comb[2] = 0;	CalB_3_comb[3] = search_3[0];	CalB_3_comb[4] = search_3[1];	CalB_3_comb[5] = search_3[2];	CalB_3_comb[6] = search_3[3];	CalB_3_comb[7] = search_3[4];

    {ypos, xpos}  = input_cnt;   

	CalA_0_comb[xpos+0] = (in_data > curr_block[ 0]) ? CalB_0_comb[xpos+0] + in_data - curr_block[ 0] : CalB_0_comb[xpos+0] + curr_block[ 0] - in_data; 
	CalA_0_comb[xpos+1] = (in_data > curr_block[ 1]) ? CalB_0_comb[xpos+1] + in_data - curr_block[ 1] : CalB_0_comb[xpos+1] + curr_block[ 1] - in_data; 
	CalA_0_comb[xpos+2] = (in_data > curr_block[ 2]) ? CalB_0_comb[xpos+2] + in_data - curr_block[ 2] : CalB_0_comb[xpos+2] + curr_block[ 2] - in_data; 
	CalA_0_comb[xpos+3] = (in_data > curr_block[ 3]) ? CalB_0_comb[xpos+3] + in_data - curr_block[ 3] : CalB_0_comb[xpos+3] + curr_block[ 3] - in_data; 
	CalA_1_comb[xpos+0] = (in_data > curr_block[ 4]) ? CalB_1_comb[xpos+0] + in_data - curr_block[ 4] : CalB_1_comb[xpos+0] + curr_block[ 4] - in_data; 
	CalA_1_comb[xpos+1] = (in_data > curr_block[ 5]) ? CalB_1_comb[xpos+1] + in_data - curr_block[ 5] : CalB_1_comb[xpos+1] + curr_block[ 5] - in_data; 
	CalA_1_comb[xpos+2] = (in_data > curr_block[ 6]) ? CalB_1_comb[xpos+2] + in_data - curr_block[ 6] : CalB_1_comb[xpos+2] + curr_block[ 6] - in_data; 
	CalA_1_comb[xpos+3] = (in_data > curr_block[ 7]) ? CalB_1_comb[xpos+3] + in_data - curr_block[ 7] : CalB_1_comb[xpos+3] + curr_block[ 7] - in_data; 
	CalA_2_comb[xpos+0] = (in_data > curr_block[ 8]) ? CalB_2_comb[xpos+0] + in_data - curr_block[ 8] : CalB_2_comb[xpos+0] + curr_block[ 8] - in_data; 
	CalA_2_comb[xpos+1] = (in_data > curr_block[ 9]) ? CalB_2_comb[xpos+1] + in_data - curr_block[ 9] : CalB_2_comb[xpos+1] + curr_block[ 9] - in_data; 
	CalA_2_comb[xpos+2] = (in_data > curr_block[10]) ? CalB_2_comb[xpos+2] + in_data - curr_block[10] : CalB_2_comb[xpos+2] + curr_block[10] - in_data; 
	CalA_2_comb[xpos+3] = (in_data > curr_block[11]) ? CalB_2_comb[xpos+3] + in_data - curr_block[11] : CalB_2_comb[xpos+3] + curr_block[11] - in_data; 
	CalA_3_comb[xpos+0] = (in_data > curr_block[12]) ? CalB_3_comb[xpos+0] + in_data - curr_block[12] : CalB_3_comb[xpos+0] + curr_block[12] - in_data; 
	CalA_3_comb[xpos+1] = (in_data > curr_block[13]) ? CalB_3_comb[xpos+1] + in_data - curr_block[13] : CalB_3_comb[xpos+1] + curr_block[13] - in_data; 
	CalA_3_comb[xpos+2] = (in_data > curr_block[14]) ? CalB_3_comb[xpos+2] + in_data - curr_block[14] : CalB_3_comb[xpos+2] + curr_block[14] - in_data; 
	CalA_3_comb[xpos+3] = (in_data > curr_block[15]) ? CalB_3_comb[xpos+3] + in_data - curr_block[15] : CalB_3_comb[xpos+3] + curr_block[15] - in_data; 

    case(state)

        S_IDLE: begin

            search_0_comb[0] = 0;	search_0_comb[1] = 0;	search_0_comb[2] = 0;	search_0_comb[3] = 0;	search_0_comb[4] = 0;
            search_1_comb[0] = 0;	search_1_comb[1] = 0;	search_1_comb[2] = 0;	search_1_comb[3] = 0;	search_1_comb[4] = 0;
            search_2_comb[0] = 0;	search_2_comb[1] = 0;	search_2_comb[2] = 0;	search_2_comb[3] = 0;	search_2_comb[4] = 0;
            search_3_comb[0] = 0;	search_3_comb[1] = 0;	search_3_comb[2] = 0;	search_3_comb[3] = 0;	search_3_comb[4] = 0;

            curr_block_comb[ 0] = 0;	curr_block_comb[ 1] = 0;	curr_block_comb[ 2] = 0;	curr_block_comb[ 3] = 0;
            curr_block_comb[ 4] = 0;	curr_block_comb[ 5] = 0;	curr_block_comb[ 6] = 0;	curr_block_comb[ 7] = 0;
            curr_block_comb[ 8] = 0;	curr_block_comb[ 9] = 0;	curr_block_comb[10] = 0;	curr_block_comb[11] = 0;
            curr_block_comb[12] = 0;	curr_block_comb[13] = 0;	curr_block_comb[14] = 0;	curr_block_comb[15] = 0;

            smallest_val_comb = ~128'd0;
            smallest_pos_comb = 0;
            input_cnt_comb    = 0;

            out_vector_comb   = 0; 
            out_valid_comb    = 0;

            next = S_IN;

        end

        S_IN:   begin

            if(block_valid) begin

                {curr_block_comb[15], curr_block_comb[14], curr_block_comb[13], curr_block_comb[12], 
                 curr_block_comb[11], curr_block_comb[10], curr_block_comb[ 9], curr_block_comb[ 8], 
                 curr_block_comb[ 7], curr_block_comb[ 6], curr_block_comb[ 5], curr_block_comb[ 4], 
                 curr_block_comb[ 3], curr_block_comb[ 2], curr_block_comb[ 1], curr_block_comb[ 0]} = 

                {curr_block[14], curr_block[13], curr_block[12], curr_block[11], 
                 curr_block[10], curr_block[ 9], curr_block[ 8], curr_block[ 7], 
                 curr_block[ 6], curr_block[ 5], curr_block[ 4], curr_block[ 3], 
                 curr_block[ 2], curr_block[ 1], curr_block[ 0], in_data};

            end

            else if(area_valid) begin

                input_cnt_comb = input_cnt + 8'd1;

                if(xpos >= 3 && ypos >= 3) begin 
                    if(CalA_0_comb[xpos] < smallest_val_comb) begin 
                        smallest_val_comb = CalA_0_comb[xpos];
                        smallest_pos_comb = input_cnt;
                    end
                end

                search_0_comb[0] = CalA_0_comb[3];	search_0_comb[1] = CalA_0_comb[4];	search_0_comb[2] = CalA_0_comb[5];	search_0_comb[3] = CalA_0_comb[6];	search_0_comb[4] = CalA_0_comb[7];
                search_1_comb[0] = CalA_1_comb[3];	search_1_comb[1] = CalA_1_comb[4];	search_1_comb[2] = CalA_1_comb[5];	search_1_comb[3] = CalA_1_comb[6];	search_1_comb[4] = CalA_1_comb[7];
                search_2_comb[0] = CalA_2_comb[3];	search_2_comb[1] = CalA_2_comb[4];	search_2_comb[2] = CalA_2_comb[5];	search_2_comb[3] = CalA_2_comb[6];	search_2_comb[4] = CalA_2_comb[7];
                search_3_comb[0] = CalA_3_comb[3];	search_3_comb[1] = CalA_3_comb[4];	search_3_comb[2] = CalA_3_comb[5];	search_3_comb[3] = CalA_3_comb[6];	search_3_comb[4] = CalA_3_comb[7];
                            
                if(xpos == 7) begin
                    search_0_comb[0] = CalA_1_comb[3];	search_0_comb[1] = CalA_1_comb[4];	search_0_comb[2] = CalA_1_comb[5];	search_0_comb[3] = CalA_1_comb[6];	search_0_comb[4] = CalA_1_comb[7];
                    search_1_comb[0] = CalA_2_comb[3];	search_1_comb[1] = CalA_2_comb[4];	search_1_comb[2] = CalA_2_comb[5];	search_1_comb[3] = CalA_2_comb[6];	search_1_comb[4] = CalA_2_comb[7];
                    search_2_comb[0] = CalA_3_comb[3];	search_2_comb[1] = CalA_3_comb[4];	search_2_comb[2] = CalA_3_comb[5];	search_2_comb[3] = CalA_3_comb[6];	search_2_comb[4] = CalA_3_comb[7];
                    search_3_comb[0] = 0;               search_3_comb[1] = 0;	            search_3_comb[2] = 0;               search_3_comb[3] = 0;               search_3_comb[4] = 0;
                end

                if(input_cnt == 63) begin next = S_OUT; input_cnt_comb = 0; end

            end

        end 

        S_OUT:  begin

            out_valid_comb = 1;
            input_cnt_comb[0] = 1'b1;

            if(input_cnt[0]) begin out_vector_comb = 5 - smallest_pos[5:3]; next = S_IDLE; end
            else             begin out_vector_comb = smallest_pos[2:0] - 5;                end

        end


    endcase

end

always_ff @(posedge clk) begin : reg_ff

	search_0[0] = search_0_comb[0];	search_0[1] = search_0_comb[1];	search_0[2] = search_0_comb[2];	search_0[3] = search_0_comb[3];	search_0[4] = search_0_comb[4];
	search_1[0] = search_1_comb[0];	search_1[1] = search_1_comb[1];	search_1[2] = search_1_comb[2];	search_1[3] = search_1_comb[3];	search_1[4] = search_1_comb[4];
	search_2[0] = search_2_comb[0];	search_2[1] = search_2_comb[1];	search_2[2] = search_2_comb[2];	search_2[3] = search_2_comb[3];	search_2[4] = search_2_comb[4];
	search_3[0] = search_3_comb[0];	search_3[1] = search_3_comb[1];	search_3[2] = search_3_comb[2];	search_3[3] = search_3_comb[3];	search_3[4] = search_3_comb[4];

	curr_block[ 0] = curr_block_comb[ 0];	curr_block[ 1] = curr_block_comb[ 1];	curr_block[ 2] = curr_block_comb[ 2];	curr_block[ 3] = curr_block_comb[ 3];
	curr_block[ 4] = curr_block_comb[ 4];	curr_block[ 5] = curr_block_comb[ 5];	curr_block[ 6] = curr_block_comb[ 6];	curr_block[ 7] = curr_block_comb[ 7];
	curr_block[ 8] = curr_block_comb[ 8];	curr_block[ 9] = curr_block_comb[ 9];	curr_block[10] = curr_block_comb[10];	curr_block[11] = curr_block_comb[11];
	curr_block[12] = curr_block_comb[12];	curr_block[13] = curr_block_comb[13];	curr_block[14] = curr_block_comb[14];	curr_block[15] = curr_block_comb[15];

	smallest_val = smallest_val_comb;
	smallest_pos = smallest_pos_comb;
	input_cnt    = input_cnt_comb;

end

always_ff @(posedge clk, negedge rst_n) begin : out_ff

    if(!rst_n) begin 
        out_valid  = 0;
        out_vector = 0; 
    end else begin 
        out_valid  = out_valid_comb; 
        out_vector = out_vector_comb; 
    end

end

endmodule

