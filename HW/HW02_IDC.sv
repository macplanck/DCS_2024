// 4121.409681

module IDC(
    // Input signals
	clk,
	rst_n,
	in_valid,
    in_id,
    // Output signals
    out_valid,
    out_legal_id
);

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION                         
//---------------------------------------------------------------------
input        clk, rst_n, in_valid;
input [5:0]  in_id;

output logic out_valid;
output logic out_legal_id;

//---------------------------------------------------------------------
//   LOGIC DECLARATION
//---------------------------------------------------------------------

parameter s0 = 3'd0, s1 = 3'd1, s2 = 3'd2, s3 = 3'd3, s4 = 3'd4;

logic [ 2:0] state;
logic [ 2:0] cnt,   cnt_comb;
logic [ 3:0] sum,   sum_comb, sum_temp, sum_comb_1, sum_comb_2; // temp2;
logic [ 7:0] temp, temp2, temp3;
logic        val,   val_comb;
logic        out,   out_comb;
logic        beg,   beg_comb;
logic        out_valid_comb;


//---------------------------------------------------------------------
//   Your design                        
//---------------------------------------------------------------------

always_ff @(posedge clk, negedge rst_n) begin: Init_ff
    if(!rst_n) beg <= 0;
    else       beg <= beg_comb;
end


always_comb begin: Init_comb

    if (in_valid) beg_comb = 1;
    else if(!cnt) beg_comb = 0;
    else          beg_comb = beg;

end


always_ff @(posedge clk, negedge rst_n) begin: IDLE_ff

    if(!rst_n) begin
        cnt <= 0;
        sum <= 0;
    end

    else begin
        cnt <= cnt_comb;
        sum <= sum_comb;
    end
    
end

always_comb begin: Input1_comb

    // INPUT CASE 1
    sum_comb_1[0] = | { 
        & { ~in_id[5], ~in_id[4],  in_id[3],  in_id[2], ~in_id[1], ~in_id[0] }, 
        & { ~in_id[5],  in_id[4], ~in_id[3],  in_id[2],  in_id[1],  in_id[0] }, 
        & { ~in_id[5],  in_id[4],  in_id[3],  in_id[2],  in_id[1], ~in_id[0] }, 
        & { ~in_id[5], ~in_id[4],  in_id[3],  in_id[1], ~in_id[0] }, 
        & { ~in_id[5],  in_id[4], ~in_id[3], ~in_id[2], ~in_id[0] }, 
        & { ~in_id[5],  in_id[4],  in_id[2], ~in_id[1],  in_id[0] }, 
        & { ~in_id[5],  in_id[4],  in_id[3], ~in_id[2],  in_id[0] }, 
        & {  in_id[5], ~in_id[4], ~in_id[3], ~in_id[2], ~in_id[0] } 
    }; 

    sum_comb_1[1] = | { 
        & { ~in_id[5],  in_id[4], ~in_id[3], ~in_id[2],  in_id[1],  in_id[0] }, 
        & { ~in_id[5],  in_id[4], ~in_id[3],  in_id[2], ~in_id[1], ~in_id[0] }, 
        & { ~in_id[5],  in_id[4], ~in_id[2],  in_id[1], ~in_id[0] }, 
        & { ~in_id[5],  in_id[4],  in_id[3], ~in_id[1],  in_id[0] }, 
        & { ~in_id[5],  in_id[3],  in_id[2],  in_id[1] }
    }; 

    sum_comb_1[2] = | { 
        & { ~in_id[5],  in_id[4], ~in_id[3], ~in_id[2], ~in_id[1], ~in_id[0] }, 
        & { ~in_id[5],  in_id[4],  in_id[3],  in_id[2], ~in_id[1], ~in_id[0] }, 
        & { ~in_id[5], ~in_id[4],  in_id[3],  in_id[2],  in_id[1] }, 
        & { ~in_id[5],  in_id[4], ~in_id[2], ~in_id[1],  in_id[0] }, 
        & { ~in_id[5],  in_id[4],  in_id[3], ~in_id[2],  in_id[1] } 
    }; 

    sum_comb_1[3] = | { 
        & { ~in_id[5],  in_id[4], ~in_id[3],  in_id[2],  in_id[1],  in_id[0] }, 
        & { ~in_id[5],  in_id[4],  in_id[3], ~in_id[2], ~in_id[1], ~in_id[0] }, 
        & { ~in_id[5], ~in_id[4],  in_id[3],  in_id[2], ~in_id[1] }, 
        & {  in_id[5], ~in_id[4], ~in_id[3], ~in_id[2],  in_id[1] } 
    }; 

end

always_comb begin: Input2_comb

    temp = {in_id, cnt};

    // INPUT CASE 2
    sum_temp[0] = | { 
        & { ~temp[6], ~temp[5],  temp[4], ~temp[3], ~temp[2],  temp[0] }, 
        & { ~temp[7],  temp[6], ~temp[5],  temp[4], ~temp[3], ~temp[1],  temp[0] }, 
        & { ~temp[7], ~temp[6],  temp[5],  temp[4], ~temp[3],  temp[1],  temp[0] }, 
        & { ~temp[7],  temp[6], ~temp[5],  temp[4], ~temp[3], ~temp[2],  temp[1],  temp[0] }, 
        & { ~temp[7], ~temp[5],  temp[4], ~temp[3],  temp[2],  temp[1],  temp[0] }, 
        & { ~temp[7],  temp[6],  temp[5],  temp[4], ~temp[3],  temp[0] }, 
        & { ~temp[7], ~temp[6],  temp[4], ~temp[3],  temp[2], ~temp[1],  temp[0] }, 
        & { ~temp[7], ~temp[6],  temp[5],  temp[4], ~temp[3], ~temp[2], ~temp[1],  temp[0] }, 
        & {  temp[7], ~temp[6], ~temp[5],  temp[4], ~temp[3],  temp[2],  temp[0] } 
    }; 

    sum_temp[1] = | { 
        & { ~temp[7], ~temp[6],  temp[5], ~temp[4], ~temp[3], ~temp[2], ~temp[1], ~temp[0] }, 
        & { ~temp[7],  temp[5], ~temp[4], ~temp[3], ~temp[2],  temp[1], ~temp[0] }, 
        & { ~temp[7], ~temp[6],  temp[4], ~temp[3],  temp[2],  temp[1], ~temp[0] }, 
        & { ~temp[7], ~temp[6], ~temp[5],  temp[4], ~temp[3], ~temp[1],  temp[0] }, 
        & { ~temp[7], ~temp[6],  temp[5], ~temp[4], ~temp[3],  temp[2], ~temp[1],  temp[0] }, 
        & { ~temp[7], ~temp[6],  temp[5], ~temp[3],  temp[2],  temp[1],  temp[0] }, 
        & { ~temp[7], ~temp[6], ~temp[5],  temp[4], ~temp[3], ~temp[2],  temp[1], ~temp[0] }, 
        & { ~temp[7], ~temp[6],  temp[5],  temp[4], ~temp[3],  temp[2], ~temp[1], ~temp[0] }, 
        & { ~temp[7],  temp[6], ~temp[5], ~temp[4], ~temp[3], ~temp[1], ~temp[0] }, 
        & { ~temp[7],  temp[6], ~temp[5], ~temp[4], ~temp[3],  temp[2], ~temp[1],  temp[0] }, 
        & { ~temp[7],  temp[6],  temp[5], ~temp[4], ~temp[3], ~temp[2], ~temp[1],  temp[0] }, 
        & { ~temp[7],  temp[6],  temp[5], ~temp[4], ~temp[3],  temp[2],  temp[1] }, 
        & { ~temp[7],  temp[6],  temp[5],  temp[4], ~temp[3], ~temp[2], ~temp[0] }, 
        & {  temp[7], ~temp[6], ~temp[5], ~temp[4], ~temp[3],  temp[2], ~temp[0] }, 
        & { ~temp[7],  temp[6],  temp[5],  temp[4], ~temp[3],  temp[2],  temp[1],  temp[0] }, 
        & {  temp[7], ~temp[6], ~temp[5], ~temp[3], ~temp[2], ~temp[1],  temp[0] }, 
        & {  temp[7], ~temp[6], ~temp[5],  temp[4], ~temp[3], ~temp[1], ~temp[0] }, 
        & {  temp[7], ~temp[6], ~temp[5],  temp[4], ~temp[3],  temp[2], ~temp[1],  temp[0] } 
    }; 

    sum_temp[2] = | { 
        & { ~temp[7],  temp[6],  temp[4], ~temp[3], ~temp[2],  temp[1],  temp[0] }, 
        & { ~temp[7],  temp[6], ~temp[4], ~temp[3],  temp[2], ~temp[1], ~temp[0] }, 
        & { ~temp[7],  temp[6], ~temp[3],  temp[2],  temp[1],  temp[0] }, 
        & { ~temp[7], ~temp[6],  temp[5], ~temp[3],  temp[2],  temp[1], ~temp[0] }, 
        & { ~temp[6], ~temp[5],  temp[4], ~temp[3],  temp[2], ~temp[1], ~temp[0] }, 
        & { ~temp[7],  temp[6], ~temp[4], ~temp[3], ~temp[2],  temp[1], ~temp[0] }, 
        & { ~temp[7], ~temp[6],  temp[5], ~temp[4], ~temp[3], ~temp[2], ~temp[1] }, 
        & { ~temp[7],  temp[6], ~temp[5],  temp[4], ~temp[3], ~temp[1],  temp[0] }, 
        & { ~temp[7], ~temp[6], ~temp[5],  temp[4], ~temp[3], ~temp[2],  temp[0] }, 
        & { ~temp[7], ~temp[6],  temp[5],  temp[4], ~temp[3], ~temp[2],  temp[1],  temp[0] }, 
        & { ~temp[7],  temp[5],  temp[4], ~temp[3], ~temp[2], ~temp[1], ~temp[0] }, 
        & { ~temp[7],  temp[6],  temp[5],  temp[4], ~temp[3],  temp[2],  temp[1], ~temp[0] }, 
        & {  temp[7], ~temp[6], ~temp[5], ~temp[4], ~temp[3], ~temp[2], ~temp[1] }, 
        & { ~temp[6], ~temp[5],  temp[4], ~temp[3], ~temp[2],  temp[1], ~temp[0] }, 
        & { ~temp[7], ~temp[6],  temp[5], ~temp[4], ~temp[3],  temp[2], ~temp[1],  temp[0] }, 
        & {  temp[7], ~temp[6], ~temp[5], ~temp[3],  temp[2], ~temp[1],  temp[0] }, 
        & {  temp[7], ~temp[6], ~temp[5], ~temp[4], ~temp[3],  temp[2],  temp[1], ~temp[0] }, 
        & {  temp[7], ~temp[6], ~temp[5],  temp[4], ~temp[3], ~temp[2],  temp[1],  temp[0] } 
    }; 

    sum_temp[3] = | { 
        & { ~temp[7], ~temp[6], ~temp[5],  temp[4], ~temp[3], ~temp[2], ~temp[1], ~temp[0] }, 
        & { ~temp[7], ~temp[6],  temp[5], ~temp[4], ~temp[3],  temp[2], ~temp[1], ~temp[0] }, 
        & { ~temp[7], ~temp[6],  temp[5],  temp[4], ~temp[3], ~temp[2],  temp[1], ~temp[0] }, 
        & { ~temp[7], ~temp[6],  temp[5],  temp[4], ~temp[3],  temp[2], ~temp[1],  temp[0] }, 
        & { ~temp[7],  temp[6], ~temp[5], ~temp[4], ~temp[3], ~temp[2], ~temp[1],  temp[0] }, 
        & { ~temp[7],  temp[6], ~temp[5], ~temp[4], ~temp[3],  temp[2],  temp[1], ~temp[0] }, 
        & { ~temp[7],  temp[6],  temp[5], ~temp[4], ~temp[3], ~temp[2], ~temp[1], ~temp[0] }, 
        & { ~temp[7],  temp[6],  temp[5], ~temp[4], ~temp[3],  temp[2], ~temp[1],  temp[0] }, 
        & { ~temp[7],  temp[6],  temp[5],  temp[4], ~temp[3], ~temp[2], ~temp[1],  temp[0] }, 
        & { ~temp[7],  temp[6],  temp[5],  temp[4], ~temp[3],  temp[2], ~temp[1], ~temp[0] }, 
        & {  temp[7], ~temp[6], ~temp[5], ~temp[4], ~temp[3], ~temp[2],  temp[1], ~temp[0] }, 
        & {  temp[7], ~temp[6], ~temp[5], ~temp[3],  temp[2],  temp[1],  temp[0] }, 
        & {  temp[7], ~temp[6], ~temp[5],  temp[4], ~temp[3],  temp[2],  temp[1], ~temp[0] } 
    }; 

	// Mod

    temp2 = {sum, sum_temp};

    sum_comb_2[0] = | { 
        & { ~temp2[7], ~temp2[6],  temp2[5], ~temp2[4], ~temp2[3], ~temp2[2], ~temp2[1],  temp2[0] }, 
        & { ~temp2[7],  temp2[6], ~temp2[5], ~temp2[4],  temp2[3], ~temp2[2], ~temp2[1],  temp2[0] }, 
        & { ~temp2[7],  temp2[6],  temp2[5], ~temp2[4], ~temp2[3],  temp2[2],  temp2[1],  temp2[0] }, 
        & {  temp2[7], ~temp2[6], ~temp2[5],  temp2[4],  temp2[3], ~temp2[2], ~temp2[1], ~temp2[0] }, 
        & { ~temp2[7], ~temp2[6], ~temp2[4], ~temp2[3],  temp2[2], ~temp2[1],  temp2[0] }, 
        & { ~temp2[7], ~temp2[5], ~temp2[4], ~temp2[3],  temp2[2],  temp2[1],  temp2[0] }, 
        & { ~temp2[6], ~temp2[5], ~temp2[4],  temp2[3], ~temp2[2], ~temp2[1],  temp2[0] }, 
        & { ~temp2[7], ~temp2[6],  temp2[5], ~temp2[4], ~temp2[3],  temp2[1],  temp2[0] }, 
        & { ~temp2[7],  temp2[5], ~temp2[4],  temp2[3], ~temp2[2], ~temp2[1],  temp2[0] }, 
        & { ~temp2[7],  temp2[6], ~temp2[4], ~temp2[3], ~temp2[2],  temp2[1],  temp2[0] }, 
        & { ~temp2[6], ~temp2[5], ~temp2[4], ~temp2[3], ~temp2[2],  temp2[0] }, 
        & { ~temp2[7], ~temp2[6],  temp2[4], ~temp2[3],  temp2[1], ~temp2[0] }, 
        & { ~temp2[7],  temp2[4], ~temp2[3],  temp2[2], ~temp2[1], ~temp2[0] }, 
        & { ~temp2[7],  temp2[6],  temp2[4], ~temp2[3], ~temp2[2], ~temp2[0] }, 
        & { ~temp2[7], ~temp2[6],  temp2[4], ~temp2[3], ~temp2[2], ~temp2[1], ~temp2[0] }, 
        & { ~temp2[7],  temp2[6],  temp2[4], ~temp2[3],  temp2[2],  temp2[1], ~temp2[0] }, 
        & {  temp2[7], ~temp2[6], ~temp2[5], ~temp2[4], ~temp2[3],  temp2[2],  temp2[0] }, 
        & { ~temp2[7],  temp2[4],  temp2[3], ~temp2[2], ~temp2[1], ~temp2[0] }, 
        & { ~temp2[7],  temp2[6], ~temp2[4], ~temp2[3], ~temp2[1],  temp2[0] }, 
        & {  temp2[7], ~temp2[6], ~temp2[5],  temp2[4], ~temp2[3], ~temp2[0] } 
    }; 

    sum_comb_2[1] = | { 
        & { ~temp2[7], ~temp2[6], ~temp2[5], ~temp2[4], ~temp2[3],  temp2[2],  temp2[1],  temp2[0] }, 
        & { ~temp2[7], ~temp2[6],  temp2[5],  temp2[4], ~temp2[3], ~temp2[2],  temp2[1],  temp2[0] }, 
        & { ~temp2[7],  temp2[6], ~temp2[5],  temp2[4], ~temp2[3], ~temp2[2], ~temp2[1],  temp2[0] }, 
        & { ~temp2[7],  temp2[6], ~temp2[5],  temp2[4], ~temp2[3],  temp2[2],  temp2[1],  temp2[0] }, 
        & { ~temp2[7],  temp2[6], ~temp2[5],  temp2[4],  temp2[3], ~temp2[2], ~temp2[1], ~temp2[0] }, 
        & { ~temp2[7],  temp2[6],  temp2[5],  temp2[4], ~temp2[3], ~temp2[2], ~temp2[1], ~temp2[0] }, 
        & { ~temp2[7],  temp2[6],  temp2[5],  temp2[4], ~temp2[3],  temp2[2], ~temp2[1],  temp2[0] }, 
        & { ~temp2[7],  temp2[6],  temp2[5],  temp2[4], ~temp2[3],  temp2[2],  temp2[1], ~temp2[0] }, 
        & {  temp2[7], ~temp2[6], ~temp2[5], ~temp2[4],  temp2[3], ~temp2[2], ~temp2[1],  temp2[0] }, 
        & {  temp2[7], ~temp2[6], ~temp2[5],  temp2[4], ~temp2[3],  temp2[2], ~temp2[1], ~temp2[0] }, 
        & { ~temp2[7], ~temp2[6], ~temp2[5], ~temp2[3],  temp2[2],  temp2[1], ~temp2[0] }, 
        & { ~temp2[7], ~temp2[6], ~temp2[5],  temp2[4], ~temp2[3], ~temp2[1],  temp2[0] }, 
        & { ~temp2[7], ~temp2[5],  temp2[4], ~temp2[3], ~temp2[2],  temp2[1], ~temp2[0] }, 
        & { ~temp2[7], ~temp2[6],  temp2[5], ~temp2[4], ~temp2[3],  temp2[2], ~temp2[1] }, 
        & { ~temp2[7], ~temp2[6],  temp2[5],  temp2[4], ~temp2[3], ~temp2[1], ~temp2[0] }, 
        & { ~temp2[7],  temp2[5],  temp2[4],  temp2[3], ~temp2[2], ~temp2[1],  temp2[0] }, 
        & { ~temp2[7],  temp2[6], ~temp2[5], ~temp2[4],  temp2[3], ~temp2[2], ~temp2[1] }, 
        & { ~temp2[7],  temp2[6],  temp2[5], ~temp2[4], ~temp2[3],  temp2[2],  temp2[1] }, 
        & {  temp2[7], ~temp2[6], ~temp2[5], ~temp2[4], ~temp2[3],  temp2[2], ~temp2[1] }, 
        & {  temp2[7], ~temp2[6], ~temp2[5],  temp2[3], ~temp2[2], ~temp2[1], ~temp2[0] }, 
        & {  temp2[7], ~temp2[6], ~temp2[5],  temp2[4], ~temp2[3],  temp2[1],  temp2[0] }, 
        & { ~temp2[7], ~temp2[5], ~temp2[4], ~temp2[3], ~temp2[2],  temp2[1] }, 
        & { ~temp2[7],  temp2[5], ~temp2[4], ~temp2[3], ~temp2[2], ~temp2[1] } 
    }; 

    sum_comb_2[2] = | { 
        & { ~temp2[7], ~temp2[6],  temp2[5], ~temp2[4], ~temp2[3], ~temp2[2],  temp2[1],  temp2[0] }, 
        & { ~temp2[7], ~temp2[6],  temp2[5],  temp2[4], ~temp2[3], ~temp2[2], ~temp2[1],  temp2[0] }, 
        & { ~temp2[7], ~temp2[6],  temp2[5],  temp2[4], ~temp2[3],  temp2[2], ~temp2[1], ~temp2[0] }, 
        & { ~temp2[7],  temp2[6], ~temp2[5], ~temp2[4], ~temp2[3], ~temp2[2],  temp2[1],  temp2[0] }, 
        & { ~temp2[7],  temp2[6],  temp2[5],  temp2[4], ~temp2[3],  temp2[2],  temp2[1],  temp2[0] }, 
        & {  temp2[7], ~temp2[6], ~temp2[5],  temp2[4],  temp2[3], ~temp2[2], ~temp2[1], ~temp2[0] }, 
        & { ~temp2[6], ~temp2[5], ~temp2[4], ~temp2[3],  temp2[2],  temp2[1],  temp2[0] }, 
        & { ~temp2[7], ~temp2[6],  temp2[5], ~temp2[3], ~temp2[2],  temp2[1], ~temp2[0] }, 
        & { ~temp2[7], ~temp2[6],  temp2[5], ~temp2[4], ~temp2[3],  temp2[2], ~temp2[1] }, 
        & { ~temp2[7],  temp2[6], ~temp2[5], ~temp2[3], ~temp2[2],  temp2[1], ~temp2[0] }, 
        & { ~temp2[7],  temp2[6],  temp2[4],  temp2[3], ~temp2[2], ~temp2[1],  temp2[0] }, 
        & { ~temp2[7],  temp2[6],  temp2[5], ~temp2[4], ~temp2[2], ~temp2[1],  temp2[0] }, 
        & {  temp2[7], ~temp2[6], ~temp2[5],  temp2[4], ~temp2[3],  temp2[2],  temp2[0] }, 
        & { ~temp2[7], ~temp2[6], ~temp2[5], ~temp2[3],  temp2[2], ~temp2[1] }, 
        & { ~temp2[6], ~temp2[5], ~temp2[3],  temp2[2],  temp2[1], ~temp2[0] }, 
        & { ~temp2[7],  temp2[6], ~temp2[5], ~temp2[3], ~temp2[2], ~temp2[1] }, 
        & { ~temp2[7], ~temp2[6],  temp2[4], ~temp2[3], ~temp2[2],  temp2[1],  temp2[0] }, 
        & {  temp2[7], ~temp2[6], ~temp2[5], ~temp2[4],  temp2[3], ~temp2[2], ~temp2[1] }, 
        & { ~temp2[7],  temp2[6],  temp2[5], ~temp2[2], ~temp2[1], ~temp2[0] } 
    }; 

    sum_comb_2[3] = | { 
        & { ~temp2[7], ~temp2[6], ~temp2[5],  temp2[4], ~temp2[3],  temp2[2],  temp2[1],  temp2[0] }, 
        & { ~temp2[7], ~temp2[6], ~temp2[5],  temp2[4],  temp2[3], ~temp2[2], ~temp2[1], ~temp2[0] }, 
        & { ~temp2[7], ~temp2[6],  temp2[5],  temp2[4], ~temp2[3],  temp2[2], ~temp2[1],  temp2[0] }, 
        & { ~temp2[7], ~temp2[6],  temp2[5],  temp2[4], ~temp2[3],  temp2[2],  temp2[1], ~temp2[0] }, 
        & { ~temp2[7],  temp2[6], ~temp2[5],  temp2[4], ~temp2[3], ~temp2[2],  temp2[1],  temp2[0] }, 
        & { ~temp2[7],  temp2[6], ~temp2[5],  temp2[4], ~temp2[3],  temp2[2], ~temp2[1], ~temp2[0] }, 
        & { ~temp2[7],  temp2[6],  temp2[5],  temp2[4], ~temp2[3], ~temp2[2], ~temp2[1],  temp2[0] }, 
        & { ~temp2[7],  temp2[6],  temp2[5],  temp2[4], ~temp2[3], ~temp2[2],  temp2[1], ~temp2[0] }, 
        & {  temp2[7], ~temp2[6], ~temp2[5],  temp2[4], ~temp2[3], ~temp2[2], ~temp2[1], ~temp2[0] }, 
        & {  temp2[7], ~temp2[6], ~temp2[5],  temp2[4],  temp2[3], ~temp2[2], ~temp2[1],  temp2[0] }, 
        & { ~temp2[7], ~temp2[6], ~temp2[5], ~temp2[4],  temp2[3], ~temp2[2], ~temp2[1] }, 
        & { ~temp2[7], ~temp2[6],  temp2[5], ~temp2[4], ~temp2[3],  temp2[2],  temp2[1] }, 
        & { ~temp2[7],  temp2[6], ~temp2[5], ~temp2[4], ~temp2[3],  temp2[2], ~temp2[1] }, 
        & { ~temp2[7],  temp2[6],  temp2[5], ~temp2[4], ~temp2[3], ~temp2[2],  temp2[1] }, 
        & {  temp2[7], ~temp2[6], ~temp2[5], ~temp2[4], ~temp2[3], ~temp2[2], ~temp2[1] } 
    }; 

end

always_comb begin: Input3_comb

    // INPUT CASE 3
    temp3 = {in_id, sum};

    out = | { 
        & { ~temp3[7], ~temp3[6], ~temp3[5], ~temp3[4], ~temp3[3], ~temp3[2], ~temp3[1], ~temp3[0] }, 
        & { ~temp3[7], ~temp3[6], ~temp3[5],  temp3[4],  temp3[3], ~temp3[2], ~temp3[1],  temp3[0] }, 
        & { ~temp3[7], ~temp3[6],  temp3[5], ~temp3[4],  temp3[3], ~temp3[2], ~temp3[1], ~temp3[0] }, 
        & { ~temp3[7], ~temp3[6],  temp3[5],  temp3[4], ~temp3[3],  temp3[2],  temp3[1],  temp3[0] }, 
        & { ~temp3[7],  temp3[6], ~temp3[5], ~temp3[4], ~temp3[3],  temp3[2],  temp3[1], ~temp3[0] }, 
        & { ~temp3[7],  temp3[6], ~temp3[5],  temp3[4], ~temp3[3],  temp3[2], ~temp3[1],  temp3[0] }, 
        & { ~temp3[7],  temp3[6],  temp3[5], ~temp3[4], ~temp3[3],  temp3[2], ~temp3[1], ~temp3[0] }, 
        & { ~temp3[7],  temp3[6],  temp3[5],  temp3[4], ~temp3[3], ~temp3[2],  temp3[1],  temp3[0] }, 
        & {  temp3[7], ~temp3[6], ~temp3[5], ~temp3[4], ~temp3[3], ~temp3[2],  temp3[1], ~temp3[0] }, 
        & {  temp3[7], ~temp3[6], ~temp3[5],  temp3[4], ~temp3[3], ~temp3[2], ~temp3[1],  temp3[0] } 
    }; 

end

always_comb begin: Input_comb

    out_valid_comb = 0;
    out_comb = out_legal_id; 
    sum_comb = sum;
	cnt_comb = cnt;

    if(beg) begin

        cnt_comb = cnt + 1;

        if(cnt) begin
            sum_comb = sum_comb_2;
        end

        else if(!in_valid) begin
            out_comb = out;
            out_valid_comb = 1;
        end
        
        // else begin
        //     sum_comb = 0;
        //     cnt_comb = 0;
        //     out_comb = 0;
        // end

    end

    else begin
        sum_comb = sum_comb_1;
        cnt_comb = 0;
    end

end


always_ff @(posedge clk, negedge rst_n) begin:Output_ff

    if(!rst_n) begin
        out_valid <= 0;
        out_legal_id <= 0;
    end

    else begin
        out_valid <= out_valid_comb; 
		out_legal_id <= out_comb;
    end
    
end

endmodule