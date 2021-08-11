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




