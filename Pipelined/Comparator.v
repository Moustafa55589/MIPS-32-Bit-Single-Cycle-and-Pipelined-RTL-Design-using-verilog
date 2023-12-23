module Comparator (
         input wire [31:0] DataOne_Id,
         input wire [31:0] DataTwo_Id,
         input wire Branch,
         output reg Br_Taken_Id
                  );

always @(*)
  begin
    if ( (DataOne_Id==DataTwo_Id) && Branch )
       Br_Taken_Id='b1;
    else
       Br_Taken_Id='b0;
  end

endmodule
       
