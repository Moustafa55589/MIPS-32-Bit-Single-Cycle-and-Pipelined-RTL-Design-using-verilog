module FB_Mux (
    input wire [31:0] DataTwo_Ex,
    input wire [31:0] ALUOUT_Mem,
    input wire [31:0] WriteData_Reg,
    input wire [1:0] FB,
    output reg [31:0] FB_OUT );

always @(*)
   begin
     FB_OUT=DataTwo_Ex;
     case(FB)
       'b00:FB_OUT=DataTwo_Ex;
       'b01:FB_OUT=WriteData_Reg;
       'b10:FB_OUT=ALUOUT_Mem;
       default:FB_OUT=DataTwo_Ex;
       endcase
   end

endmodule