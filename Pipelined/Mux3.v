module Mux3 (	
             input wire [31:0] ReadData_Wb,ALUOut_Wb,
	           input wire MemtoReg,
	           output reg [31:0] WriteData_Reg);

always @(*)
 begin
	case (MemtoReg)
		'b0: WriteData_Reg = ALUOut_Wb ;
		'b1: WriteData_Reg = ReadData_Wb;
	endcase
 end

endmodule