module FreqMultDP(input RefClk,rst,InFreq,init_ratio,InFreq_status,shift,preload_clk_divider,input[2:0]n,output OutFreq,output[15:0]shiftduration , output completed);
  wire [15:0]duration;
  
  Divider div(InFreq,RefClk,rst,duration, completed );
  Shifter shifting(duration,n-1,shiftduration);
  clk_div t1(RefClk,rst,preload_clk_divider,{1'b0,shiftduration[15:1]},OutFreq);
  
endmodule
