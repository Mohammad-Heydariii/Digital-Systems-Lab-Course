`timescale 1ns/1ns
module freqregulator(input clk,rst,psi,input[7:0]setperiod,output reg[7:0]adjusteddiv);
  
  reg[7:0] duration; 
  reg oldpsi;
  reg inc_flag,dec_flag;
  reg done_flag;
  reg[7:0]adjusteddiv_reg;
  

  always @(posedge clk, posedge rst) begin
      if (rst) 
        oldpsi <= 1'b0;
      else 
	    oldpsi <= psi;
	  end
	  
	  

  always @(posedge clk , posedge rst) begin  
    if (rst) begin
        duration<=8'b0;
      end
      else begin
          case ({oldpsi,psi})
          2'b00: duration <= duration;
          2'b01: duration <= 8'b00000001;
          2'b10: duration <= duration;
          2'b11: duration <= duration+1;
          endcase
      end
  end
  
  always @(psi,duration) begin 
    inc_flag=1'b0;dec_flag=1'b0;
   
    
    if ({oldpsi,psi}==2'b10) begin
      
      if(duration > setperiod)
        inc_flag<=1'b1;
        
        else if(duration < setperiod)
          dec_flag<=1'b1;
          
    end
  end
  
  
  //always @(posedge clk , posedge rst) begin 
//    if(rst)
//      adjusteddiv<=8'b01111111;
//     else if ({oldpsi,psi}==2'b10) begin
//      if(inc_flag==1) adjusteddiv<=(adjusteddiv+1'b1);
//      else if (dec_flag==1) adjusteddiv<=(adjusteddiv-1'b1);
//    end
//  end
//  
  
  
  always @(posedge clk , posedge rst) begin 
    if(rst)begin
		adjusteddiv<=8'b01111111;
      adjusteddiv_reg<=8'b01111111;end
    else if ({oldpsi,psi}==2'b10) begin
      if(inc_flag==1)  begin adjusteddiv_reg<=adjusteddiv_reg+1;end
      else if (dec_flag==1) begin adjusteddiv_reg<=adjusteddiv_reg-1;end
    end
	 else adjusteddiv<=adjusteddiv_reg;
  end
  
  
endmodule
