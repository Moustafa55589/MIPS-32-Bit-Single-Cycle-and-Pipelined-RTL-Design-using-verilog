module Mux1(	
  input wire [20:16] inst20_16,
	input wire [15:11] inst15_11,
	input wire RegDst,
	output reg [4:0] WriteReg);

always @ (*) begin
		case(RegDst) 
			0 : WriteReg <= inst20_16;
			1 : WriteReg <= inst15_11;
		endcase
	end
endmodule