module EX_MEM (
         input wire clock,reset,
         input wire MemtoReg_Ex, 
         output reg MemtoReg_Mem,
         input wire RegWrite_Ex,
         output reg RegWrite_Mem,
         input wire MemWrite_Ex, 
         output reg MemWrite_Mem,
         input wire MemRead_Ex,
         output reg MemRead_Mem,
         input wire [4:0] Rt_Rd_Ex,
         output reg [4:0] Rt_Rd_Mem,
         input wire [31:0] ALUOUT_Ex,
         output reg [31:0] ALUOUT_Mem,
         input wire [31:0] StoreVal_Ex,
         output reg [31:0] StoreVal_Mem );

always @(posedge clock or negedge reset)
  begin
    if (!reset)
      begin
        MemtoReg_Mem<='b0;
        RegWrite_Mem<='b0;
        MemWrite_Mem<='b0;
        MemRead_Mem<='b0;
        Rt_Rd_Mem<='b0;
        ALUOUT_Mem<='b0;
        StoreVal_Mem<='b0;
      end
    else
      begin
        MemtoReg_Mem<=MemtoReg_Ex;
        RegWrite_Mem<=RegWrite_Ex;
        MemWrite_Mem<=MemWrite_Ex;
        MemRead_Mem<=MemRead_Ex;
        Rt_Rd_Mem<=Rt_Rd_Ex;
        ALUOUT_Mem<=ALUOUT_Ex;
        StoreVal_Mem<=StoreVal_Ex; 
      end
  end

endmodule       