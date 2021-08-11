`timescale 1ns/1ns
module counter_wave(input clk,rst,output reg[7:0]cnt);

always @(posedge clk) begin
  if (rst==1)
    cnt =8'b0;
  else
    cnt =cnt+1;
 end

endmodule