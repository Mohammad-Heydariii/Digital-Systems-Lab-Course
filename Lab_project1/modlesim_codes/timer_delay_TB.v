`timescale 1ns/1ns
module timer_with_delay_TB;

 reg  rst;
 wire pulse;




  
 timer_with_delay #(1,1,10)  t1 (clk,pulse); 
  
  initial begin
 
   
    rst = 1'b0;
    
    #13 rst = 1'b0;
    
    

    #500 $finish;
  end
  
  
endmodule
