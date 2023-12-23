module DataMemory (
          input wire clock,reset, 
          input wire [6:0] address, 
          input wire MemWrite, MemRead, 
          input wire [31:0] WriteData, 
          output wire [31:0] ReadData);

reg [31:0] Mem [0:127]; //32 bits memory with 128 entries

assign  ReadData = Mem[address[6:2]];

always @ (posedge clock or negedge reset)
	 begin
	   if (!reset)
	     	 begin
		       Mem[0] <= 5;
		       Mem[1] <= 6;
		       Mem[2] <= 7;
	       end
     else if (MemWrite && !MemRead)
			     Mem[address[6:2]] <= WriteData; 
	 end

endmodule