module MainControl(
	input wire [5:0] Opcode,
	output reg RegDst, RegWrite, ALUSrc,
	output reg MemtoReg, MemRead, MemWrite,
	output reg Branch,
	output reg [1:0] ALUOp);
	
	always @(*)
	  begin
	      RegDst = 0;
				ALUSrc = 0;
				MemtoReg	= 0;
				RegWrite	= 0;
				MemRead	= 0;
				MemWrite	= 0;
				Branch	= 0;
				ALUOp	= 2'b00;
		case(Opcode)
			0: begin
			  // R-Type
				RegDst = 1;
				ALUSrc = 0;
				MemtoReg	= 0;
				RegWrite	= 1;
				MemRead	= 0;
				MemWrite	= 0;
				Branch	= 0;
				ALUOp	= 2'b10;
			end
			35: begin
			  // lw
				RegDst = 0;
				ALUSrc = 1;
				MemtoReg	= 1;
				RegWrite	= 1;
				MemRead	= 1;
				MemWrite	= 0;
				Branch	= 0;
				ALUOp	= 2'b00;
			end
			43: begin
			  //sw
				RegDst = 0;
				ALUSrc = 1;
				MemtoReg	= 0;
				RegWrite	= 0;
				MemRead	= 0;
				MemWrite	= 1;
				Branch	= 0;
				ALUOp	= 2'b00;
			end
			4: begin
			  //beq
				RegDst = 0;
				ALUSrc = 0;
				MemtoReg	= 0;
				RegWrite = 0;
				MemRead	= 0;
				MemWrite	= 0;
				Branch	= 1;
				ALUOp = 2'b01;
			end
			default: begin
			  RegDst = 0;
				ALUSrc = 0;
				MemtoReg	= 0;
				RegWrite	= 0;
				MemRead	= 0;
				MemWrite	= 0;
				Branch	= 0;
				ALUOp	= 2'b00;
			  end
		endcase
	  end

endmodule
	