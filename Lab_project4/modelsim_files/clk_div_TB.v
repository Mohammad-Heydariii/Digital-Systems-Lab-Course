`timescale 1 ps/1ps
module clkdiv2n_tb;
  reg RefClk,reset;
  reg [7:0]N=8'b10111000;
  wire OutFreq;
 
    clk_div t1(RefClk,reset,N,OutFreq);
        initial
          RefClk= 1'b0;
     always
        #3333  RefClk=~RefClk; 
        initial
            begin
               #5000 reset=1'b1;
               #10000 reset=1'b0;
               #500000000 $finish;
            end
 
     
    endmodule
