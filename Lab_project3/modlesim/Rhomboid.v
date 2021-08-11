`timescale 1ns/1ns
module Rhomboid(input [7:0]cout,input res,output reg[7:0]wave);
  reg[7:0]signal_1;
  reg[7:0]signal_2;  
  always @(cout)begin
    signal_1 <=8'b0;
    signal_2 <=8'b0;
    if(cout<8'd127)begin 
      signal_1 <= cout + 8'd127; 
      signal_2 <= 8'd127 - cout; 
    end
     else if(cout>8'd127)begin 
       signal_1 <= 8'd128 - cout; 
       signal_2 <= cout - 8'd127;
     end
    end
    
    always@(cout)begin
     wave <=8'b0; 
      if(res==1) 
        wave <=signal_1;
       else if(res==0)
        wave <=signal_2;
     end
endmodule
