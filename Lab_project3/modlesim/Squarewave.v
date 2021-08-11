`timescale 1ns/1ns
module Squarewave(input [7:0]cout,output reg[7:0]wave);
  always@(cout)begin
    if(cout < 8'd127 )
      wave <=8'd127; 
    else
      wave <=8'd0;
    end
      
endmodule
