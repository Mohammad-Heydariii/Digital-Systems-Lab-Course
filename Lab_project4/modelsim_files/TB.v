`timescale 1 ps/ 1 ps
module DP_TB();

	reg RefClk=0,rst=1,init=0,InFreq=0;
        reg [2:0]n=3'b011;
        wire OutFreq;
        wire [15:0]shiftduration;
	
	FreqMultDP dp(RefClk,rst,InFreq,init,n,OutFreq,shiftduration);
	

	initial begin
		rst = 1'b1;
		RefClk = 1'b0;
		init = 1'b0;
	end
	
	initial #30000 rst = 1'b0;
	
	always #3333 RefClk=~RefClk;
        
        always #10000000 InFreq = ~InFreq;

	
endmodule 
