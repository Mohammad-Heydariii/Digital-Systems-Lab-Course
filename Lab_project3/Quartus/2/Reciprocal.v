// Reciprocal
`timescale 1ns/1ns
module Reciprocal(input [7:0]cout,output reg[7:0]wave);
// this must be the 1/x function
	always@(cout) begin
		wave <= (8'd255)/(8'd255 - cout); // inverting the down counter output
	end
	
endmodule