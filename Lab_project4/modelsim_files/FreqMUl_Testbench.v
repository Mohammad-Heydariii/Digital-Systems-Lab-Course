// Testbench for frequency multiplier unit

`timescale 1ps/ 1ps

module FreqMultTB();
  reg RefClk=0,rst=1,adjust=0,InFreq=0;
  reg [2:0]n= 3'b110;   // n=4

  wire OutFreq,done;
  wire [15:0]shiftduration;
	
	FreqMult FrequencyMultiplier(adjust,RefClk,rst,InFreq,n,OutFreq,done,shiftduration);
	

	
	
	initial #30000 rst = 1'b0;
	
	always #3333 RefClk=~RefClk;          // 150Mhz frequency
        
        always #500000 InFreq = ~InFreq;    //1Mhz frequency Freq
	
       initial begin
		#40000 adjust = 1'b1;      // start becomes one
	
		#10000 adjust = 1'b0;      // start becomes ziro
		
		
	end
endmodule 


