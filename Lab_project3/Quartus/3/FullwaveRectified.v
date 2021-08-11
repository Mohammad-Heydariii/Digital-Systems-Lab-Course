// FullwaveRectified sine
`timescale 1ns/1ns
module FullwaveRectified(input clk,rst, input[7:0]cout, output reg[7:0]wave);

reg[7:0]signal;
reg signed[15:0] sine, cos;
reg signed[15:0] sine_r, cos_r;

always@(posedge clk,posedge rst)begin
  if (rst)begin
    sine_r <= 16'd0;
    cos_r <= 16'd30000;
 
  end
   else begin
    sine = sine_r+{{6{cos_r[15]}},cos_r[15:6]};
    cos = cos_r-{{6{sine[15]}},sine[15:6]};
    sine_r = sine;
    cos_r = cos;
    signal = sine[15:8];
   end
 end
 
 // this always is for rectifing the sin waveform
 always@(cout)begin
   if(signal[7]==0)
    wave <= signal;
   else if(signal[7]==1) // when the signal[7] becomes one it means we are in the negative half of the period
    wave <= -signal; 
   end
 

endmodule