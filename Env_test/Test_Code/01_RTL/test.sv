module test(in, clk, out, out_valid);

input [3:0] in;
input       clk;
output logic [3:0] out;
output logic       out_valid;

logic out_valid_comb;

always_comb begin
    out_valid_comb = 1;  
end

always_ff @(posedge clk) begin
    out_valid <= out_valid_comb;
    out <= in;
end


endmodule