module MIPSCPU_Pipelined_TB ();
  
  reg CLK;
  reg RST;
  parameter Period = 20;
  
initial 
 begin
 // Save Waveform
   $dumpfile("MIPS.vcd") ;       
   $dumpvars; 
 // initialization
   initialize();
 // Reset
   resett();
  #(12*Period);
  $stop ;
 
 end    

task initialize;
 begin
  CLK   = 1'b0;
  RST='b1;
 end
endtask

task resett;
 begin
 RST =  'b1;
 #(Period);
 RST  = 'b0;
 #(Period);
 RST  = 'b1;
 end
endtask  

always #(Period/2)  CLK = ~CLK ;

Pipeline DUT (
.clock (CLK),
.reset (RST) );

endmodule
