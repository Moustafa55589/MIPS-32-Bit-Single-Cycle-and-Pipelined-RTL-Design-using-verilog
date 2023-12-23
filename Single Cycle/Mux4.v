module Mux4 (	
  input wire [31:0] PCout, Add_ALUOut,
	input wire AndGateOut,
	output reg [31:0] PCin);
	
initial
	begin
		PCin = 0;
	end
	
always @(*) 
	 begin
		case (AndGateOut)
			0: PCin = PCout ;
			1: PCin = Add_ALUOut;
		endcase
	end
	
endmodule