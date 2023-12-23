module ShiftLeft2 (
  input wire [31:0] ShiftIn,
	output reg [31:0] ShiftOut);

always @(*) 
	begin
		ShiftOut = ShiftIn << 2;
	end 
	
endmodule