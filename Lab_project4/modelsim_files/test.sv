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
		#11 x = 16'b1110011001000000;       // exp(0.9) = 2.45 
		#40 start = 1'b0;
		
		#1000 x = 0;
		#1000 start = 1'b1;                 // exp(0.0) = 1 = 0.99999
		#20 start = 1'b0; 

                #1000 x = 16'b1000000000000000;
		#1000 start = 1'b1;                 // exp(0.5) = 1.68
		#20 start = 1'b0; 


                #1000 x = 16'b0100110011000000;
		#1000 start = 1'b1;                 // exp(0.3) = 1.3498
		#20 start = 1'b0; 

                #1000 x = 16'b0001100110000000;
		#1000 start = 1'b1;                 // exp(0.1) = 1.1051
		#20 start = 1'b0; 

                #1000 x = 16'b1011001100000000;
		#1000 start = 1'b1;                 // exp(0.7) = 2.0137
		#20 start = 1'b0; 



	end
endmodule 
