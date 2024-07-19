module inter(
  // Input signals
  clk,
  rst_n,
  in_valid_1,
  in_valid_2,
  data_in_1,
  data_in_2,
  ready_slave1,
  ready_slave2,
  // Output signals
  valid_slave1,
  valid_slave2,
  addr_out,
  value_out,
  handshake_slave1,
  handshake_slave2
);


parameter S_IDLE = 2'd0, S_master = 2'd1, S_handshake = 2'd2;

//---------------------------------------------------------------------
//   PORT DECLARATION
//---------------------------------------------------------------------
input clk, rst_n, in_valid_1, in_valid_2;
input [6:0] data_in_1, data_in_2; 
input ready_slave1, ready_slave2;

output logic valid_slave1, valid_slave2;
output logic [2:0] addr_out, value_out;
output logic handshake_slave1, handshake_slave2;


//---------------------------------------------------------------------
//   LOGIC DECLARATION
//---------------------------------------------------------------------

logic [1:0] state, next;
logic       flag, flag_comb;

logic       handshake_slave1_comb, handshake_slave2_comb;
logic       valid_slave1_comb, valid_slave2_comb;
logic [2:0] value_comb, value;
logic [2:0] addr_comb,  addr;

logic [6:0] data_reg, data_reg_comb;

logic temp1, temp2;
logic temp1_comb, temp2_comb;

//---------------------------------------------------------------------
//   Design DECLARATION
//---------------------------------------------------------------------

always_comb begin

    next = state;

    flag_comb = flag;

    data_reg_comb = data_reg;

    addr_comb  = addr_out;
    value_comb = value_out;

    valid_slave1_comb = valid_slave1;
    valid_slave2_comb = valid_slave2;

    handshake_slave1_comb = handshake_slave1;
    handshake_slave2_comb = handshake_slave2;

    case(state) 

        S_IDLE: begin 

            handshake_slave1_comb = 0;
            handshake_slave2_comb = 0;

            if(flag == 1) begin

                if(~data_reg[6])  begin valid_slave1_comb = 1; valid_slave2_comb = 0; end
                else              begin valid_slave2_comb = 1; valid_slave1_comb = 0; end

                {addr_comb, value_comb}  = data_reg[5:0];
                data_reg_comb = 0;
                next = S_master;

                flag_comb = 0;

            end

            else if(in_valid_1 && in_valid_2) begin

                if(~data_in_2[6])  begin valid_slave1_comb = 1; valid_slave2_comb = 0; end
                else               begin valid_slave2_comb = 1; valid_slave1_comb = 0; end

                {addr_comb, value_comb}  = data_in_2[5:0];
                data_reg_comb = data_in_1;
                next = S_master;

                flag_comb = 1;

            end
            

            else if(in_valid_2) begin

                if(~data_in_2[6])  begin valid_slave1_comb = 1; valid_slave2_comb = 0; end
                else               begin valid_slave2_comb = 1; valid_slave1_comb = 0; end

                {addr_comb, value_comb}  = data_in_2[5:0];
                next = S_master;

                flag_comb = 0;

            end

            else if(in_valid_1) begin

                if(~data_in_1[6])  begin valid_slave1_comb = 1; valid_slave2_comb = 0; end
                else               begin valid_slave2_comb = 1; valid_slave1_comb = 0; end

                {addr_comb, value_comb}  = data_in_1[5:0];
                next = S_master;

                flag_comb = 0;

            end

        end

        S_master: begin

            if     (ready_slave1 && valid_slave1) begin handshake_slave1_comb = 1; next = S_handshake; end 
            else if(ready_slave2 && valid_slave2) begin handshake_slave2_comb = 1; next = S_handshake; end 
            
        end


        S_handshake: begin

            next = S_IDLE;

            temp1_comb = 0;
            temp2_comb = 0;

            handshake_slave1_comb = 0;
            handshake_slave2_comb = 0;

            valid_slave1_comb = 0;
            valid_slave2_comb = 0;

            addr_comb  = 0;
            value_comb = 0;

        end

    endcase 
    
end


always_ff @(posedge clk, negedge rst_n) begin

    if(!rst_n) begin

        handshake_slave1 <= 0;
        handshake_slave2 <= 0;

        valid_slave1 <= 0;
        valid_slave2 <= 0;

        data_reg  <= 0;
        addr_out  <= 0;
        value_out <= 0;

        flag <= 0;
        
        state <= S_IDLE;
        
    end

    else begin

        handshake_slave1 <= handshake_slave1_comb;
        handshake_slave2 <= handshake_slave2_comb;

        valid_slave1 <= valid_slave1_comb;
        valid_slave2 <= valid_slave2_comb;

        data_reg  <= data_reg_comb;
        
        addr_out  <= addr_comb;
        value_out <= value_comb;

        temp1 <= temp1_comb;
        temp2 <= temp2_comb;

        state <= next; 

        flag <= flag_comb;

    end

end


endmodule
