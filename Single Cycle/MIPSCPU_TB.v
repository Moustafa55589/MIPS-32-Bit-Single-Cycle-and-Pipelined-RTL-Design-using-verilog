module MIPSCPU_TB ();
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
  #(6*Period);
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

MipsCPU DUT (
.clock (CLK),
.reset (RST) );

endmodule