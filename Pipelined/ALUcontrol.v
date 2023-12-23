module ALUControl (	
  input wire [1:0] ALUOp,
	input wire [5:0] FuncCode,
	output reg [3:0] ALUCtl);

always @(*) 
	  begin
	    if(ALUOp == 0)
		    ALUCtl = 2;    //LW and SW use add
	    else if(ALUOp == 1)
		    ALUCtl = 6;		// branch use subtract
	    else
	      begin
		 case(FuncCode)
			32: ALUCtl = 2; //add
			34: ALUCtl = 6; //subtract		
			36: ALUCtl = 0; //and	
			37: ALUCtl = 1; //or	
			39: ALUCtl = 12; //nor
			42: ALUCtl = 7; //slt
			default: ALUCtl = 15; //should not happen
		endcase
		    end
	end
	
endmodule