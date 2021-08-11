`timescale 1ns/1ns
module wave_generator(input clk,rst,input[7:0]wavecnt,input [2:0]selector,output reg[7:0] wave);
  
  wire [7:0]Rhomboid;
  wire [7:0]Sine;
  wire [7:0]Squarewave;
  wire [7:0]Reciprocal;
  wire [7:0]Sawtooth;
  wire [7:0]FullwaveRectified;
  wire [7:0]ModulatedSquarewave;
  
  
  Squarewave i2(wavecnt,Squarewave);
  FullwaveRectified i4(clk,rst,wavecnt,FullwaveRectified);
  Rhomboid i1(wavecnt,wavecnt[4],Rhomboid);
  Sine i5( clk, rst, wavecnt, Sine);
  Sawtooth i6( wavecnt, Sawtooth);
  ModulatedSquarewave i7(clk,rst,wavecnt,ModulatedSquarewave);
  Reciprocal i3(wavecnt,Reciprocal);
  
 always@(posedge clk) begin
	case(selector)
		3'b000: wave <= Rhomboid;
      3'b001: wave <= Sine;
      3'b010: wave <= Squarewave;
      3'b011: wave <= Reciprocal;
      3'b100: wave <= Sawtooth;
      3'b101: wave <= FullwaveRectified;
      3'b110: wave <= ModulatedSquarewave; 
      //3'b111: waveform <= doesnt make any changes;
		default: wave<= 8'b0;
	endcase
	end

       
endmodule