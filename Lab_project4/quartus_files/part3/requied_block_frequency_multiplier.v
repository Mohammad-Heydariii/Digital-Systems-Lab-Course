//divider 

// calculating 150/f
module Divider(input InFreq,RefClk,rst,output reg [15:0]duration , output reg complete=0);
  
	reg oldInFreq;
	
	always @(posedge RefClk,posedge rst) begin  //sequential part for generating the PSI signal
	 if (rst) begin 
	    // complete <= 1'b0;
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
	  	  //complete <= 1'b0; //resets at the rising edge
	  	  end
	  	  2'b11:begin 
	  	  duration <=duration +1;
	  	  //complete <= 1'b0; //counts up
	  	  end 
		  2'b10:begin 
		  duration <=duration; //stops counting
		  //complete <=1'b1;
		  end
		  2'b00:begin 
		  duration <=duration; //doesn't count
		  if(duration > 16'b0) complete <= 1'b1;
		  end
		  endcase
	 end
	end
endmodule


// shifter

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

//clk_dvider

module clk_div
#(
parameter WIDTH = 8 // Width of the register required
)
(RefClk,reset, preload_clk_divider ,N,OutFreq);

input preload_clk_divider;
input RefClk;
input reset;
input[7:0]N;
output OutFreq;

reg [7:0]Nreg;
reg [WIDTH-1:0] r_reg;
wire [WIDTH-1:0] r_nxt;
reg clk_track;

always @(posedge RefClk or posedge reset)

begin
  if(preload_clk_divider==1)
  begin
    Nreg<=N;
  end
if (reset)
begin
  Nreg <= 0;
r_reg <= 0;
clk_track <= 1'b0;
end
else if (r_nxt == Nreg)
begin
r_reg <= 0;
clk_track <= ~clk_track;
end

else
r_reg <= r_nxt;
end

assign r_nxt = r_reg+1;
assign OutFreq = clk_track;
endmodule

//DP

module FreqMultDP(input RefClk,rst,InFreq,init_ratio,InFreq_status,shift,preload_clk_divider,input[2:0]n,output OutFreq,output[15:0]shiftduration , output completed);
  wire [15:0]duration;
  
  Divider div(InFreq,RefClk,rst,duration, completed );
  Shifter shifting(duration,n-1,shiftduration);
  clk_div t1(RefClk,rst,preload_clk_divider,{1'b0,shiftduration[15:1]},OutFreq);
  
endmodule

//CU 

// Control unit for frequency multiplier

module FreqMultCU(input rst,RefClk,adjust,completed,output reg done,init_ratio,InFreq_status,shift,preload_clk_divider);

	reg [2:0] ps, ns;

	parameter [2:0]
	Idle = 0, Wait= 1, Ignore=2,RatioCalc=3,Shift=4;
        
        reg [2:0]cnt;
        reg In0C,Upc;
        wire CCO;



        always@(posedge RefClk,posedge rst)begin
          if(rst) cnt<=3'b0;
          else if(In0C)cnt<=3'b000;
          else if(Upc) cnt<=cnt+1;
          else cnt<=cnt;
        end
         assign CCO=&cnt;
  
	always@(ps,adjust,CCO)begin
		ns = Idle;
		case(ps)
			Idle:
				ns = (adjust)? Wait : Idle;
			Wait:
				ns = (adjust)? Wait : Ignore;
			
                        Ignore:
				ns =(completed)?RatioCalc:Ignore;
			
                        RatioCalc:
				ns =(CCO)?RatioCalc:Shift;
			
                        Shift:
				ns =(CCO)?Idle:Shift; 
                       
		endcase
	end

	always@(ps,adjust,completed)begin

	{done,init_ratio,InFreq_status,shift,preload_clk_divider,In0C,Upc}= 7'b0;

		case(ps)
			Idle: begin
			{done }=1'b1;
			 preload_clk_divider =((completed==1'b0) ? 1'b0:1'b1);
			end

			Wait: {In0C}=1'b1;
                        Ignore: {Upc}=1'b1;
			
                        RatioCalc: {Upc,In0C}=2'b11;
                        
                        Shift: {Upc} = 1'b1;
				
                                   
		endcase
	end

	always@(posedge RefClk,posedge rst)begin
		if(rst == 1'b1)
			ps <= Idle;
		else
			ps <= ns;
	end

endmodule



