// calculating 150/f
module Divider(input InFreq,RefClk,rst,output reg [15:0]duration , output reg complete);
  
	reg oldInFreq;
	
	always @(posedge RefClk,posedge rst) begin  //sequential part for generating the PSI signal
	 if (rst) begin 
	     complete <= 1'b0;
		  oldInFreq <=1'b0;
		  end
	 else
	   	oldInFreq <=InFreq;	
	end

	always @(posedge RefClk , posedge rst) begin : decide_when_to_count_and_count
	if (rst)
		duration <=16'b0;
	 else begin
		  case ({oldInFreq,InFreq}) //like the previous Lab
	  	  2'b01:begin 
	  	  duration <= 16'b0;
	  	  complete = 1'b0; //resets at the rising edge
	  	  end
	  	  2'b11:begin 
	  	  duration <=duration +1;
	  	  complete = 1'b0; //counts up
	  	  end 
		  2'b10:begin 
		  duration <=duration; //stops counting
		  complete =1'b1;
		  end
		  2'b00:begin 
		  duration <=duration; //doesn't count
		  if(duration > 16'b0) complete = 1'b1;
		  end
		  endcase
	 end
	end
endmodule

