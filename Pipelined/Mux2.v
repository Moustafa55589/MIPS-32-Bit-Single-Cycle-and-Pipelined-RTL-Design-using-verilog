module Mux2 (
  input wire ALUSrc,
	input wire [31:0] Extend_Ex,DataTwo_Ex,	
	output reg [31:0] ALU_B);

always @(*)
	 begin
		case (ALUSrc)
			0: ALU_B <= DataTwo_Ex ;
			1: ALU_B <= Extend_Ex;
		endcase
	end

endmodule