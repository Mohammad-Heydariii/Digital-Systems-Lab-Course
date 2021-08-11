`timescale 1ns/1ns
module address_counter(input clk,rst,output reg[9:0]cnt);

always @(posedge clk) begin
  if(rst==1)
  cnt =10'b0;
  else
    cnt =cnt+1;
 end

endmodule