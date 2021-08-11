// Square wave 
`timescale 1ns/1ns
module Squarewave(input [7:0]cout,output reg[7:0]wave);
  always@(cout)begin
    if(cout < 8'd127 ) // until the half of the period
      wave <=8'd127; // on duration
    else
      wave <=8'd0; // off duration
    end
      
endmodule
