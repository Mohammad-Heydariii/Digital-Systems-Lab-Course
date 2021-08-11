
// frequency_multiplier


module FreqMult(input adjust,RefClk,rst,InFreq,input [2:0]n,output OutFreq,done,output[15:0]shiftduration);
 
  wire init_ratio,InFreq_status,shift,preload_clk_divider , completed ;
  
FreqMultDP DP(RefClk,rst,InFreq,init_ratio,InFreq_status,shift,preload_clk_divider,n,OutFreq,shiftduration , completed);
  
FreqMultCU CU(rst,RefClk,adjust, completed,done,init_ratio,InFreq_status,shift,preload_clk_divider);


endmodule
