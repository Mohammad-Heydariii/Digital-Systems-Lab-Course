`timescale 1ns/1ns

module frequency_selTB();
reg rst =0; 
reg en =0; 
reg init =0;
  wire clk, FreqSelector;
  wire [7:0]cout ;
  wire [7:0]wave ;
  reg [10:0]SW =11'b0;
  
 ring_oscillator Ring(en,clk);
  frequency_selector i2(cout[4], SW, clk, init, cout[5], cout[6], cout[7], cout[0], cout[1], cout[2], cout[3], FreqSelector, wave, rst);
  




  initial begin
    #5 rst= 1;
    #10 rst= 0;
    #10 en= 1;
    #5 init= 1;
    #10 SW= 11'b00100110010; //50 MHz 
    #15000000 SW= 11'b00101100100; //100 MHz 
    #15000000 SW= 11'b00111001000; //200 MHz 
    #15000000 $finish;
  end
  
  
endmodule

