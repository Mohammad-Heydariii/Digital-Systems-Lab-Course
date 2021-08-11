`timescale 1ns/1ns

module Func_generatorTB();
reg rst =0;
reg en =0;
reg init =0;
  wire clk, FreqSelector;
  wire [7:0]cout;
  wire [7:0]wave;
  reg [12:0]SW =13'b0;
  
   ring_oscillator Ring(en,clk);
 Amplitude_Selector i3(cout[4], SW, clk, init, cout[5], cout[6], cout[7], cout[0], cout[1], cout[2], cout[3], FreqSelector, wave,rst);
 
  
  initial begin
    #5 rst= 1;
    #10 rst= 0;
    #10 en= 1;
    #5 init= 1;
    #10 SW= 13'b0001000110010; //50 MHz 
    #15000000 SW= 13'b0101000110010; //divided by 2
    #15000000 SW= 13'b1001000110010; //divided by 4
    #15000000 SW= 13'b1101000110010; //divided by 8
    #1500000 $finish;
  end
  
  
  
endmodule



