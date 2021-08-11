// Shifter 
module Shifter(input [15:0]inwave,input [2:0]n,output reg [15:0]outwave);
	always@(n,inwave) begin
	if (n== 3'b000) 
		outwave <= inwave;
	else if (n== 3'b001)
		outwave <= inwave>>1;
	else if (n== 3'b010)
		outwave <= inwave>>2;
	else if (n== 3'b011)
		outwave <= inwave>>3;
	else if (n== 3'b100)
		outwave <= inwave>>4;
	else if (n== 3'b101)
		outwave <= inwave>>5;
        else if (n== 3'b110)
		outwave <= inwave>>6;
        else if (n== 3'b111)
		outwave <= inwave>>7;
	end
	
endmodule


