`timescale 1ns/1ns
module wave_chek_tb();

reg clk = 1;
reg rst=1;
reg [7:0] count = 8'b0;
wire [7:0]signal;

//Rhomboid rh(count,count[3],signal);
//Sine si(clk,rst,count,signal);
//Squarewave sq(count,signal); 
//Reciprocal tr(count,signal);
//Sawtooth sa(count,signal);
//FullwaveRectified re(clk,rst,count,signal);
ModulatedSquarewave mo(clk,rst,count,signal);
always #10 clk = ~clk;
always @(posedge clk) begin
  if (count == 8'd255)
    count =8'b0;
  else
    count = count +1;
end
initial begin
  #10 rst=0;
  #60000
  $stop;
end 
endmodule



