module ALU (
  input wire [3:0] ALUCtl,
	input wire [31:0] A,B,
	output reg [31:0] ALUOut,
	output wire Zero);

assign Zero = (ALUOut == 0);
	
always @(*) 
  begin
		case (ALUCtl)
			0: ALUOut = A & B;
			1: ALUOut = A | B;
			2: ALUOut = A + B;
			6: ALUOut = A - B;
			7: ALUOut = A < B ? 1:0;
			12: ALUOut = ~(A | B);
			default: ALUOut = 0;
		endcase
	end
	
endmodule