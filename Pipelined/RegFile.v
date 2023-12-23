module RegFile(
         input wire clock,RegWrite,reset,
         input wire [4:0] ReadReg1, ReadReg2, WriteReg,
         input wire [31:0] WriteData,
         output wire [31:0] ReadData1, ReadData2);

reg [31:0] reg_mem [0:31];  //init memory

assign ReadData1 = reg_mem[ReadReg1];
assign ReadData2 = reg_mem[ReadReg2];

always @(negedge clock or reset) //posedge clock or negedge reset
	begin
	  if (!reset)
	    begin
		    reg_mem[0] <= 0; // $0
		    reg_mem[1] <= 8; //R1
		    reg_mem[2] <= 20; //R2
	    end
		else if (RegWrite)
			reg_mem[WriteReg] <= WriteData;
	end	
	
endmodule