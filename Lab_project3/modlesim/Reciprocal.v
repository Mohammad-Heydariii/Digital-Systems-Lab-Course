`timescale 1ns/1ns
module Reciprocal(input [7:0]cout,output reg[7:0]wave);
	always@(cout) begin
	wave <= (8'd255)/(8'd255 - cout); 
	end
	
endmodule