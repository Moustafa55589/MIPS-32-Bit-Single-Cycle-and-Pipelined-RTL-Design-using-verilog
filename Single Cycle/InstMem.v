module InstMem(
       input wire [31:0] address,
       output reg [31:0]	inst );
	
reg [31:0] Mem [0:127];   // init of memory
	
initial 
   begin
     Mem[0]='h00221820;   //add: R3, R1, R2  
     Mem[1]='hAC010000;   //sw: R1, 0(R0)
     Mem[2]='h8C240000;   //lw R4, 0(R1)
     Mem[3]='h10210001;   //beq R1, R1, +8 //Branch taken 
	   Mem[4]='h00001820;   //add R3, R0, R0 ////This instruction will be skipped because of branch taken
     Mem[5]='h00411822;  // sub R3, R2, R1	
	 end
	 
always @ (*)
     begin
		   inst = Mem[address[31:2]];
	   end
endmodule
