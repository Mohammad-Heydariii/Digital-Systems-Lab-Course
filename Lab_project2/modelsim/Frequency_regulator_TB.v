`timescale 1ns/1ns
module freqregulator_tb();
 
 reg clk=0; 
 reg rst=1;
 reg psi=0;
 wire[7:0]setperiod=8'd125;
 wire[7:0]adjusteddiv;
 freqregulator f(clk,rst,psi,setperiod,adjusteddiv);
 
 
 	 always begin
   #20 clk=~clk;
   end
  
   always begin
   #6400 psi=~psi;
   end
   
   initial begin
     #10 rst=0;
     #1300000
     $stop;
   end
endmodule 
