// cycle time: 3.7 / area: 627595.220910

module DCSformer(
	// Input signals
	clk,
	rst_n,
	i_valid,
	w_valid,
	i_data,
	w_data,
	// Output signals
	w_ready,
	o_valid,
	o_data
);

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION                         
//---------------------------------------------------------------------
input               clk, rst_n, i_valid, w_valid;
input         [7:0] i_data, w_data;
output logic        w_ready, o_valid;
output logic [31:0] o_data;
//---------------------------------------------------------------------
//   Your design                       
//---------------------------------------------------------------------

parameter S_OUT = 1'b0, S_OP = 1'b1;

logic [19:0] pipe_vec_0, pipe_vec_0_comb;
logic [19:0] pipe_vec_1, pipe_vec_1_comb;
logic [19:0] pipe_vec_2, pipe_vec_2_comb;
logic [19:0] pipe_vec_3, pipe_vec_3_comb;
logic [19:0] pipe_vec_4, pipe_vec_4_comb;
logic [19:0] pipe_vec_5, pipe_vec_5_comb;
logic [19:0] pipe_vec_6, pipe_vec_6_comb;
logic [19:0] pipe_vec_7, pipe_vec_7_comb;

logic [19:0] pipe_reg_0 [6:0], pipe_reg_comb_0 [6:0];
logic [19:0] pipe_reg_1 [7:0], pipe_reg_comb_1 [7:0];
logic [19:0] pipe_reg_2 [8:0], pipe_reg_comb_2 [8:0];
logic [19:0] pipe_reg_4 [0:0], pipe_reg_comb_4 [0:0];
logic [19:0] pipe_reg_6 [0:0], pipe_reg_comb_6 [0:0];

logic [19:0] matrix_out_0 [7:0], matrix_out_comb_0 [7:0];
logic [19:0] matrix_out_1 [7:1], matrix_out_comb_1 [7:1];
logic [19:0] matrix_out_2 [7:2], matrix_out_comb_2 [7:2];
logic [19:0] matrix_out_3 [7:3], matrix_out_comb_3 [7:3];
logic [19:0] matrix_out_4 [7:4], matrix_out_comb_4 [7:4];
logic [19:0] matrix_out_5 [7:5], matrix_out_comb_5 [7:5];
logic [19:0] matrix_out_6 [7:6], matrix_out_comb_6 [7:6];
logic [19:0] matrix_out_7 [7:7], matrix_out_comb_7 [7:7];

logic [19:0] matrix_out [7:0][7:0],    matrix_out_comb [7:0][7:0]; 
logic [ 4:0] pipe_cnt,   pipe_cnt_comb ;
// logic [31:0] vec_o [7:0], vec_o_comb [7:0], vec_o_reg [7:0];

logic [31:0] vec_rat_comb [7:0];

logic        out_flag , out_flag_comb;
logic        i_valid_reg_0, i_valid_reg_1, i_valid_reg_2, i_valid_reg_3;
logic        w_valid_reg_0, w_valid_reg_1, w_valid_reg_2, w_valid_reg_3, w_valid_reg_4;
logic [ 7:0] w_data_reg_0,  w_data_reg_1,  w_data_reg_2;

logic [19:0] vec_in_A_comb  [7:0], vec_in_A  [7:0];
logic [ 7:0] vec_in_B_comb  [7:0], vec_in_B  [7:0];
logic [27:0] vec_out_1_comb [7:0], vec_out_1 [7:0];
logic [31:0] vec_out_2_comb [7:0], vec_out_2 [7:0];
logic [31:0] o_data_comb;

logic [31:0] vec_o_comb   [7:0], vec_o   [7:0];
logic [22:0] vec_sum_comb [7:0], vec_sum [7:0];

logic [21:0] vec_sum_comb_1 [7:0], vec_sum_1 [7:0];
logic [22:0] vec_sum_comb_2 [7:0], vec_sum_2 [7:0];

logic [19:0] vec_avg_comb [7:0], vec_avg [7:0], vec_avg_temp [7:0], vec_avg_reg [7:0];

logic [ 8:0] matrix_I_comb    [7:0][15:0], matrix_I   [7:0][15:0];
logic [19:0] matrix_IIT_comb  [7:0][ 7:0], matrix_IIT [7:0][ 7:0];

logic [8:0] cnt, cnt_comb;
logic       cnt_flag, cnt_flag_comb;
logic       w_ready_reg_0, w_ready_reg_1, w_ready_reg_2, w_ready_reg_3;
logic       o_valid_comb;

logic       state, next;


//---------------------------------------------------------------------
//   FSM                    
//---------------------------------------------------------------------

always_comb begin : fsm_comb

	next = state;

	case(state)
		S_OP:  next = (cnt[3] && w_valid_reg_3) ? S_OUT : state;
		S_OUT: next = (vec_o[0] == 1) ? S_OP : state;
	endcase

	if(i_valid | w_valid) next = S_OP;

end


always_ff @(posedge clk) begin
	state <= next;
end


//---------------------------------------------------------------------
//   Matrix Input                    
//---------------------------------------------------------------------

always_ff @(posedge clk) begin

	i_valid_reg_0 <= i_valid;
	i_valid_reg_1 <= i_valid_reg_0;
	i_valid_reg_2 <= i_valid_reg_1;
	i_valid_reg_3 <= i_valid_reg_2;

	w_valid_reg_0 <= w_valid;
	w_valid_reg_1 <= w_valid_reg_0;
	w_valid_reg_2 <= w_valid_reg_1;
	w_valid_reg_3 <= w_valid_reg_2;
	w_valid_reg_4 <= w_valid_reg_3;

	w_data_reg_0 <= w_data;

end


always_comb begin : input_matrix_comb

	matrix_IIT_comb = matrix_IIT;
	matrix_I_comb   = matrix_I;

	// if(i_valid) begin
	matrix_I_comb[0][0] = matrix_I[0][1];  	matrix_I_comb[0][1] = matrix_I[0][2];  	matrix_I_comb[0][2] = matrix_I[0][3];  	matrix_I_comb[0][3] = matrix_I[0][4];  	matrix_I_comb[0][4] = matrix_I[0][5];  	matrix_I_comb[0][5] = matrix_I[0][6];  	matrix_I_comb[0][6] = matrix_I[0][7];  	matrix_I_comb[0][7] = matrix_I[0][8];  	matrix_I_comb[0][8] = matrix_I[0][9];  	matrix_I_comb[0][9] = matrix_I[0][10];  	matrix_I_comb[0][10] = matrix_I[0][11];  	matrix_I_comb[0][11] = matrix_I[0][12];  	matrix_I_comb[0][12] = matrix_I[0][13];  	matrix_I_comb[0][13] = matrix_I[0][14];  	matrix_I_comb[0][14] = matrix_I[0][15];  	matrix_I_comb[0][15] = matrix_I[1][0];
	matrix_I_comb[1][0] = matrix_I[1][1];  	matrix_I_comb[1][1] = matrix_I[1][2];  	matrix_I_comb[1][2] = matrix_I[1][3];  	matrix_I_comb[1][3] = matrix_I[1][4];  	matrix_I_comb[1][4] = matrix_I[1][5];  	matrix_I_comb[1][5] = matrix_I[1][6];  	matrix_I_comb[1][6] = matrix_I[1][7];  	matrix_I_comb[1][7] = matrix_I[1][8];  	matrix_I_comb[1][8] = matrix_I[1][9];  	matrix_I_comb[1][9] = matrix_I[1][10];  	matrix_I_comb[1][10] = matrix_I[1][11];  	matrix_I_comb[1][11] = matrix_I[1][12];  	matrix_I_comb[1][12] = matrix_I[1][13];  	matrix_I_comb[1][13] = matrix_I[1][14];  	matrix_I_comb[1][14] = matrix_I[1][15];  	matrix_I_comb[1][15] = matrix_I[2][0];
	matrix_I_comb[2][0] = matrix_I[2][1];  	matrix_I_comb[2][1] = matrix_I[2][2];  	matrix_I_comb[2][2] = matrix_I[2][3];  	matrix_I_comb[2][3] = matrix_I[2][4];  	matrix_I_comb[2][4] = matrix_I[2][5];  	matrix_I_comb[2][5] = matrix_I[2][6];  	matrix_I_comb[2][6] = matrix_I[2][7];  	matrix_I_comb[2][7] = matrix_I[2][8];  	matrix_I_comb[2][8] = matrix_I[2][9];  	matrix_I_comb[2][9] = matrix_I[2][10];  	matrix_I_comb[2][10] = matrix_I[2][11];  	matrix_I_comb[2][11] = matrix_I[2][12];  	matrix_I_comb[2][12] = matrix_I[2][13];  	matrix_I_comb[2][13] = matrix_I[2][14];  	matrix_I_comb[2][14] = matrix_I[2][15];  	matrix_I_comb[2][15] = matrix_I[3][0];
	matrix_I_comb[3][0] = matrix_I[3][1];  	matrix_I_comb[3][1] = matrix_I[3][2];  	matrix_I_comb[3][2] = matrix_I[3][3];  	matrix_I_comb[3][3] = matrix_I[3][4];  	matrix_I_comb[3][4] = matrix_I[3][5];  	matrix_I_comb[3][5] = matrix_I[3][6];  	matrix_I_comb[3][6] = matrix_I[3][7];  	matrix_I_comb[3][7] = matrix_I[3][8];  	matrix_I_comb[3][8] = matrix_I[3][9];  	matrix_I_comb[3][9] = matrix_I[3][10];  	matrix_I_comb[3][10] = matrix_I[3][11];  	matrix_I_comb[3][11] = matrix_I[3][12];  	matrix_I_comb[3][12] = matrix_I[3][13];  	matrix_I_comb[3][13] = matrix_I[3][14];  	matrix_I_comb[3][14] = matrix_I[3][15];  	matrix_I_comb[3][15] = matrix_I[4][0];
	matrix_I_comb[4][0] = matrix_I[4][1];  	matrix_I_comb[4][1] = matrix_I[4][2];  	matrix_I_comb[4][2] = matrix_I[4][3];  	matrix_I_comb[4][3] = matrix_I[4][4];  	matrix_I_comb[4][4] = matrix_I[4][5];  	matrix_I_comb[4][5] = matrix_I[4][6];  	matrix_I_comb[4][6] = matrix_I[4][7];  	matrix_I_comb[4][7] = matrix_I[4][8];  	matrix_I_comb[4][8] = matrix_I[4][9];  	matrix_I_comb[4][9] = matrix_I[4][10];  	matrix_I_comb[4][10] = matrix_I[4][11];  	matrix_I_comb[4][11] = matrix_I[4][12];  	matrix_I_comb[4][12] = matrix_I[4][13];  	matrix_I_comb[4][13] = matrix_I[4][14];  	matrix_I_comb[4][14] = matrix_I[4][15];  	matrix_I_comb[4][15] = matrix_I[5][0];
	matrix_I_comb[5][0] = matrix_I[5][1];  	matrix_I_comb[5][1] = matrix_I[5][2];  	matrix_I_comb[5][2] = matrix_I[5][3];  	matrix_I_comb[5][3] = matrix_I[5][4];  	matrix_I_comb[5][4] = matrix_I[5][5];  	matrix_I_comb[5][5] = matrix_I[5][6];  	matrix_I_comb[5][6] = matrix_I[5][7];  	matrix_I_comb[5][7] = matrix_I[5][8];  	matrix_I_comb[5][8] = matrix_I[5][9];  	matrix_I_comb[5][9] = matrix_I[5][10];  	matrix_I_comb[5][10] = matrix_I[5][11];  	matrix_I_comb[5][11] = matrix_I[5][12];  	matrix_I_comb[5][12] = matrix_I[5][13];  	matrix_I_comb[5][13] = matrix_I[5][14];  	matrix_I_comb[5][14] = matrix_I[5][15];  	matrix_I_comb[5][15] = matrix_I[6][0];
	matrix_I_comb[6][0] = matrix_I[6][1];  	matrix_I_comb[6][1] = matrix_I[6][2];  	matrix_I_comb[6][2] = matrix_I[6][3];  	matrix_I_comb[6][3] = matrix_I[6][4];  	matrix_I_comb[6][4] = matrix_I[6][5];  	matrix_I_comb[6][5] = matrix_I[6][6];  	matrix_I_comb[6][6] = matrix_I[6][7];  	matrix_I_comb[6][7] = matrix_I[6][8];  	matrix_I_comb[6][8] = matrix_I[6][9];  	matrix_I_comb[6][9] = matrix_I[6][10];  	matrix_I_comb[6][10] = matrix_I[6][11];  	matrix_I_comb[6][11] = matrix_I[6][12];  	matrix_I_comb[6][12] = matrix_I[6][13];  	matrix_I_comb[6][13] = matrix_I[6][14];  	matrix_I_comb[6][14] = matrix_I[6][15];  	matrix_I_comb[6][15] = matrix_I[7][0];
	matrix_I_comb[7][0] = matrix_I[7][1];	matrix_I_comb[7][1] = matrix_I[7][2];  	matrix_I_comb[7][2] = matrix_I[7][3];  	matrix_I_comb[7][3] = matrix_I[7][4];  	matrix_I_comb[7][4] = matrix_I[7][5];  	matrix_I_comb[7][5] = matrix_I[7][6];  	matrix_I_comb[7][6] = matrix_I[7][7];  	matrix_I_comb[7][7] = matrix_I[7][8];  	matrix_I_comb[7][8] = matrix_I[7][9];  	matrix_I_comb[7][9] = matrix_I[7][10];  	matrix_I_comb[7][10] = matrix_I[7][11];  	matrix_I_comb[7][11] = matrix_I[7][12];  	matrix_I_comb[7][12] = matrix_I[7][13];  	matrix_I_comb[7][13] = matrix_I[7][14];  	matrix_I_comb[7][14] = matrix_I[7][15];  	matrix_I_comb[7][15] = i_data;
	// end

	if(w_valid_reg_0) begin
		matrix_IIT_comb[0][0] = matrix_IIT[0][1];	matrix_IIT_comb[0][1] = matrix_IIT[0][2];	matrix_IIT_comb[0][2] = matrix_IIT[0][3];	matrix_IIT_comb[0][3] = matrix_IIT[0][4];	matrix_IIT_comb[0][4] = matrix_IIT[0][5];	matrix_IIT_comb[0][5] = matrix_IIT[0][6];	matrix_IIT_comb[0][6] = matrix_IIT[0][7];	matrix_IIT_comb[0][7] = 0;
		matrix_IIT_comb[1][0] = matrix_IIT[1][1];	matrix_IIT_comb[1][1] = matrix_IIT[1][2];	matrix_IIT_comb[1][2] = matrix_IIT[1][3];	matrix_IIT_comb[1][3] = matrix_IIT[1][4];	matrix_IIT_comb[1][4] = matrix_IIT[1][5];	matrix_IIT_comb[1][5] = matrix_IIT[1][6];	matrix_IIT_comb[1][6] = matrix_IIT[1][7];	matrix_IIT_comb[1][7] = 0;
		matrix_IIT_comb[2][0] = matrix_IIT[2][1];	matrix_IIT_comb[2][1] = matrix_IIT[2][2];	matrix_IIT_comb[2][2] = matrix_IIT[2][3];	matrix_IIT_comb[2][3] = matrix_IIT[2][4];	matrix_IIT_comb[2][4] = matrix_IIT[2][5];	matrix_IIT_comb[2][5] = matrix_IIT[2][6];	matrix_IIT_comb[2][6] = matrix_IIT[2][7];	matrix_IIT_comb[2][7] = 0;
		matrix_IIT_comb[3][0] = matrix_IIT[3][1];	matrix_IIT_comb[3][1] = matrix_IIT[3][2];	matrix_IIT_comb[3][2] = matrix_IIT[3][3];	matrix_IIT_comb[3][3] = matrix_IIT[3][4];	matrix_IIT_comb[3][4] = matrix_IIT[3][5];	matrix_IIT_comb[3][5] = matrix_IIT[3][6];	matrix_IIT_comb[3][6] = matrix_IIT[3][7];	matrix_IIT_comb[3][7] = 0;
		matrix_IIT_comb[4][0] = matrix_IIT[4][1];	matrix_IIT_comb[4][1] = matrix_IIT[4][2];	matrix_IIT_comb[4][2] = matrix_IIT[4][3];	matrix_IIT_comb[4][3] = matrix_IIT[4][4];	matrix_IIT_comb[4][4] = matrix_IIT[4][5];	matrix_IIT_comb[4][5] = matrix_IIT[4][6];	matrix_IIT_comb[4][6] = matrix_IIT[4][7];	matrix_IIT_comb[4][7] = 0;
		matrix_IIT_comb[5][0] = matrix_IIT[5][1];	matrix_IIT_comb[5][1] = matrix_IIT[5][2];	matrix_IIT_comb[5][2] = matrix_IIT[5][3];	matrix_IIT_comb[5][3] = matrix_IIT[5][4];	matrix_IIT_comb[5][4] = matrix_IIT[5][5];	matrix_IIT_comb[5][5] = matrix_IIT[5][6];	matrix_IIT_comb[5][6] = matrix_IIT[5][7];	matrix_IIT_comb[5][7] = 0;
		matrix_IIT_comb[6][0] = matrix_IIT[6][1];	matrix_IIT_comb[6][1] = matrix_IIT[6][2];	matrix_IIT_comb[6][2] = matrix_IIT[6][3];	matrix_IIT_comb[6][3] = matrix_IIT[6][4];	matrix_IIT_comb[6][4] = matrix_IIT[6][5];	matrix_IIT_comb[6][5] = matrix_IIT[6][6];	matrix_IIT_comb[6][6] = matrix_IIT[6][7];	matrix_IIT_comb[6][7] = 0;
		matrix_IIT_comb[7][0] = matrix_IIT[7][1];	matrix_IIT_comb[7][1] = matrix_IIT[7][2];	matrix_IIT_comb[7][2] = matrix_IIT[7][3];	matrix_IIT_comb[7][3] = matrix_IIT[7][4];	matrix_IIT_comb[7][4] = matrix_IIT[7][5];	matrix_IIT_comb[7][5] = matrix_IIT[7][6];	matrix_IIT_comb[7][6] = matrix_IIT[7][7];	matrix_IIT_comb[7][7] = 0;
	end

	if(out_flag) begin
		matrix_IIT_comb[0][0] = matrix_out_0[0];	matrix_IIT_comb[0][1] = matrix_out_0[1];	matrix_IIT_comb[0][2] = matrix_out_0[2];	matrix_IIT_comb[0][3] = matrix_out_0[3];	matrix_IIT_comb[0][4] = matrix_out_0[4];	matrix_IIT_comb[0][5] = matrix_out_0[5];	matrix_IIT_comb[0][6] = matrix_out_0[6];	matrix_IIT_comb[0][7] = matrix_out_0[7];
		matrix_IIT_comb[1][0] = matrix_out_0[1];	matrix_IIT_comb[1][1] = matrix_out_1[1];	matrix_IIT_comb[1][2] = matrix_out_1[2];	matrix_IIT_comb[1][3] = matrix_out_1[3];	matrix_IIT_comb[1][4] = matrix_out_1[4];	matrix_IIT_comb[1][5] = matrix_out_1[5];	matrix_IIT_comb[1][6] = matrix_out_1[6];	matrix_IIT_comb[1][7] = matrix_out_1[7];
		matrix_IIT_comb[2][0] = matrix_out_0[2];	matrix_IIT_comb[2][1] = matrix_out_1[2];	matrix_IIT_comb[2][2] = matrix_out_2[2];	matrix_IIT_comb[2][3] = matrix_out_2[3];	matrix_IIT_comb[2][4] = matrix_out_2[4];	matrix_IIT_comb[2][5] = matrix_out_2[5];	matrix_IIT_comb[2][6] = matrix_out_2[6];	matrix_IIT_comb[2][7] = matrix_out_2[7];
		matrix_IIT_comb[3][0] = matrix_out_0[3];	matrix_IIT_comb[3][1] = matrix_out_1[3];	matrix_IIT_comb[3][2] = matrix_out_2[3];	matrix_IIT_comb[3][3] = matrix_out_3[3];	matrix_IIT_comb[3][4] = matrix_out_3[4];	matrix_IIT_comb[3][5] = matrix_out_3[5];	matrix_IIT_comb[3][6] = matrix_out_3[6];	matrix_IIT_comb[3][7] = matrix_out_3[7];
		matrix_IIT_comb[4][0] = matrix_out_0[4];	matrix_IIT_comb[4][1] = matrix_out_1[4];	matrix_IIT_comb[4][2] = matrix_out_2[4];	matrix_IIT_comb[4][3] = matrix_out_3[4];	matrix_IIT_comb[4][4] = matrix_out_4[4];	matrix_IIT_comb[4][5] = matrix_out_4[5];	matrix_IIT_comb[4][6] = matrix_out_4[6];	matrix_IIT_comb[4][7] = matrix_out_4[7];
		matrix_IIT_comb[5][0] = matrix_out_0[5];	matrix_IIT_comb[5][1] = matrix_out_1[5];	matrix_IIT_comb[5][2] = matrix_out_2[5];	matrix_IIT_comb[5][3] = matrix_out_3[5];	matrix_IIT_comb[5][4] = matrix_out_4[5];	matrix_IIT_comb[5][5] = matrix_out_5[5];	matrix_IIT_comb[5][6] = matrix_out_5[6];	matrix_IIT_comb[5][7] = matrix_out_5[7];
		matrix_IIT_comb[6][0] = matrix_out_0[6];	matrix_IIT_comb[6][1] = matrix_out_1[6];	matrix_IIT_comb[6][2] = matrix_out_2[6];	matrix_IIT_comb[6][3] = matrix_out_3[6];	matrix_IIT_comb[6][4] = matrix_out_4[6];	matrix_IIT_comb[6][5] = matrix_out_5[6];	matrix_IIT_comb[6][6] = matrix_out_6[6];	matrix_IIT_comb[6][7] = matrix_out_6[7];
		matrix_IIT_comb[7][0] = matrix_out_0[7];	matrix_IIT_comb[7][1] = matrix_out_1[7];	matrix_IIT_comb[7][2] = matrix_out_2[7];	matrix_IIT_comb[7][3] = matrix_out_3[7];	matrix_IIT_comb[7][4] = matrix_out_4[7];	matrix_IIT_comb[7][5] = matrix_out_5[7];	matrix_IIT_comb[7][6] = matrix_out_6[7];	matrix_IIT_comb[7][7] = matrix_out_7[7];
		// matrix_IIT_comb = matrix_out;
	end

end

always_ff @(posedge clk) begin
	matrix_I <= matrix_I_comb;
end


//---------------------------------------------------------------------
//   Matrix Multiplication Start                    
//---------------------------------------------------------------------

always_comb begin : mult_mtx_init_comb

	vec_rat_comb[0] = (vec_avg[0] > matrix_IIT[0][0]) ? 0 : matrix_IIT[0][0];
	vec_rat_comb[1] = (vec_avg[1] > matrix_IIT[1][0]) ? 0 : matrix_IIT[1][0];
	vec_rat_comb[2] = (vec_avg[2] > matrix_IIT[2][0]) ? 0 : matrix_IIT[2][0];
	vec_rat_comb[3] = (vec_avg[3] > matrix_IIT[3][0]) ? 0 : matrix_IIT[3][0];
	vec_rat_comb[4] = (vec_avg[4] > matrix_IIT[4][0]) ? 0 : matrix_IIT[4][0];
	vec_rat_comb[5] = (vec_avg[5] > matrix_IIT[5][0]) ? 0 : matrix_IIT[5][0];
	vec_rat_comb[6] = (vec_avg[6] > matrix_IIT[6][0]) ? 0 : matrix_IIT[6][0];
	vec_rat_comb[7] = (vec_avg[7] > matrix_IIT[7][0]) ? 0 : matrix_IIT[7][0];

	if(i_valid_reg_0) begin
		vec_in_A_comb[0] = matrix_I[0][15];
		vec_in_A_comb[1] = matrix_I[1][15];
		vec_in_A_comb[2] = matrix_I[2][15];
		vec_in_A_comb[3] = matrix_I[3][15];
		vec_in_A_comb[4] = matrix_I[4][15];
		vec_in_A_comb[5] = matrix_I[5][15];
		vec_in_A_comb[6] = matrix_I[6][15];
		vec_in_A_comb[7] = matrix_I[7][15];

		vec_in_B_comb[0] = matrix_I[7][15];
		vec_in_B_comb[1] = matrix_I[7][15];
		vec_in_B_comb[2] = matrix_I[7][15];
		vec_in_B_comb[3] = matrix_I[7][15];
		vec_in_B_comb[4] = matrix_I[7][15];
		vec_in_B_comb[5] = matrix_I[7][15];
		vec_in_B_comb[6] = matrix_I[7][15];
		vec_in_B_comb[7] = matrix_I[7][15];
	end

	else if(w_valid_reg_0) begin
		vec_in_A_comb[0] = vec_rat_comb[0];
		vec_in_A_comb[1] = vec_rat_comb[1];
		vec_in_A_comb[2] = vec_rat_comb[2];
		vec_in_A_comb[3] = vec_rat_comb[3];
		vec_in_A_comb[4] = vec_rat_comb[4];
		vec_in_A_comb[5] = vec_rat_comb[5];
		vec_in_A_comb[6] = vec_rat_comb[6];
		vec_in_A_comb[7] = vec_rat_comb[7];

		vec_in_B_comb[0] = w_data_reg_0;
		vec_in_B_comb[1] = w_data_reg_0;
		vec_in_B_comb[2] = w_data_reg_0;
		vec_in_B_comb[3] = w_data_reg_0;
		vec_in_B_comb[4] = w_data_reg_0;
		vec_in_B_comb[5] = w_data_reg_0;
		vec_in_B_comb[6] = w_data_reg_0;
		vec_in_B_comb[7] = w_data_reg_0;
	end

	else begin
		vec_in_A_comb[0] = 0;
		vec_in_A_comb[1] = 0;
		vec_in_A_comb[2] = 0;
		vec_in_A_comb[3] = 0;
		vec_in_A_comb[4] = 0;
		vec_in_A_comb[5] = 0;
		vec_in_A_comb[6] = 0;
		vec_in_A_comb[7] = 0;

		vec_in_B_comb[0] = 0;
		vec_in_B_comb[1] = 0;
		vec_in_B_comb[2] = 0;
		vec_in_B_comb[3] = 0;
		vec_in_B_comb[4] = 0;
		vec_in_B_comb[5] = 0;
		vec_in_B_comb[6] = 0;
		vec_in_B_comb[7] = 0;
	end

end


always_ff @(posedge clk) begin : vec_in_ff
	vec_in_A <= vec_in_A_comb;
	vec_in_B <= vec_in_B_comb;
end

assign vec_out_1_comb[0] = vec_in_A[0] * vec_in_B[0];
assign vec_out_1_comb[1] = vec_in_A[1] * vec_in_B[1];
assign vec_out_1_comb[2] = vec_in_A[2] * vec_in_B[2];
assign vec_out_1_comb[3] = vec_in_A[3] * vec_in_B[3];
assign vec_out_1_comb[4] = vec_in_A[4] * vec_in_B[4];
assign vec_out_1_comb[5] = vec_in_A[5] * vec_in_B[5];
assign vec_out_1_comb[6] = vec_in_A[6] * vec_in_B[6];
assign vec_out_1_comb[7] = vec_in_A[7] * vec_in_B[7];


always_comb begin : vec_add_comb

	cnt_comb = (i_valid_reg_3 | w_valid_reg_2) ? cnt + 1 : 0;
	cnt_flag_comb = (cnt_comb[3:0] == 0);

	vec_out_2_comb[0] = (cnt_flag_comb) ? vec_out_1[0] : vec_out_2[0] + vec_out_1[0];
	vec_out_2_comb[1] = (cnt_flag_comb) ? vec_out_1[1] : vec_out_2[1] + vec_out_1[1];
	vec_out_2_comb[2] = (cnt_flag_comb) ? vec_out_1[2] : vec_out_2[2] + vec_out_1[2];
	vec_out_2_comb[3] = (cnt_flag_comb) ? vec_out_1[3] : vec_out_2[3] + vec_out_1[3];
	vec_out_2_comb[4] = (cnt_flag_comb) ? vec_out_1[4] : vec_out_2[4] + vec_out_1[4];
	vec_out_2_comb[5] = (cnt_flag_comb) ? vec_out_1[5] : vec_out_2[5] + vec_out_1[5];
	vec_out_2_comb[6] = (cnt_flag_comb) ? vec_out_1[6] : vec_out_2[6] + vec_out_1[6];
	vec_out_2_comb[7] = (cnt_flag_comb) ? vec_out_1[7] : vec_out_2[7] + vec_out_1[7];

	pipe_vec_0_comb = vec_out_2[0];
	pipe_vec_1_comb = vec_out_2[1]; 
	pipe_vec_2_comb = vec_out_2[2]; 
	pipe_vec_3_comb = vec_out_2[3]; 
	pipe_vec_4_comb = vec_out_2[4]; 
	pipe_vec_5_comb = vec_out_2[5]; 
	pipe_vec_6_comb = vec_out_2[6]; 
	pipe_vec_7_comb = vec_out_2[7]; 

end

always_comb begin : matrix_insert_comb

	out_flag_comb = {~cnt_flag, cnt[7:4]} == 8;

	matrix_out_comb_0 = matrix_out_0; 
	matrix_out_comb_1 = matrix_out_1; 
	matrix_out_comb_2 = matrix_out_2; 
	matrix_out_comb_3 = matrix_out_3; 
	matrix_out_comb_4 = matrix_out_4; 
	matrix_out_comb_5 = matrix_out_5; 
	matrix_out_comb_6 = matrix_out_6; 
	matrix_out_comb_7 = matrix_out_7; 

	pipe_reg_comb_0[0] = matrix_out_0[0];		pipe_reg_comb_0[1] = pipe_reg_0[0];	pipe_reg_comb_0[2] = pipe_reg_0[1];	pipe_reg_comb_0[3] = pipe_reg_0[2]; 	pipe_reg_comb_0[4] = pipe_reg_0[3];	pipe_reg_comb_0[5] = pipe_reg_0[4]; pipe_reg_comb_0[6] = pipe_reg_0[5]; //	pipe_reg_comb_0[7] = pipe_reg_0[6];
	pipe_reg_comb_1[0] = matrix_out_0[1];		pipe_reg_comb_1[1] = pipe_reg_1[0];	pipe_reg_comb_1[2] = pipe_reg_1[1];	pipe_reg_comb_1[3] = pipe_reg_1[2]; 	pipe_reg_comb_1[4] = pipe_reg_1[3];	pipe_reg_comb_1[5] = pipe_reg_1[4];	pipe_reg_comb_1[6] = pipe_reg_1[5]; pipe_reg_comb_1[7] = pipe_reg_1[6]; //	pipe_reg_comb_1[8] = pipe_reg_1[7];
	pipe_reg_comb_2[0] = matrix_out_0[2];		pipe_reg_comb_2[1] = pipe_reg_2[0];	pipe_reg_comb_2[2] = pipe_reg_2[1];	pipe_reg_comb_2[3] = pipe_reg_2[2]; 	pipe_reg_comb_2[4] = pipe_reg_2[3];	pipe_reg_comb_2[5] = pipe_reg_2[4];	pipe_reg_comb_2[6] = pipe_reg_2[5];	pipe_reg_comb_2[7] = pipe_reg_2[6]; pipe_reg_comb_2[8] = pipe_reg_2[7]; //	pipe_reg_comb_2[9] = pipe_reg_2[8];
	pipe_reg_comb_4[0] = matrix_out_0[4];		

	pipe_reg_comb_6[0] = matrix_out_0[6];		

	matrix_out_comb_0[0] = matrix_out_1[1];	matrix_out_comb_1[1] = matrix_out_2[2];	matrix_out_comb_2[2] = matrix_out_3[3];	matrix_out_comb_3[3] = matrix_out_4[4];	matrix_out_comb_4[4] = matrix_out_5[5];	matrix_out_comb_5[5] = matrix_out_6[6];	matrix_out_comb_6[6] = matrix_out_7[7];	matrix_out_comb_7[7] = pipe_reg_0[6];
	matrix_out_comb_0[1] = matrix_out_1[2];	matrix_out_comb_1[2] = matrix_out_2[3];	matrix_out_comb_2[3] = matrix_out_3[4];	matrix_out_comb_3[4] = matrix_out_4[5];	matrix_out_comb_4[5] = matrix_out_5[6];	matrix_out_comb_5[6] = matrix_out_6[7];	matrix_out_comb_6[7] = pipe_reg_1[7];
	matrix_out_comb_0[2] = matrix_out_1[3];	matrix_out_comb_1[3] = matrix_out_2[4];	matrix_out_comb_2[4] = matrix_out_3[5];	matrix_out_comb_3[5] = matrix_out_4[6];	matrix_out_comb_4[6] = matrix_out_5[7]; matrix_out_comb_5[7] = pipe_reg_2[8];
	matrix_out_comb_0[3] = matrix_out_1[4];	matrix_out_comb_1[4] = matrix_out_2[5];	matrix_out_comb_2[5] = matrix_out_3[6];	matrix_out_comb_3[6] = matrix_out_4[7];	matrix_out_comb_4[7] = matrix_out_0[3];
	matrix_out_comb_0[4] = matrix_out_1[5];	matrix_out_comb_1[5] = matrix_out_2[6];	matrix_out_comb_2[6] = matrix_out_3[7];	matrix_out_comb_3[7] = pipe_reg_4[0];
	matrix_out_comb_0[5] = matrix_out_1[6];	matrix_out_comb_1[6] = matrix_out_2[7];	matrix_out_comb_2[7] = matrix_out_0[5];
	matrix_out_comb_0[6] = matrix_out_1[7]; matrix_out_comb_1[7] = pipe_reg_6[0];


	if(cnt_flag) begin
		matrix_out_comb_0[7] = pipe_vec_0;
		matrix_out_comb_1[7] = pipe_vec_1;
		matrix_out_comb_2[7] = pipe_vec_2;
		matrix_out_comb_3[7] = pipe_vec_3;
		matrix_out_comb_4[7] = pipe_vec_4;
		matrix_out_comb_5[7] = pipe_vec_5;
		matrix_out_comb_6[7] = pipe_vec_6;
		matrix_out_comb_7[7] = pipe_vec_7;

	end

end


always_ff @(posedge clk) begin : vec_out_ff
	vec_out_1 <= vec_out_1_comb;
	vec_out_2 <= vec_out_2_comb;
end

always_ff @(posedge clk) begin : cnt_ff
	cnt <= cnt_comb;
	cnt_flag <= cnt_flag_comb;
	out_flag <= out_flag_comb;
end

always_ff @(posedge clk) begin : pipe_ff
	pipe_vec_0 <= pipe_vec_0_comb;
	pipe_vec_1 <= pipe_vec_1_comb;
	pipe_vec_2 <= pipe_vec_2_comb;
	pipe_vec_3 <= pipe_vec_3_comb;
	pipe_vec_4 <= pipe_vec_4_comb;
	pipe_vec_5 <= pipe_vec_5_comb;
	pipe_vec_6 <= pipe_vec_6_comb;
	pipe_vec_7 <= pipe_vec_7_comb;

	pipe_reg_0 <= pipe_reg_comb_0;
	pipe_reg_1 <= pipe_reg_comb_1;
	pipe_reg_2 <= pipe_reg_comb_2;
	pipe_reg_4 <= pipe_reg_comb_4;
	pipe_reg_6 <= pipe_reg_comb_6;
end

always_ff @(posedge clk) begin : matrix_out_ff
	matrix_IIT <= matrix_IIT_comb;
	matrix_out_0 <= matrix_out_comb_0; 
	matrix_out_1 <= matrix_out_comb_1; 
	matrix_out_2 <= matrix_out_comb_2; 
	matrix_out_3 <= matrix_out_comb_3; 
	matrix_out_4 <= matrix_out_comb_4; 
	matrix_out_5 <= matrix_out_comb_5; 
	matrix_out_6 <= matrix_out_comb_6; 
	matrix_out_7 <= matrix_out_comb_7; 

end


//---------------------------------------------------------------------
//   Matrix RAT Start                  
//---------------------------------------------------------------------

always_comb begin

	vec_sum_comb_1[0] = matrix_IIT[0][0] + matrix_IIT[0][1] + matrix_IIT[0][2] + matrix_IIT[0][3];
	vec_sum_comb_1[1] = matrix_IIT[1][0] + matrix_IIT[1][1] + matrix_IIT[1][2] + matrix_IIT[1][3];
	vec_sum_comb_1[2] = matrix_IIT[2][0] + matrix_IIT[2][1] + matrix_IIT[2][2] + matrix_IIT[2][3];
	vec_sum_comb_1[3] = matrix_IIT[3][0] + matrix_IIT[3][1] + matrix_IIT[3][2] + matrix_IIT[3][3];
	vec_sum_comb_1[4] = matrix_IIT[4][0] + matrix_IIT[4][1] + matrix_IIT[4][2] + matrix_IIT[4][3];
	vec_sum_comb_1[5] = matrix_IIT[5][0] + matrix_IIT[5][1] + matrix_IIT[5][2] + matrix_IIT[5][3];
	vec_sum_comb_1[6] = matrix_IIT[6][0] + matrix_IIT[6][1] + matrix_IIT[6][2] + matrix_IIT[6][3];
	vec_sum_comb_1[7] = matrix_IIT[7][0] + matrix_IIT[7][1] + matrix_IIT[7][2] + matrix_IIT[7][3];

	vec_sum_comb_2[0] = vec_sum_1[0] + matrix_IIT[0][4] + matrix_IIT[0][5] + matrix_IIT[0][6] + matrix_IIT[0][7];
	vec_sum_comb_2[1] = vec_sum_1[1] + matrix_IIT[1][4] + matrix_IIT[1][5] + matrix_IIT[1][6] + matrix_IIT[1][7];
	vec_sum_comb_2[2] = vec_sum_1[2] + matrix_IIT[2][4] + matrix_IIT[2][5] + matrix_IIT[2][6] + matrix_IIT[2][7];
	vec_sum_comb_2[3] = vec_sum_1[3] + matrix_IIT[3][4] + matrix_IIT[3][5] + matrix_IIT[3][6] + matrix_IIT[3][7];
	vec_sum_comb_2[4] = vec_sum_1[4] + matrix_IIT[4][4] + matrix_IIT[4][5] + matrix_IIT[4][6] + matrix_IIT[4][7];
	vec_sum_comb_2[5] = vec_sum_1[5] + matrix_IIT[5][4] + matrix_IIT[5][5] + matrix_IIT[5][6] + matrix_IIT[5][7];
	vec_sum_comb_2[6] = vec_sum_1[6] + matrix_IIT[6][4] + matrix_IIT[6][5] + matrix_IIT[6][6] + matrix_IIT[6][7];
	vec_sum_comb_2[7] = vec_sum_1[7] + matrix_IIT[7][4] + matrix_IIT[7][5] + matrix_IIT[7][6] + matrix_IIT[7][7];

	vec_avg_temp[0] = vec_sum_2[0] >> 3;
	vec_avg_temp[1] = vec_sum_2[1] >> 3;
	vec_avg_temp[2] = vec_sum_2[2] >> 3;
	vec_avg_temp[3] = vec_sum_2[3] >> 3;
	vec_avg_temp[4] = vec_sum_2[4] >> 3;
	vec_avg_temp[5] = vec_sum_2[5] >> 3;
	vec_avg_temp[6] = vec_sum_2[6] >> 3;
	vec_avg_temp[7] = vec_sum_2[7] >> 3;

	vec_avg_comb[0] = (w_ready_reg_2) ? vec_avg_temp[0] : vec_avg[0];
	vec_avg_comb[1] = (w_ready_reg_2) ? vec_avg_temp[1] : vec_avg[1];
	vec_avg_comb[2] = (w_ready_reg_2) ? vec_avg_temp[2] : vec_avg[2];
	vec_avg_comb[3] = (w_ready_reg_2) ? vec_avg_temp[3] : vec_avg[3];
	vec_avg_comb[4] = (w_ready_reg_2) ? vec_avg_temp[4] : vec_avg[4];
	vec_avg_comb[5] = (w_ready_reg_2) ? vec_avg_temp[5] : vec_avg[5];
	vec_avg_comb[6] = (w_ready_reg_2) ? vec_avg_temp[6] : vec_avg[6];
	vec_avg_comb[7] = (w_ready_reg_2) ? vec_avg_temp[7] : vec_avg[7];

end

always_ff @(posedge clk) begin
	vec_sum_1 <= vec_sum_comb_1;
	vec_sum_2 <= vec_sum_comb_2;
	vec_avg <= vec_avg_comb;
end

always_ff @(posedge clk) begin
	w_ready_reg_0 <= out_flag;
	w_ready_reg_1 <= w_ready_reg_0;
	w_ready_reg_2 <= w_ready_reg_1;
end

always_ff @(posedge clk, negedge rst_n) begin
	if(~rst_n) w_ready <= 0;
	else       w_ready <= w_ready_reg_2;
end


//---------------------------------------------------------------------
//   Matrix Out              
//---------------------------------------------------------------------

always_comb begin

	o_valid_comb = 0;
	o_data_comb  = 0;

	vec_o_comb[0] = vec_out_2[0];
	vec_o_comb[1] = vec_out_2[1];
	vec_o_comb[2] = vec_out_2[2];
	vec_o_comb[3] = vec_out_2[3];
	vec_o_comb[4] = vec_out_2[4];
	vec_o_comb[5] = vec_out_2[5];
	vec_o_comb[6] = vec_out_2[6];
	vec_o_comb[7] = vec_out_2[7];


	if(state == S_OUT) begin
		vec_o_comb[0] = vec_o[1];
		vec_o_comb[1] = vec_o[2];
		vec_o_comb[2] = vec_o[3];
		vec_o_comb[3] = vec_o[4];
		vec_o_comb[4] = vec_o[5];
		vec_o_comb[5] = vec_o[6];
		vec_o_comb[6] = vec_o[7];
		vec_o_comb[7] = 1;
		o_valid_comb = ~(vec_o[0] == 1);
		o_data_comb  =  (vec_o[0] == 1) ? 0 : vec_o[0];
	end

end


always_ff @(posedge clk) begin
	vec_o[0] <= vec_o_comb[0];
	vec_o[1] <= vec_o_comb[1];
	vec_o[2] <= vec_o_comb[2];
	vec_o[3] <= vec_o_comb[3];
	vec_o[4] <= vec_o_comb[4];
	vec_o[5] <= vec_o_comb[5];
	vec_o[6] <= vec_o_comb[6];
	vec_o[7] <= vec_o_comb[7];
end 

always_ff @(posedge clk, negedge rst_n) begin

	if(~rst_n) begin
		o_valid <= 0;
		o_data  <= 0;
	end

	else begin
		o_valid <= o_valid_comb;
		o_data  <= o_data_comb;
	end

end

endmodule
