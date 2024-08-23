
`include "NDFF_syn.v"
module Handshake_syn #(parameter WIDTH=8) (
	// global signal
    sclk,
    dclk,
    rst_n,
	// from clk_1 module
    sready,
    din,
	// to clk_1 module
	sidle,
	// from clk_2 module
    dbusy,
    // to clk_2 module
    dvalid,
    dout
);

input sclk, dclk;
input rst_n;
input sready;
input [WIDTH-1:0] din;
input dbusy;
output sidle;
output reg dvalid;
output reg [WIDTH-1:0] dout;



reg sreq;
wire dreq;
reg dack;
wire sack;

reg [WIDTH-1:0] trans_data ;


assign sidle = (sreq || sack) ? 0 : 1 ;

always @ (posedge sclk or negedge rst_n) begin  
	if (!rst_n) trans_data <= 0 ;
	else begin 
		if (sready) trans_data <= din ;
		else trans_data <= trans_data ;
	end
end

always @ (posedge dclk or negedge rst_n) begin  
	if (!rst_n) begin 
		dout <= 0 ;
		dvalid <= 0 ;
	end
	else begin 
		if (dreq && ~dbusy) begin 
			dout <= trans_data ;
			dvalid <= 1 ;
		end
		else begin 
			dout <= dout ;
			dvalid <= 0 ;
		end
	end
end

always @ (posedge sclk or negedge rst_n) begin 
	if (!rst_n) sreq <= 0 ;
	else begin 
		if (sack) sreq <= 0 ;
		else if (sready) sreq <= 1 ;
		else sreq <= sreq ;
	end
end

NDFF_syn N0 (.D(sreq), .Q(dreq), .clk(dclk), .rst_n(rst_n)) ;


always @ (posedge dclk or negedge rst_n) begin 
	if (!rst_n) dack <= 0 ;
	else begin 
		if (dreq) dack <= 1 ;
		else dack <= 0 ;
	end
end

NDFF_syn N1 (.D(dack), .Q(sack), .clk(sclk), .rst_n(rst_n)) ;

endmodule








