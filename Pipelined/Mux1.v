module Mux1(	
        input wire [20:16] Rt_Ex,
	input wire [15:11] Rd_Ex,
	input wire RegDst,
	output reg [4:0] WriteReg);

always @ (*) begin
		case(RegDst) 
			0 : WriteReg <= Rt_Ex;
			1 : WriteReg <= Rd_Ex;
		endcase
	end

endmodule