module PC (
    input wire clock,
    input wire reset,
    input wire PC_Stop,
    input wire [31:0] PCin,
    output reg [31:0] PCout);

always @(posedge clock or negedge reset)  
  begin
		if (!reset) 
			PCout <= 0;
		else if (PC_Stop)
			PCout <= PCout; 
    else
      PCout <= PCin;
	end 
	
endmodule