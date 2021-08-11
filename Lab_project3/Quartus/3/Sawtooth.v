// Sawtooth
`timescale 1ns/1ns
module Sawtooth(input [7:0]cout,output reg[7:0]wave);
  always@(cout)begin
    if(cout<8'd127)
      wave=cout+8'd127; // a line with unit slope and 127 offset
    else
      wave=cout-8'd127; // breaking point
      end
      
endmodule
 

