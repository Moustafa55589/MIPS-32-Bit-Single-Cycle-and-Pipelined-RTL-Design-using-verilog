module SignExtend (	
  input wire [15:0] inst15_0,
	output reg [31:0] Extend32);

always @(*) 
  begin
    // Extend32[31:0]<= inst15_0[15:0];
		Extend32<= { {16{inst15_0[15]} } , inst15_0 };
	end
	
endmodule
