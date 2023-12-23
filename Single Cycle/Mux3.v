module Mux3 (	
             input wire [31:0] ReadData, ALUOut,
	           input wire MemtoReg,
	           output reg [31:0] WriteData_Reg);

always @(*)
 begin
	case (MemtoReg)
		0: WriteData_Reg = ALUOut ;
		1: WriteData_Reg = ReadData;
	endcase
 end

endmodule