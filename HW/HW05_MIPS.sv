// 1.7: 28829.909341

module MIPS(
    //INPUT
    clk,
    rst_n,
    in_valid,
    instruction,

    //OUTPUT
    out_valid,
    instruction_fail,
    out_0,
    out_1,
    out_2,
    out_3,
    out_4,
    out_5
);

// INPUT
input clk;
input rst_n;
input in_valid;
input [31:0] instruction;

// OUTPUT

output logic out_valid, instruction_fail;
output logic [15:0] out_0, out_1, out_2, out_3, out_4, out_5;

logic        opmode, opmode_reg_0, opmode_reg_1, opmode_reg_2, opmode_in_0;
logic        fail_comb, fail_reg_0, fail_reg_1, fail_reg_2, fail_reg_3, fail_in_0;
logic [15:0] rs_comb_0, rs_reg_0, rs_reg_1, rs_reg_2, rs_temp, rt_temp_0;
logic [15:0] rt_comb_0, rt_reg_0, rt_reg_1, rt_reg_2, rt_temp;
logic [15:0] rd_comb_0, rd_reg_0, rd_reg_1, rd_reg_2;

logic [14:0] instruct_reg_0, instruct_reg_1, instruct_reg_2;
logic [15:0] out_op_1_comb, out_op_2_comb, out_op_1_temp;
logic [15:0] add_1_comb, add_2_comb;
logic [15:0] add_1_reg_1, add_1_reg_2, add_2_reg_1, add_2_reg_2;

logic [15:0] out_0_back_comb, out_1_back_comb, out_2_back_comb, out_3_back_comb, out_4_back_comb, out_5_back_comb;
logic [15:0] out_0_temp, out_1_temp, out_2_temp, out_3_temp, out_4_temp, out_5_temp;
logic [15:0] out_0_comb, out_1_comb, out_2_comb, out_3_comb, out_4_comb, out_5_comb;
logic [15:0] out_comb, out_reg;
logic [ 2:0] addr_comb, addr_reg_0, addr_reg_1, addr_in_0;
logic [ 4:0] shmt_reg_0, shmt_in_0;
logic [ 4:0] func_comb, func_reg_0, func_in_0;
logic [ 2:0] rd_addr_0, rt_addr_0, rs_addr_in_0, rt_addr_in_0;

logic [15:0] shift_temp_1, shift_temp_2, shift_temp, and_temp;

logic [15:0] out_0_reg_0, out_1_reg_0, out_2_reg_0, out_3_reg_0, out_4_reg_0, out_5_reg_0;
logic [15:0] out_0_reg_1, out_1_reg_1, out_2_reg_1, out_3_reg_1, out_4_reg_1, out_5_reg_1;
logic [15:0] out_0_reg_2, out_1_reg_2, out_2_reg_2, out_3_reg_2, out_4_reg_2, out_5_reg_2;
logic [15:0] out_0_reg_3, out_1_reg_3, out_2_reg_3, out_3_reg_3, out_4_reg_3, out_5_reg_3;
logic [15:0] immd_in_0;
logic        valid_reg_0, valid_reg_1, valid_reg_2, valid_reg_3, valid_in_0;

//================================================================
// DESIGN 
//================================================================

// always_ff @(posedge clk, negedge rst_n) begin : input_ff_1

//     if(~rst_n) valid_reg_0 <= 0;
//     else       valid_reg_0 <= in_valid;
    
// end

always_comb begin : in_comb

    addr_comb = (instruction[29]) ? {instruction[19], instruction[17:16]} : {instruction[14], instruction[12:11]};
    func_comb = {~instruction[5] & instruction[10], instruction[5], instruction[2] ^ instruction[5] | instruction[29], instruction[1:0]};

    fail_comb = | {instruction[31:30], instruction[28:26]};

    opmode = instruction[29];


end

always_ff @(posedge clk) begin : in_ff_0

    // 1 + 2 + 1 + 2 + 5 + 1 + 3 = 15 (14:12, 11:9, 8:4, 3:0)
    addr_in_0 <= addr_comb;
    shmt_in_0 <= instruction[9:6];
    func_in_0 <= func_comb;
    fail_in_0 <= fail_comb;

    rs_addr_in_0 <= {instruction[24], instruction[22:21]};
    rt_addr_in_0 <= {instruction[19], instruction[17:16]};

    opmode_in_0 <= opmode;

    immd_in_0 <= instruction[15:0];
    
end

always_ff @(posedge clk, negedge rst_n) begin : in_ff_1

    if(~rst_n) valid_in_0 <= 0;
    else       valid_in_0 <= in_valid;
    
end

always_comb begin : input_comb

    rs_comb_0 = 1'bx;
    rt_temp_0 = 1'bx;

    // fail_comb = | {instruction[31:30], instruction[28:26]};

    case(rs_addr_in_0)
        3'b001: rs_comb_0 = out_0_comb;
        3'b010: rs_comb_0 = out_1_comb;
        3'b100: rs_comb_0 = out_2_comb;
        3'b011: rs_comb_0 = out_3_comb;
        3'b111: rs_comb_0 = out_4_comb;
        3'b000: rs_comb_0 = out_5_comb;
    endcase

    case(rt_addr_in_0)
        3'b001: rt_temp_0 = out_0_comb;
        3'b010: rt_temp_0 = out_1_comb;
        3'b100: rt_temp_0 = out_2_comb;
        3'b011: rt_temp_0 = out_3_comb;
        3'b111: rt_temp_0 = out_4_comb;
        3'b000: rt_temp_0 = out_5_comb;
    endcase

    rt_comb_0 = (opmode_in_0) ? immd_in_0 : rt_temp_0; 

end

always_ff @(posedge clk) begin : input_ff_0

    // 1 + 2 + 1 + 2 + 5 + 1 + 3 = 15 (14:12, 11:9, 8:4, 3:0)
    addr_reg_0 <= addr_in_0;
    shmt_reg_0 <= shmt_in_0;
    func_reg_0 <= func_in_0;
    fail_reg_0 <= fail_in_0;
    
    rt_reg_0 <= rt_comb_0;
    rs_reg_0 <= rs_comb_0;

    valid_reg_0 <= valid_in_0;
    
end

always_comb begin : state_1_comb
 
    rt_temp = (func_reg_0[0]) ? ~rt_reg_0 : rt_reg_0;
    rs_temp = (func_reg_0[0]) ? ~rs_reg_0 : rs_reg_0;

    out_op_1_temp = rt_temp & rs_temp;

    shift_temp_1 = 0;
    shift_temp_2 = 0;

    case(shmt_reg_0[3:0])
		4'd0 : shift_temp_1 = {rt_reg_0[15:0]       };
		4'd1 : shift_temp_1 = {rt_reg_0[14:0],  1'd0};
		4'd2 : shift_temp_1 = {rt_reg_0[13:0],  2'd0};
		4'd3 : shift_temp_1 = {rt_reg_0[12:0],  3'd0};
		4'd4 : shift_temp_1 = {rt_reg_0[11:0],  4'd0};
		4'd5 : shift_temp_1 = {rt_reg_0[10:0],  5'd0};
		4'd6 : shift_temp_1 = {rt_reg_0[ 9:0],  6'd0};
		4'd7 : shift_temp_1 = {rt_reg_0[ 8:0],  7'd0};
		4'd8 : shift_temp_1 = {rt_reg_0[ 7:0],  8'd0};
		4'd9 : shift_temp_1 = {rt_reg_0[ 6:0],  9'd0};
		4'd10: shift_temp_1 = {rt_reg_0[ 5:0], 10'd0};
		4'd11: shift_temp_1 = {rt_reg_0[ 4:0], 11'd0};
		4'd12: shift_temp_1 = {rt_reg_0[ 3:0], 12'd0};
		4'd13: shift_temp_1 = {rt_reg_0[ 2:0], 13'd0};
		4'd14: shift_temp_1 = {rt_reg_0[ 1:0], 14'd0};
		4'd15: shift_temp_1 = {rt_reg_0[   0], 15'd0};
    endcase

    case(shmt_reg_0[3:0])
		4'd0 : shift_temp_2 = {       rt_reg_0[15: 0]};
		4'd1 : shift_temp_2 = { 1'd0, rt_reg_0[15: 1]};
		4'd2 : shift_temp_2 = { 2'd0, rt_reg_0[15: 2]};
		4'd3 : shift_temp_2 = { 3'd0, rt_reg_0[15: 3]};
		4'd4 : shift_temp_2 = { 4'd0, rt_reg_0[15: 4]};
		4'd5 : shift_temp_2 = { 5'd0, rt_reg_0[15: 5]};
		4'd6 : shift_temp_2 = { 6'd0, rt_reg_0[15: 6]};
		4'd7 : shift_temp_2 = { 7'd0, rt_reg_0[15: 7]};
		4'd8 : shift_temp_2 = { 8'd0, rt_reg_0[15: 8]};
		4'd9 : shift_temp_2 = { 9'd0, rt_reg_0[15: 9]};
		4'd10: shift_temp_2 = {10'd0, rt_reg_0[15:10]};
		4'd11: shift_temp_2 = {11'd0, rt_reg_0[15:11]};
		4'd12: shift_temp_2 = {12'd0, rt_reg_0[15:12]};
		4'd13: shift_temp_2 = {13'd0, rt_reg_0[15:13]};
		4'd14: shift_temp_2 = {14'd0, rt_reg_0[15:14]};
		4'd15: shift_temp_2 = {15'd0, rt_reg_0[15   ]};
    endcase

    case(func_reg_0[1])
        1'b0: shift_temp = shift_temp_1;
        1'b1: shift_temp = shift_temp_2;
    endcase

    case(func_reg_0[1] ^ func_reg_0[0])
        1'b0: and_temp =  out_op_1_temp;
        1'b1: and_temp = ~out_op_1_temp;
    endcase

    casez(func_reg_0[4:2])
        3'b??1 : out_op_1_comb = rs_reg_0 + rt_reg_0;
        3'b1?0 : out_op_1_comb = 0;
        3'b000 : out_op_1_comb = shift_temp;
        default: out_op_1_comb = and_temp;
    endcase

    out_comb  = out_op_1_comb;
    
end


always_ff @(posedge clk) begin : stage_2_ff_0 
    fail_reg_1  <= fail_reg_0;
    out_reg     <= out_comb;
    addr_reg_1  <= addr_reg_0;
    valid_reg_1 <= valid_reg_0;
end


always_comb begin : stage_3_comb

    out_0_comb = out_0;
    out_1_comb = out_1;
    out_2_comb = out_2;
    out_3_comb = out_3;
    out_4_comb = out_4;
    out_5_comb = out_5;

    if(!valid_reg_1) begin
        out_0_comb = 0;
        out_1_comb = 0;
        out_2_comb = 0;
        out_3_comb = 0;
        out_4_comb = 0;
        out_5_comb = 0;
    end

    else if(!fail_reg_1) begin
        case(addr_reg_1)
            3'b001: out_0_comb = out_reg;
            3'b010: out_1_comb = out_reg;
            3'b100: out_2_comb = out_reg;
            3'b011: out_3_comb = out_reg;
            3'b111: out_4_comb = out_reg;
            3'b000: out_5_comb = out_reg;
        endcase
    end

end


always_ff @(posedge clk, negedge rst_n) begin : out_ff

    if(~rst_n) begin
        instruction_fail <= 0;
        out_valid <= 0;
        out_0 <= 0;
        out_1 <= 0;
        out_2 <= 0;
        out_3 <= 0;
        out_4 <= 0;
        out_5 <= 0;
    end

    else begin
        instruction_fail <= fail_reg_1;
        out_valid <= valid_reg_1;
        out_0 <= out_0_comb;
        out_1 <= out_1_comb;
        out_2 <= out_2_comb;
        out_3 <= out_3_comb;
        out_4 <= out_4_comb;
        out_5 <= out_5_comb;
    end

end


endmodule