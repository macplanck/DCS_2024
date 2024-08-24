`include "Handshake_syn.v"

module CDC(
	// Input signals
	clk_1,
	clk_2,
	rst_n,
	in_valid,
	in_data,
	// Output signals
	out_valid,
	out_data
);

input clk_1; 
input clk_2;			
input rst_n;
input in_valid;
input[7:0]in_data;

output logic out_valid;
output logic [4:0] out_data; 			

parameter S_wait_input = 0, S_wait_sync_idle = 1, S_send_data = 2;
parameter S_out = 0, S_wait_sync_high = 1, S_wait_sync_low = 2;

// ---------------------------------------------------------------------
// logic declaration                 
// ---------------------------------------------------------------------	
logic [7:0] data, data_comb;
logic [1:0] state_1, state_2, next_1, next_2;
logic       dvalid;
logic [4:0] out_data_comb;
logic       sclk; 
logic       dclk; 
logic       rst_n;
logic       sready, sready_comb; 
logic [7:0] din;
logic       sidle;
logic       dbusy;
logic [7:0] dout, dout_comb, dout_reg;
logic       out_valid_comb;

// logic [4:0] out_data_comb;
// logic       sready_comb;
// ---------------------------------------------------------------------
// design              
// ---------------------------------------------------------------------

assign dbusy = 0;

always_comb begin : Domain_1_FSM_comb

	next_1 = state_1;

	case(state_1)
		S_wait_input: 		begin next_1 = (in_valid) ? S_wait_sync_idle : S_wait_input;  end
		S_wait_sync_idle:	begin next_1 = (sidle) ? S_send_data : S_wait_sync_idle;      end
		S_send_data: 		  begin next_1 = S_wait_input;                                  end
	endcase
	
end

always_ff @(posedge clk_1, negedge rst_n) begin : Domain_1_FSM_ff

	if(~rst_n) begin 
		state_1 <= S_wait_input;                
	end

	else begin 
		state_1 <= next_1; 
	end
	
end

always_comb begin : Domain_1_comb

	sready_comb = (state_1 == S_send_data);
	data_comb   = (state_1 == S_wait_input) ? in_data : data;

end

always_ff @(posedge clk_1, negedge rst_n) begin : Domain_1_ff

	if(~rst_n) begin
		sready  <= 0; 
		data    <= 0;
		sready  <= 0; 
		data    <= 0;
	end

	else begin
		sready  <= sready_comb; 
		data    <= data_comb;
		sready  <= sready_comb; 
		data    <= data_comb;
	end

end


Handshake_syn sync(
	.sclk(clk_1), 
	.dclk(clk_2), 
	.rst_n(rst_n),
	.sready(sready), 
	.din(data), 
	.sidle(sidle),
	.dbusy(dbusy),
	.dvalid(dvalid),
	.dout(dout)
);


always_comb begin : Domain_2_FSM_comb

	next_2 = state_2;

	case(state_2)
		S_wait_sync_high:  begin next_2 = (dvalid) ? S_out : S_wait_sync_high;                end
		S_wait_sync_low:   begin next_2 = (dvalid) ? S_wait_sync_low : S_wait_sync_high;      end
		S_out: 		       begin next_2 = S_wait_sync_low;                                    end 
	endcase
	
end

always_ff @(posedge clk_2, negedge rst_n) begin : Domain_2_FSM_ff

	if(~rst_n) begin 
		state_2 <= S_wait_sync_high;      
	end

	else begin 
		state_2 <= next_2; 
	end
	
end

always_comb begin : Domain_2_comb_1

	out_data_comb  = (state_2 == S_out) ? dout[7:4] + dout[3:0] : 0;
	out_valid_comb = (state_2 == S_out);
	
end

always_ff @(posedge clk_2, negedge rst_n) begin : Domain_2_ff_1

	if(~rst_n) begin 
		out_data <= 0;             
		out_valid <= 0; 
	end

	else begin 
		out_data <= out_data_comb; 
		out_valid <= out_valid_comb; 
	end
	
end


endmodule