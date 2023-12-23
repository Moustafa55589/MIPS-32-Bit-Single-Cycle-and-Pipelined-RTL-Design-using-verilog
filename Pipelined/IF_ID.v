module IF_ID (
       input wire clock,reset,
       input wire stall,
       input wire flush,
       input wire [31:0] PCplus4,
       input wire [31:0] inst,
       output reg [31:0] PCplus4out,
       output reg [31:0] instout
       /// flush remeber
       );

always @(posedge clock or negedge reset)
  begin
    if (!reset)
      begin
      instout<='b0;
      PCplus4out<='b0;
      end
    else if (flush)      ///in beq
      begin
        PCplus4out<=PCplus4;
        instout<='b0;
      end
    else if (stall)
      begin
       instout<=instout;
       PCplus4out<=PCplus4out;
      end
    else
      begin
        instout<=inst;
        PCplus4out<=PCplus4;
      end
  end

endmodule