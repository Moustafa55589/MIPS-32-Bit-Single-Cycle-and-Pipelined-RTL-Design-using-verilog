module Hazard_Unit (
      input wire MemRead_Ex,
      input wire [4:0] Rt_Ex,
      input wire [4:0] Rs_Id,    //inst[25:21]
      input wire [4:0] Rt_Id,    //inst[20:16]
      output reg stall,
      output reg PC_Stop,
      output reg Mux_Signal_Zeroeing );

always @(*)
   begin
     if (MemRead_Ex && ( (Rt_Ex==Rs_Id) || (Rt_Ex==Rt_Id) )  )
        begin
          stall='b1;
          PC_Stop='b1;
          Mux_Signal_Zeroeing='b1;   //output signals = zeros
        end
     else
        begin
          stall='b0;
          PC_Stop='b0;
          Mux_Signal_Zeroeing='b0;   
        end
   end

endmodule      