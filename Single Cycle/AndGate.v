module AndGate(	
  input wire Branch,
	input wire Zero,
	output reg AndGateOut);

always @(*) 
  begin
		AndGateOut = Branch && Zero;
	end

endmodule
