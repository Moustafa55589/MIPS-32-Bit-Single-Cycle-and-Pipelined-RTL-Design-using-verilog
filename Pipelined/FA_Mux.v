module FA_Mux (
    input wire [31:0] DataOne_Ex,
    input wire [31:0] ALUOUT_Mem,
    input wire [31:0] WriteData_Reg,
    input wire [1:0] FA,
    output reg [31:0] FA_OUT );

always @(*)
   begin
     FA_OUT=DataOne_Ex;
     case(FA)
       'b00:FA_OUT=DataOne_Ex;
       'b01:FA_OUT=WriteData_Reg;
       'b10:FA_OUT=ALUOUT_Mem;
       default:FA_OUT=DataOne_Ex;
       endcase
   end

endmodule