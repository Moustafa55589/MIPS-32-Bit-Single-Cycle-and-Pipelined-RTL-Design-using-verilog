module Add_ALU(
  input wire [31:0] PCout,
	input wire [31:0] ShiftOut,
	output reg [31:0] Add_ALUOut);

always @(*) 
  begin
		Add_ALUOut = PCout + ShiftOut;
	end

endmodule