`timescale 1us/1us
module lm_555_timer_TB;

 reg  clk,rst;
 wire pulse;




  
 lm_555_timer #(1,1,10)  t1 (clk,rst,pulse); 
  
  initial begin
 
   
    rst = 1'b0;
    clk = 1'b0;
    #13 rst = 1'b1;
    #20 rst = 1'b0;

    #500 $finish;
  end
  
  always
  begin
    #10 clk = ~clk;
  end
  
  
endmodule
