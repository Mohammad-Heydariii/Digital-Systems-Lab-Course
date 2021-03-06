`timescale 1 ns/ 1 ns
module exptest;
	reg clk,rst,start;
	reg [15:0] x;
	wire done;
	wire [1:0] intpart;
	wire [15:0]fracpart;
	
	exponential exp(clk,rst,start,x,done,intpart,fracpart);
	
	initial begin
		rst = 1'b1;
		clk = 1'b0;
		start = 1'b0;
	end
	
	initial #24 rst = 1'b0;
	
	always #5 clk = ~clk;

	initial begin
		#10 start = 1'b1;
		#11 x = 16'h8000;
		#40 start = 1'b0;
		
		#50 x = 0;
		#1000 start = 1'b1;
		#20 start = 1'b0;
	end
endmodule 
