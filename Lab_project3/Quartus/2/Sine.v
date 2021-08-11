// Sinusoid
`timescale 1ns/1ns
module Sine(input clk,rst, input[7:0]cout, output reg[7:0]wave);

reg signed[15:0] sine, cos;
reg signed[15:0] sine_r, cos_r;

always@(posedge clk,posedge rst)begin
  if (rst)begin
    sine_r <= 16'd0;
    cos_r <= 16'd30000; //initial values for differential equations
 
  end
   else begin
    sine = sine_r+{{6{cos_r[15]}},cos_r[15:6]};
    cos = cos_r-{{6{sine[15]}},sine[15:6]};
    sine_r = sine;
    cos_r = cos;
    wave = sine[15:8] ; //+128;
   end
 end

endmodule