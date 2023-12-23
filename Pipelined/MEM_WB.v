module MEM_WB (
         input wire clock,reset,
         input wire MemtoReg_Mem, 
         output reg MemtoReg_Wb,
         input wire RegWrite_Mem,
         output reg RegWrite_Wb,
         input wire [31:0] ReadData_Mem,
         output reg [31:0] ReadData_Wb,
         input wire [31:0] ALUOUT_Mem,
         output reg [31:0] ALUOUT_Wb,
         input wire [4:0] Rt_Rd_Mem,
         output reg [4:0] Rt_Rd_Wb );

always @(posedge clock or negedge reset)
  begin
    if (!reset)
      begin
        MemtoReg_Wb<='b0;
        RegWrite_Wb<='b0;
        ReadData_Wb<='b0;
        ALUOUT_Wb<='b0;
        Rt_Rd_Wb<='b0;
      end
    else
      begin
        MemtoReg_Wb<=MemtoReg_Mem;
        RegWrite_Wb<=RegWrite_Mem;
        ReadData_Wb<=ReadData_Mem;
        ALUOUT_Wb<=ALUOUT_Mem;
        Rt_Rd_Wb<=Rt_Rd_Mem;
      end
  end

endmodule