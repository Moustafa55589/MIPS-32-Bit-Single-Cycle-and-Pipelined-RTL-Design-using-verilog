module MipsCPU(input wire clock, reset
              );

wire [31:0] PCin_S,PCout_S;

wire [31:0] PCoutinc_S;
	
wire [31:0] inst_S;
	
wire RegDst_S, RegWrite_S, ALUSrc_S, MemtoReg_S, MemRead_S, MemWrite_S, Branch_S;
wire [1:0] ALUOp_S;

wire [4:0]  WriteReg_S;

wire [31:0] ReadData1_S, ReadData2_S;
wire [31:0] WriteData_Reg_S;  //from mem to reg

wire [31:0] Extend32_S;

wire [31:0] ALU_B_S;

wire [31:0] ShiftOut_S;

wire [3:0] ALUCtl_S;

wire Zero_S;
wire [31:0] ALUOut_S;

wire [31:0] Add_ALUOut_S;

wire AndGateOut_S;

wire [31:0] ReadData_S;
	
//Connection of PC
PC pc_0(
		//inputs
		.clock(clock),
		.reset(reset),
		.PCin(PCin_S),
		//outputs
		.PCout(PCout_S)	
	);

PCINC pc_adder(
  .PCout1(PCout_S),
  .PCoutinc(PCoutinc_S)
  );

//Connection of InstMem
InstMem instmem_0(
		//inputs
		.address(PCout_S),
		//outputs
		.inst(inst_S)	
	);
	
//Connection of MainControl
	MainControl main_control_0(
		//inputs
		.Opcode(inst_S[31:26]),
		//outputs
		.RegDst(RegDst_S),
		.RegWrite(RegWrite_S),
		.ALUSrc(ALUSrc_S),
		.MemtoReg(MemtoReg_S),
		.MemRead(MemRead_S),
		.MemWrite(MemWrite_S),
		.Branch(Branch_S),
		.ALUOp(ALUOp_S)	
	);
	
//Connection of the Mux between InstMem and RegisterFile
Mux1 mux1_0(
		//inputs
		.inst20_16(inst_S[20:16]),
		.inst15_11(inst_S[15:11]),
		.RegDst(RegDst_S),
		//outputs
		.WriteReg(WriteReg_S)	
	);
	
//Connection of RegFile
RegFile regfile_0(
		//inputs
		.clock(clock),
		.reset(reset),
		.ReadReg1(inst_S[25:21]),
		//***********************************************************************
		.ReadReg2(inst_S[20:16]),
		.RegWrite(RegWrite_S),
		.WriteReg(WriteReg_S),	
		.WriteData(WriteData_Reg_S),
		//outputs
		.ReadData1(ReadData1_S),
		.ReadData2(ReadData2_S)	
	);
	
//Connection of SignExtend
SignExtend sign_extend_0(
		//inputs
		.inst15_0(inst_S[15:0]),
		//outputs
		.Extend32(Extend32_S)
	);
	
//Connection of Mux2
Mux2 mux2_0(
		//inputs
		.ALUSrc(ALUSrc_S),
		.ReadData2(ReadData2_S),
		.Extend32(Extend32_S),
		//outputs
		.ALU_B(ALU_B_S)	
	);
	
//Connection of ShiftLeft2
ShiftLeft2 shift_left2_0(
		//inputs
		.ShiftIn(Extend32_S),
		//outputs
		.ShiftOut(ShiftOut_S)
	);
	
//Connection of ALUControl
ALUControl alu_control_0(
		//inputs
		.ALUOp(ALUOp_S),
		.FuncCode(inst_S[5:0]),
		//outputs
		.ALUCtl(ALUCtl_S)	
	);
	
//Connection of ALU
ALU alu_0(
		//inputs
		.A(ReadData1_S),
		.B(ALU_B_S),
		.ALUCtl(ALUCtl_S),
		//outputs
		.ALUOut(ALUOut_S),
		.Zero(Zero_S)
	);
	
//Connection of Add_ALU
Add_ALU add_alu_0(
		//inputs
		.PCout(PCoutinc_S),
		.ShiftOut(ShiftOut_S),
		//outputs
		.Add_ALUOut(Add_ALUOut_S)	
	);
	
//Connection of AndGate
AndGate and_gate_0(
		//inputs
		.Branch(Branch_S),
		.Zero(Zero_S),
		//outputs
		.AndGateOut(AndGateOut_S)
	);
	
//Connection of Mux4
Mux4 mux4_0(
		//inputs
		.PCout(PCoutinc_S),
		.Add_ALUOut(Add_ALUOut_S),
		.AndGateOut(AndGateOut_S),
		//outputs
		.PCin(PCin_S)
	);
	
//Connection of DataMemory
DataMemory  data_memory_0(
		//inputs
		.clock(clock),
		.reset(reset),
		.address(ALUOut_S[6:0]),
		.MemWrite(MemWrite_S),
		.MemRead(MemRead_S),
		.WriteData(ReadData2_S),
		//outputs
		.ReadData(ReadData_S)
	);
	
//Connection of Mux3
Mux3 mu3_0(
	//inputs
	.MemtoReg(MemtoReg_S),
	.ReadData(ReadData_S),
	.ALUOut(ALUOut_S),
	//outputs
	.WriteData_Reg(WriteData_Reg_S)
	);	
endmodule

