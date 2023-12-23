module Pipeline (
        clock,reset,
        PCin,    //mux4
        PCout,   //PC
        inst,    //instmem
        PCoutinc, //PCINC
        PCplus4out,instout, //IF_ID
        stall,PC_Stop,Mux_Signal_Zeroeing,  //Hazard_Detection
        RegDst, RegWrite, ALUSrc,MemtoReg, MemRead, MemWrite,Branch,Flush,ALUOp,  //main control
        ShiftOut, //shift left
        Extend32, //sign extend
        Add_ALUOut, //Add_ALU
        ReadData1, ReadData2, //RegFile
        Br_Taken_Id, //Comparator
        Rs_Ex,Rt_Ex,Rd_Ex,DataOne_Ex,DataTwo_Ex,Extend_Ex,RegWrite_Ex,MemtoReg_Ex,MemWrite_Ex,MemRead_Ex,ALU_Op_Ex,Funct_Ex,ALUSrc_Ex,RegDst_Ex,Br_Taken_Ex,   //ID_EX
        ALU_B, //Mux2
        FA_OUT, //FA_Mux
        FB_OUT, //FB_Mux
        WriteReg, //Mux1
        ALUOut,Zero, //ALU
        FA,FB, //FWD_Unit
        ALUCtl, //ALU Control
        MemtoReg_Mem,RegWrite_Mem,MemWrite_Mem,MemRead_Mem,Rt_Rd_Mem,ALUOUT_Mem,StoreVal_Mem,  //EX_MEM
        ReadData, //DataMemory
        MemtoReg_Wb,RegWrite_Wb,ReadData_Wb,ALUOUT_Wb,Rt_Rd_Wb, //MEM_WB
        WriteData_Reg ); //Mux3

input wire clock,reset;

//Mux4//////////////////////////////

output wire [31:0] PCoutinc,Add_ALUOut,PCin;
output wire Br_Taken_Id;

Mux4 mux4_u(
.PCout(PCoutinc),
.Add_ALUOut(Add_ALUOut),
.Br_Taken(Br_Taken_Id),
.PCin(PCin) );

//PC////////////////////////

output wire [31:0] PCout;
output wire PC_Stop;

PC pc_u(
.clock(clock),
.reset(reset),
.PC_Stop(PC_Stop),
.PCin(PCin),
.PCout(PCout) );

//instMem/////////////////

output wire [31:0] inst;

InstMem instmem_u(
.address(PCout),
.inst(inst) );

//PCINC/////////////////

PCINC pcinc_u(
.PCout1(PCout),
.PCoutinc(PCoutinc) );

//IF_ID////////////////////

output wire [31:0] PCplus4out,instout;
output wire stall,Flush;


IF_ID if_id_u(
.clock(clock),
.reset(reset),
.stall(stall),
.flush(Flush),
.PCplus4(PCoutinc),
.inst(inst),
.PCplus4out(PCplus4out),
.instout(instout) );

//Hazard Detection/////////////////////

output wire Mux_Signal_Zeroeing,MemRead_Ex;
output wire [4:0] Rt_Ex;

Hazard_Unit hazard_unit_u(
.MemRead_Ex(MemRead_Ex),
.Rt_Ex(Rt_Ex),
.Rs_Id(instout[25:21]),
.Rt_Id(instout[20:16]),
.stall(stall),
.PC_Stop(PC_Stop),
.Mux_Signal_Zeroeing(Mux_Signal_Zeroeing) );

//Main control//////////////////////////

output wire RegDst,RegWrite,ALUSrc,MemtoReg,MemRead,MemWrite,Branch;
output wire [1:0] ALUOp;

MainControl maincontrol_u(
.Mux_Signal_Zeroeing(Mux_Signal_Zeroeing),
.Opcode(instout[31:26]),
.RegDst(RegDst),
.RegWrite(RegWrite),
.ALUSrc(ALUSrc),
.MemtoReg(MemtoReg),
.MemRead(MemRead),
.MemWrite(MemWrite),
.Branch(Branch),
.Flush(Flush),
.ALUOp(ALUOp) );

//shift left//////////////////////

output wire [31:0] ShiftOut,Extend32;

ShiftLeft2 shiftleft2_u(
.ShiftIn(Extend32),
.ShiftOut(ShiftOut) );

//sign extend///////////////////////

SignExtend signextend_u(
.inst15_0(instout[15:0]),
.Extend32(Extend32) );

//add_ALU//////////////////////////

Add_ALU add_alu_u(
.PCout(PCplus4out),
.ShiftOut(ShiftOut),
.Add_ALUOut(Add_ALUOut) );

//RegFile///////////////////////////
output wire [31:0] ReadData1,ReadData2,WriteData_Reg;
output wire RegWrite_Wb;
output wire [4:0] Rt_Rd_Wb;

RegFile regfile_u(
.clock(clock),
.reset(reset),
.RegWrite(RegWrite_Wb),
.ReadReg1(instout[25:21]),
.ReadReg2(instout[20:16]),
.WriteReg(Rt_Rd_Wb),
.WriteData(WriteData_Reg),
.ReadData1(ReadData1),
.ReadData2(ReadData2) );

//Comparator///////////////////////

Comparator comparator_u(
.DataOne_Id(ReadData1),
.DataTwo_Id(ReadData2),
.Branch(Branch),
.Br_Taken_Id(Br_Taken_Id) );

//ID_EX///////////////////////////

output wire [4:0] Rs_Ex,Rd_Ex;
output wire [31:0] DataOne_Ex,DataTwo_Ex,Extend_Ex;
output wire RegWrite_Ex,MemtoReg_Ex,MemWrite_Ex,ALUSrc_Ex,RegDst_Ex,Br_Taken_Ex;
output wire [1:0] ALU_Op_Ex;
output wire [5:0] Funct_Ex;

ID_EX id_ex_u(
.clock(clock),
.reset(reset),
.Rs_Id(instout[25:21]),
.Rs_Ex(Rs_Ex),
.Rt_Id(instout[20:16]),
.Rt_Ex(Rt_Ex),
.Rd_Id(instout[15:11]),
.Rd_Ex(Rd_Ex),
.DataOne_Id(ReadData1),
.DataOne_Ex(DataOne_Ex),
.DataTwo_Id(ReadData2),
.DataTwo_Ex(DataTwo_Ex),
.Extend_Id(Extend32),
.Extend_Ex(Extend_Ex),
.RegWrite_Id(RegWrite),
.RegWrite_Ex(RegWrite_Ex),
.MemtoReg_Id(MemtoReg),
.MemtoReg_Ex(MemtoReg_Ex),
.MemWrite_Id(MemWrite),
.MemWrite_Ex(MemWrite_Ex),
.MemRead_Id(MemRead),
.MemRead_Ex(MemRead_Ex),
.ALU_Op_Id(ALUOp),
.ALU_Op_Ex(ALU_Op_Ex),
.Funct_Id(instout[5:0]),
.Funct_Ex(Funct_Ex),
.ALUSrc_Id(ALUSrc),
.ALUSrc_Ex(ALUSrc_Ex),
.RegDst_Id(RegDst),
.RegDst_Ex(RegDst_Ex),
.Br_Taken_Id(Br_Taken_Id),
.Br_Taken_Ex(Br_Taken_Ex) );

//Mux2//////////////////////////////////////////
output wire [31:0] FB_OUT;
output wire [31:0] ALU_B;

Mux2 mux2_u(
.ALUSrc(ALUSrc_Ex),
.Extend_Ex(Extend_Ex),
.DataTwo_Ex(FB_OUT),  //DataTwo_Ex
.ALU_B(ALU_B) );

//FA Mux//////////////////////////////////////////

output wire [31:0] FA_OUT;
output wire [31:0] ALUOUT_Mem;
output wire [1:0] FA;

FA_Mux fa_mux_u(
.DataOne_Ex(DataOne_Ex),
.ALUOUT_Mem(ALUOUT_Mem),
.WriteData_Reg(WriteData_Reg),
.FA(FA),
.FA_OUT(FA_OUT) );

//FB Mux//////////////////////////////////////////


output wire [1:0] FB;

FB_Mux fb_mux_u(
.DataTwo_Ex(DataTwo_Ex),
.ALUOUT_Mem(ALUOUT_Mem),
.WriteData_Reg(WriteData_Reg),
.FB(FB),
.FB_OUT(FB_OUT) );

//Mux1///////////////////////////////////////////

output wire [4:0] WriteReg;

Mux1 mux1_u(
.Rt_Ex(Rt_Ex),
.Rd_Ex(Rd_Ex),
.RegDst(RegDst_Ex),
.WriteReg(WriteReg) );

//ALU///////////////////////////////////////////////

output wire [31:0] ALUOut;
output wire [3:0] ALUCtl;
output wire Zero;

ALU alu_u(
.ALUCtl(ALUCtl),
.A(FA_OUT),
.B(ALU_B),    //FB_OUT
.ALUOut(ALUOut),
.Zero(Zero) );

//FWD Unit///////////////////////////////////////////

output wire [4:0] Rt_Rd_Mem;
output wire RegWrite_Mem;

FWD_UNIT fwd_unit_u(
.Rs_Ex(Rs_Ex),
.Rt_Ex(Rt_Ex),
.Rt_Rd_Mem(Rt_Rd_Mem),
.Rt_Rd_Wb(Rt_Rd_Wb),
.RegWrite_Mem(RegWrite_Mem),
.RegWrite_Wb(RegWrite_Wb),
.FA(FA),
.FB(FB) );

//ALU Control////////////////////////////////////////

ALUControl alucontrol_u(
.ALUOp(ALU_Op_Ex),
.FuncCode(Funct_Ex),
.ALUCtl(ALUCtl) );

//EX_MEM///////////////////////////////////////////////

output wire MemtoReg_Mem,MemWrite_Mem,MemRead_Mem;
output wire [31:0] StoreVal_Mem;

EX_MEM ex_mem_u(
.clock(clock),
.reset(reset),
.MemtoReg_Ex(MemtoReg_Ex),
.MemtoReg_Mem(MemtoReg_Mem),
.RegWrite_Ex(RegWrite_Ex),
.RegWrite_Mem(RegWrite_Mem),
.MemWrite_Ex(MemWrite_Ex),
.MemWrite_Mem(MemWrite_Mem),
.MemRead_Ex(MemRead_Ex),
.MemRead_Mem(MemRead_Mem),
.Rt_Rd_Ex(WriteReg),   ////
.Rt_Rd_Mem(Rt_Rd_Mem),
.ALUOUT_Ex(ALUOut),   ///
.ALUOUT_Mem(ALUOUT_Mem),
.StoreVal_Ex(DataTwo_Ex),  ///DataTwo_Ex FB_OUT
.StoreVal_Mem(StoreVal_Mem) );

//Data Memory////////////////////////////////////////////

output wire [31:0] ReadData;

DataMemory datamemory_u(
.clock(clock),
.reset(reset),
.address(ALUOUT_Mem[6:0]),
.MemWrite(MemWrite_Mem),
.MemRead(MemRead_Mem),
.WriteData(StoreVal_Mem),
.ReadData(ReadData) );

//MEM_WB/////////////////////////////////////////////////

output wire MemtoReg_Wb;
output wire [31:0]  ReadData_Wb;
output wire [31:0] ALUOUT_Wb;

MEM_WB mem_wb_u(
.clock(clock),
.reset(reset),
.MemtoReg_Mem(MemtoReg_Mem),
.MemtoReg_Wb(MemtoReg_Wb),
.RegWrite_Mem(RegWrite_Mem),
.RegWrite_Wb(RegWrite_Wb),
.ReadData_Mem(ReadData),
.ReadData_Wb(ReadData_Wb),
.ALUOUT_Mem(ALUOUT_Mem),
.ALUOUT_Wb(ALUOUT_Wb),
.Rt_Rd_Mem(Rt_Rd_Mem),
.Rt_Rd_Wb(Rt_Rd_Wb) );

//Mux3//////////////////////////////////////////////////////

Mux3 mux3_u(
.ReadData_Wb(ReadData_Wb),
.ALUOut_Wb(ALUOUT_Wb),
.MemtoReg(MemtoReg_Wb),
.WriteData_Reg(WriteData_Reg) );

endmodule