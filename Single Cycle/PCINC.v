module PCINC (
   input wire [31:0] PCout1,
   output reg [31:0] PCoutinc);
   
always @(*)
   begin
    PCoutinc = PCout1 + 4 ;
   end

endmodule