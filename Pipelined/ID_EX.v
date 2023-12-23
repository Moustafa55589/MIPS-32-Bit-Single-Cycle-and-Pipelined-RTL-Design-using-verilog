module ID_EX (
         input wire clock,reset,
         input wire [4:0] Rs_Id,
         output reg [4:0] Rs_Ex,
         input wire [4:0] Rt_Id,
         output reg [4:0] Rt_Ex,
         input wire [4:0] Rd_Id,
         output reg [4:0] Rd_Ex,
         input wire [31:0] DataOne_Id,
         output reg [31:0] DataOne_Ex,
         input wire [31:0] DataTwo_Id,
         output reg [31:0] DataTwo_Ex,
         input wire [31:0] Extend_Id,
         output reg [31:0] Extend_Ex,
         input wire RegWrite_Id,
         output reg RegWrite_Ex,
         input wire MemtoReg_Id, 
         output reg MemtoReg_Ex,
         input wire MemWrite_Id, 
         output reg MemWrite_Ex,
         input wire MemRead_Id,
         output reg MemRead_Ex,
         input wire [1:0] ALU_Op_Id,
         output reg [1:0] ALU_Op_Ex,
         input wire [5:0] Funct_Id,    // alu control in this stage
         output reg [5:0] Funct_Ex,    
         input wire ALUSrc_Id,
         output reg ALUSrc_Ex,  
         input wire RegDst_Id,
         output reg RegDst_Ex,
         input wire Br_Taken_Id,
         output reg Br_Taken_Ex );

always @ (posedge clock or negedge reset)
  begin
    if (!reset)
       begin
         Rs_Ex<='b0;
         Rt_Ex<='b0;
         Rd_Ex<='b0;
         DataOne_Ex<='b0;
         DataTwo_Ex<='b0;
         Extend_Ex<='b0;
         RegWrite_Ex<='b0;
         MemtoReg_Ex<='b0;
         MemWrite_Ex<='b0;
         MemRead_Ex<='b0;
         ALU_Op_Ex<='b0;
         Funct_Ex<='b0;
         ALUSrc_Ex<='b0;
         RegDst_Ex<='b0;
         Br_Taken_Ex<='b0;
       end
    else
       begin
         Rs_Ex<=Rs_Id;
         Rt_Ex<=Rt_Id;
         Rd_Ex<=Rd_Id;
         DataOne_Ex<=DataOne_Id;
         DataTwo_Ex<=DataTwo_Id;
         Extend_Ex<=Extend_Id;
         RegWrite_Ex<=RegWrite_Id;
         MemtoReg_Ex<=MemtoReg_Id;
         MemWrite_Ex<=MemWrite_Id;
         MemRead_Ex<=MemRead_Id;
         ALU_Op_Ex<=ALU_Op_Id;
         Funct_Ex<=Funct_Id;
         ALUSrc_Ex<=ALUSrc_Id;
         RegDst_Ex<=RegDst_Id;
         Br_Taken_Ex<=Br_Taken_Id;
       end
  end

endmodule