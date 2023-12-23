module Mux4 (	
  input wire [31:0] PCout, Add_ALUOut,
	input wire Br_Taken,
	output reg [31:0] PCin);

always @(*) 
	 begin
		case (Br_Taken)
			0: PCin = PCout ;
			1: PCin = Add_ALUOut;
		endcase
	end
	
endmodule