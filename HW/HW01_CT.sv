module CT(
    // Input signals
    opcode,
	in_n0,
	in_n1,
	in_n2,
	in_n3,
	in_n4,
	in_n5,
    // Output signals
    out_n
);


//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION
//---------------------------------------------------------------------
input        [3:0] in_n0, in_n1, in_n2, in_n3, in_n4, in_n5;
input        [4:0] opcode;
output logic [8:0] out_n;

//---------------------------------------------------------------------
//   LOGIC DECLARATION
//---------------------------------------------------------------------

logic [4:0]  val_0,  val_1,  val_2,  val_3,  val_4,  val_5;
logic [4:0] wire_0, wire_1, wire_2, wire_3, wire_4, wire_5;
logic [4:0] sort_0, sort_1, sort_2, sort_3, sort_4, sort_5; 

logic [8:0] add_temp, sum_temp, avg_temp; 
logic       mul_temp;

//---------------------------------------------------------------------
//   Your design
//---------------------------------------------------------------------

// Decode
register_file REG[5:0] ({in_n5, in_n4, in_n3, in_n2, in_n1, in_n0}, {val_5,  val_4,  val_3,  val_2,  val_1,  val_0});

// Sort
always @(*) begin

    {sort_0, sort_1, sort_2, sort_3, sort_4, sort_5} = {val_0,  val_1,  val_2,  val_3,  val_4,  val_5};

    // Bubble Sort layer 1
    {sort_0, sort_2} = (sort_0 < sort_2) ? {sort_2, sort_0} : {sort_0, sort_2};
    {sort_2, sort_4} = (sort_2 < sort_4) ? {sort_4, sort_2} : {sort_2, sort_4};
    {sort_0, sort_2} = (sort_0 < sort_2) ? {sort_2, sort_0} : {sort_0, sort_2};

    {sort_1, sort_3} = (sort_1 < sort_3) ? {sort_3, sort_1} : {sort_1, sort_3};
    {sort_3, sort_5} = (sort_3 < sort_5) ? {sort_5, sort_3} : {sort_3, sort_5};
    {sort_1, sort_3} = (sort_1 < sort_3) ? {sort_3, sort_1} : {sort_1, sort_3};

    {sort_0, sort_1} = (sort_0 < sort_1) ? {sort_1, sort_0} : {sort_0, sort_1};
    {sort_4, sort_5} = (sort_4 < sort_5) ? {sort_5, sort_4} : {sort_4, sort_5};
    
    // Bubble Sort layer 2
    {sort_1, sort_3} = (sort_1 < sort_3) ? {sort_3, sort_1} : {sort_1, sort_3};
    {sort_2, sort_4} = (sort_2 < sort_4) ? {sort_4, sort_2} : {sort_2, sort_4};

    {sort_1, sort_2} = (sort_1 < sort_2) ? {sort_2, sort_1} : {sort_1, sort_2};
    {sort_3, sort_4} = (sort_3 < sort_4) ? {sort_4, sort_3} : {sort_3, sort_4};

    // Bubble Sort layer 3
    {sort_2, sort_3} = (sort_2 < sort_3) ? {sort_3, sort_2} : {sort_2, sort_3};
    
end

always @(*) begin

    case(opcode[4:3])

        2'd0: {wire_5, wire_4, wire_3, wire_2, wire_1, wire_0} = {val_5,  val_4,  val_3,  val_2,  val_1,  val_0};
        2'd1: {wire_0, wire_1, wire_2, wire_3, wire_4, wire_5} = {val_5,  val_4,  val_3,  val_2,  val_1,  val_0};

        2'd2: {wire_5, wire_4, wire_3, wire_2, wire_1, wire_0} = {sort_5, sort_4, sort_3, sort_2, sort_1, sort_0};
        2'd3: {wire_0, wire_1, wire_2, wire_3, wire_4, wire_5} = {sort_5, sort_4, sort_3, sort_2, sort_1, sort_0};

    endcase

end

always @(*) begin

    add_temp = wire_0 + ((opcode[1]) ? wire_2  << 1 : wire_5);

    if(opcode[2:0] == 3'd0) begin

        sum_temp = add_temp + wire_1 + wire_2 + wire_3 + wire_4;
        avg_temp = sum_temp / 6;

        if     (avg_temp > sort_1) out_n = 1;
        else if(avg_temp > sort_2) out_n = 2;
        else if(avg_temp > sort_3) out_n = 3;
        else if(avg_temp > sort_4) out_n = 4;
        else if(avg_temp > sort_5) out_n = 5;
        else                       out_n = 6;

    end   
    
    else begin

        case(opcode[2:0])

            3'b010:  out_n =  wire_3 * wire_4 / 2;
            3'b100:  out_n =  wire_1 & wire_2;
            3'b101:  out_n = ~wire_0;
            3'b110:  out_n =  wire_3 ^ wire_4;
            3'b111:  out_n =  wire_1 << 1;

            default: out_n =  add_temp;

        endcase

    end

end

endmodule


//---------------------------------------------------------------------
//   Register design from TA (Do not modify, or demo fails)
//---------------------------------------------------------------------
module register_file(
    address,
    value
);
input [3:0] address;
output logic [4:0] value;

always_comb begin
    case(address)
    4'b0000:value = 5'd9;
    4'b0001:value = 5'd27;
    4'b0010:value = 5'd30;
    4'b0011:value = 5'd3;
    4'b0100:value = 5'd11;
    4'b0101:value = 5'd8;
    4'b0110:value = 5'd26;
    4'b0111:value = 5'd17;
    4'b1000:value = 5'd3;
    4'b1001:value = 5'd12;
    4'b1010:value = 5'd1;
    4'b1011:value = 5'd10;
    4'b1100:value = 5'd15;
    4'b1101:value = 5'd5;
    4'b1110:value = 5'd23;
    4'b1111:value = 5'd20;
    default: value = 0;
    endcase
end

endmodule
