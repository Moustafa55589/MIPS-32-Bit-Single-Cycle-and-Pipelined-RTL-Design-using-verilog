module FWD_UNIT (
    input wire [4:0] Rs_Ex,      //ID/EX.RegisterRs
    input wire [4:0] Rt_Ex,      //ID/EX.RegisterRt
    input wire [4:0] Rt_Rd_Mem,  //EX/MEM.RegisterRd
    input wire [4:0] Rt_Rd_Wb,   //MEM/WB.RegisterRd
    input wire RegWrite_Mem,     //EX/MEM.RegWrite
    input wire RegWrite_Wb,      //MEM/WB.RegWrite
    output reg [1:0] FA,
    output reg [1:0] FB );

always @(*)
  begin
       FA='b00;
       FB='b00;
    //EX Hazard
    if (RegWrite_Mem && (Rt_Rd_Mem!=0) && (Rt_Rd_Mem==Rs_Ex) )
       FA='b10;
    else if (RegWrite_Mem && (Rt_Rd_Mem!=0) && (Rt_Rd_Mem==Rt_Ex) )
       FB='b10;
    //MEM Hazard
    else if (RegWrite_Wb && (Rt_Rd_Wb!=0) && (!(RegWrite_Mem && (Rt_Rd_Mem!=0) && (Rt_Rd_Mem==Rs_Ex) ) ) && (Rt_Rd_Wb==Rs_Ex) )
       FA='b01;
    else if (RegWrite_Wb && (Rt_Rd_Wb!=0) && (!(RegWrite_Mem && (Rt_Rd_Mem!=0) && (Rt_Rd_Mem==Rt_Ex) ) ) && (Rt_Rd_Wb==Rt_Ex) )
       FB='b01;
    else
      begin
        FA='b00;
        FB='b00;
      end
  end

endmodule