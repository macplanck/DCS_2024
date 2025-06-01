module LP(
    // Input signals
	clk,
	rst_n,
	in_valid,
    in_a1,
	in_a2,
	in_b,
    // Output signals
    out_valid,
    out_max_value
);

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION                         
//---------------------------------------------------------------------
input clk, rst_n, in_valid;
input signed [5:0] in_a1,in_a2;
input signed [11:0] in_b;

output logic out_valid;
output logic signed [11:0] out_max_value;

//---------------------------------------------------------------------
//   LOGIC DECLARATION
//---------------------------------------------------------------------

logic signed [11:0] x_min_comb_0, x_min_comb_1, x_min_comb_2, x_min_comb_3;
logic signed [11:0] x_min_reg_0, x_min_reg_1, x_min_reg_2, x_min_reg_3;
logic signed [11:0] x_min_0, x_min_1, x_min_2, x_min_3;

logic signed [11:0] x_max_comb_0, x_max_comb_1, x_max_comb_2, x_max_comb_3;
logic signed [11:0] x_max_reg_0, x_max_reg_1, x_max_reg_2, x_max_reg_3;
logic signed [11:0] x_max_0, x_max_1, x_max_2, x_max_3;

logic signed [11:0] y_min_comb_0, y_min_comb_1, y_min_comb_2, y_min_comb_3;
logic signed [11:0] y_min_reg_0, y_min_reg_1, y_min_reg_2, y_min_reg_3;
logic signed [11:0] y_min_0, y_min_1, y_min_2, y_min_3;

logic signed [11:0] y_max_comb_0, y_max_comb_1, y_max_comb_2, y_max_comb_3;
logic signed [11:0] y_max_reg_0, y_max_reg_1, y_max_reg_2, y_max_reg_3;
logic signed [11:0] y_max_0, y_max_1, y_max_2, y_max_3;

logic signed [11:0] b_1_comb_0, b_1_comb_1, b_1_comb_2, b_1_comb_3;
logic signed [11:0] b_1_reg_0, b_1_reg_1, b_1_reg_2, b_1_reg_3;
logic signed [11:0] b_1_0, b_1_1, b_1_2, b_1_3;

logic signed [11:0] b_2_comb_0, b_2_comb_1, b_2_comb_2, b_2_comb_3;
logic signed [11:0] b_2_reg_0, b_2_reg_1, b_2_reg_2, b_2_reg_3;
logic signed [11:0] b_2_0, b_2_1, b_2_2, b_2_3;

logic signed [5:0] c_1_comb_0, c_1_comb_1, c_1_comb_2, c_1_comb_3;
logic signed [5:0] c_1_reg_0, c_1_reg_1, c_1_reg_2, c_1_reg_3;
logic signed [5:0] c_1_0, c_1_1, c_1_2, c_1_3;

logic signed [5:0] c_2_comb_0, c_2_comb_1, c_2_comb_2, c_2_comb_3;
logic signed [5:0] c_2_reg_0, c_2_reg_1, c_2_reg_2, c_2_reg_3;
logic signed [5:0] c_2_0, c_2_1, c_2_2, c_2_3;

logic signed [5:0] a1_1_comb_0, a1_1_comb_1, a1_1_comb_2, a1_1_comb_3;
logic signed [5:0] a1_1_reg_0, a1_1_reg_1, a1_1_reg_2, a1_1_reg_3;
logic signed [5:0] a1_1_0, a1_1_1, a1_1_2, a1_1_3;

logic signed [5:0] a1_2_comb_0, a1_2_comb_1, a1_2_comb_2, a1_2_comb_3;
logic signed [5:0] a1_2_reg_0, a1_2_reg_1, a1_2_reg_2, a1_2_reg_3;
logic signed [5:0] a1_2_0, a1_2_1, a1_2_2, a1_2_3;

logic signed [5:0] a2_1_comb_0, a2_1_comb_1, a2_1_comb_2, a2_1_comb_3;
logic signed [5:0] a2_1_reg_0, a2_1_reg_1, a2_1_reg_2, a2_1_reg_3;
logic signed [5:0] a2_1_0, a2_1_1, a2_1_2, a2_1_3;

logic signed [5:0] a2_2_comb_0, a2_2_comb_1, a2_2_comb_2, a2_2_comb_3;
logic signed [5:0] a2_2_reg_0, a2_2_reg_1, a2_2_reg_2, a2_2_reg_3;
logic signed [5:0] a2_2_0, a2_2_1, a2_2_2, a2_2_3;


logic signed [11:0] x_comb_0, x_comb_1, x_comb_2, x_comb_3;
logic signed [11:0] x_reg_0, x_reg_1, x_reg_2, x_reg_3;
logic signed [11:0] x_0, x_1, x_2, x_3;

logic signed [11:0] y_comb_0, y_comb_1, y_comb_2, y_comb_3;
logic signed [11:0] y_reg_0, y_reg_1, y_reg_2, y_reg_3;
logic signed [11:0] y_0, y_1, y_2, y_3;

logic signed [11:0] bond_comb_0, bond_comb_1, bond_comb_2, bond_comb_3;


logic [7:0] cnt, cnt_comb;
logic [8:0] test_cnt;
logic signed [11:0] x_cnt, x_cnt_comb;
logic signed [11:0] y_cnt, y_cnt_comb;

logic signed [11:0] out_max_comb, out_max, out_comb, out_temp;

logic valid_comb, valid_comb_0, valid_comb_1, valid_comb_2, valid_comb_3;
logic valid_reg_0, valid_reg_1, valid_reg_2, valid_reg_3, in_valid_reg;
logic valid, valid_0, valid_1, valid_2, valid_3;
logic flag, flag_0, flag_1, flag_2, flag_3;
logic flag_comb, flag_comb_0, flag_comb_1, flag_comb_2, flag_comb_3;

//---------------------------------------------------------------------
//   Your design                        
//---------------------------------------------------------------------


assign cnt_comb = (in_valid) ? cnt + 1 : 0;

always_ff @(posedge clk, negedge rst_n) begin : cnt_ff

	if(~rst_n) begin
		cnt <= 0;
	end 

	else begin   
		cnt <= cnt_comb;
	end 

end 


// always_ff @(posedge clk, negedge rst_n) begin : test_cnt_ff

// 	if(~rst_n) begin
// 		test_cnt <= 0;
// 	end 

// 	else begin      
// 		test_cnt = (in_valid && cnt == 0) ? 0 : test_cnt + 1;   
// 	end 

// end 


always_comb begin : input_c_comb
    
    if(cnt == 0 && in_valid) begin
        c_1_comb_0 = in_a1;
        c_2_comb_0 = in_a2;
    end

    else begin
        c_1_comb_0 = c_1_0;
        c_2_comb_0 = c_2_0;
    end

end
    
always_ff @(posedge clk, negedge rst_n) begin : input_c_ff

	if(~rst_n) begin
		c_1_0 <= 0;
		c_2_0 <= 0;
	end 

	else begin      
		c_1_0 <= c_1_comb_0;
		c_2_0 <= c_2_comb_0;
	end 

end 

always_comb begin : input_A_comb

    x_min_comb_0 = x_min_0; 
    x_max_comb_0 = x_max_0; 
    y_min_comb_0 = y_min_0; 
    y_max_comb_0 = y_max_0; 

    a1_1_comb_0 = a1_1_0;
    a1_2_comb_0 = a1_2_0;
    a2_1_comb_0 = a2_1_0;
    a2_2_comb_0 = a2_2_0;
    
    b_1_comb_0 = b_1_0;
    b_2_comb_0 = b_2_0;
    
    if(cnt > 0 && in_valid) begin
        
        if(in_a2 == 0) begin
            if(in_a1 == 1) x_max_comb_0 =  in_b;
            else           x_min_comb_0 = -in_b;
        end

        else if(in_a1 == 0) begin
            if(in_a2 == 1) y_max_comb_0 =  in_b;
            else           y_min_comb_0 = -in_b;
        end

        else begin
            {a1_2_comb_0, a1_1_comb_0} = {a1_1_0, in_a1};
            {a2_2_comb_0, a2_1_comb_0} = {a2_1_0, in_a2};
            { b_2_comb_0,  b_1_comb_0} = { b_1_0, in_b};
        end

    end

end


always_ff @(posedge clk, negedge rst_n) begin

	if(~rst_n) begin
		x_min_0 <= ~0;
		x_max_0 <= {1'b0, ~11'b0};
		y_min_0 <= ~0;
		y_max_0 <= {1'b0, ~11'b0};
		a1_1_0 <= 0;
		a1_2_0 <= 0;
		a2_1_0 <= 0;
		a2_2_0 <= 0;
		b_1_0 <= 0;
		b_2_0 <= 0;
	end 

	else begin      
		x_min_0 <= x_min_comb_0;
		x_max_0 <= x_max_comb_0;
		y_min_0 <= y_min_comb_0;
		y_max_0 <= y_max_comb_0;
		a1_1_0  <= a1_1_comb_0;
		a1_2_0  <= a1_2_comb_0;
		a2_1_0  <= a2_1_comb_0;
		a2_2_0  <= a2_2_comb_0;
		b_1_0   <= b_1_comb_0;
		b_2_0   <= b_2_comb_0;
	end 

end 

always_ff @(posedge clk, negedge rst_n) begin

    if(~rst_n) in_valid_reg <= 0;
    else       in_valid_reg <= in_valid;
end


always_comb begin : xy_cnt_comb


    flag_comb = 0;

    if(in_valid_reg || out_valid || in_valid) begin
        x_cnt_comb = x_min_0 - 1; 
        y_cnt_comb = y_min_0;
        // $display("");
        // $display("xcnt: %d", x_cnt_comb);
        // $display("ycnt: %d", y_cnt_comb);
    end 

    else begin
        flag_comb = 1;
        x_cnt_comb = (x_cnt == x_max_0) ? x_min_0 : x_cnt + 1; 
        y_cnt_comb = (x_cnt != x_max_0) ? y_cnt   : y_cnt + 1;
    end

    valid_comb = (x_cnt_comb == x_max_0 && y_cnt_comb == y_max_0);

end


always_ff @(posedge clk, negedge rst_n) begin : xy_cnt_ff

	if(~rst_n) begin
        flag  <= 0;
        valid <= 0;
		x_cnt <= ~0;
        y_cnt <= ~0;
	end 

	else begin
        valid <= valid_comb;
		x_cnt <= x_cnt_comb;
        y_cnt <= y_cnt_comb;
        flag  <= flag_comb;
	end 

end 

always_ff @(posedge clk, negedge rst_n) begin : stage_0_ff

	if(~rst_n) begin
        valid_0 <= 0; 
		x_0 <= 0;
        y_0 <= 0;
        flag_0 <= 0;
	end 

	else begin 
        valid_0 <= valid;      
		x_0 <= x_cnt;
        y_0 <= y_cnt;
        flag_0 <= flag;
	end 

end 


always_comb begin : stage_1_comb

    bond_comb_1 = x_0 * a1_1_0 + y_0 * a2_1_0; 
    flag_comb_1 = (b_1_0 >= bond_comb_1) && flag_0;

end

always_ff @(posedge clk, negedge rst_n) begin : stage_1_ff

	if(~rst_n) begin
		y_1 <= 0;
		x_1 <= 0;
        flag_1 <= 0;
		valid_1 <= 0;
	end 

	else begin      
		y_1 <= y_0;
		x_1 <= x_0;
		valid_1 <= valid_0;
        flag_1 <= flag_comb_1;
	end 

end 

always_comb begin : stage_2_comb

    bond_comb_2 = x_1 * a1_2_0 + y_1 * a2_2_0; 
    flag_comb_2 = (b_2_0 >= bond_comb_2) && flag_1;

end

always_ff @(posedge clk, negedge rst_n) begin : stage_2_ff

	if(~rst_n) begin
		y_2 <= 0;
		x_2 <= 0;
        flag_2 <= 0;
		valid_2 <= 0;
	end 

	else begin      
		y_2 <= y_1;
		x_2 <= x_1;
		valid_2 <= valid_1;
        flag_2 <= flag_comb_2;
	end 

end 


always_comb begin : stage_3_comb

    out_comb = 0;

    out_max_comb = (in_valid) ? -{~11'd0} : out_max;
    out_temp = x_2 * c_1_0 + y_2 * c_2_0;

    if(out_max < out_temp && flag_2) out_max_comb = out_temp;

    if(valid_2) out_comb = out_max_comb;

end

always_ff @(posedge clk, negedge rst_n) begin : stage_3_ff

	if(~rst_n) begin
        out_max <= ~0;
        out_max_value <= 0;
        out_valid <= 0;
	end 

	else begin      
        out_valid <= valid_2;
        out_max_value <= out_comb;
        out_max <= out_max_comb;
	end 

end 


endmodule



