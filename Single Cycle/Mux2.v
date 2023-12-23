module Mux2 (
  input wire ALUSrc,
	input wire [31:0] ReadData2,Extend32,	
	output reg [31:0] ALU_B);

always @(*)
	 begin
		case (ALUSrc)
			0: ALU_B <= ReadData2 ;
			1: ALU_B <= Extend32;
		endcase
	end

endmodule