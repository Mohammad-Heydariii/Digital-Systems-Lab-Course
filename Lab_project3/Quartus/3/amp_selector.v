`timescale 1ns/1ns

module amp_selector(input [7:0]input_wave,input [1:0]div,output reg [7:0]output_wave);
	always@(div) begin
	if (div== 2'b00) 
		output_wave <= input_wave;
	else if (div== 2'b01)
		output_wave <= input_wave>>>1;
	else if (div== 2'b10)
		output_wave <= input_wave>>>2;
	else if (div== 2'b11)
	output_wave <= input_wave>>>3;
	end
	
endmodule
