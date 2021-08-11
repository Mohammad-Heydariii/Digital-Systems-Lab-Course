// Rhomboid
`timescale 1ns/1ns
module Rhomboid(input [7:0]cout,input res,output reg[7:0]wave);
  reg[7:0]signal_1;
  reg[7:0]signal_2;  
  // we must generate the 2 lines in each period and frequently choose between them
  always @(cout)begin
    signal_1 <=8'b0;
    signal_2 <=8'b0;
    if(cout<8'd127)begin // this is for the first half of the period
      signal_1 <= cout + 8'd127; // line with positive slope with 127 offset
      signal_2 <= 8'd127 - cout; // line with negative slope with 127 offset
    end
     else if(cout>8'd127)begin // the else is the second half of the period
       signal_1 <= 8'd128 - cout; // line with negative slope with 128 offset
       signal_2 <= cout - 8'd127; // line with positive slope with -127 offset
     end
    end
    // this always is for selecting signal_1 or signal_2 for the output wave
    always@(cout)begin
     wave <=8'b0; 
      if(res==1) // for the duty cycle we choose cout[4] for the res input in the wave generator
        wave <=signal_1;
       else if(res==0)
        wave <=signal_2;
     end
endmodule
