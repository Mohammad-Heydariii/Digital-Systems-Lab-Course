`timescale 1ns/1ns
module  pre_processing (input[7:0]setperiod,fmax,fmin,output reg[7:0]final_set);
  
 
 
  always @(fmin,fmax) begin

    if (fmax>setperiod) begin
        final_set <= fmax;
end
    if(fmax<setperiod<fmin) begin
        final_set <= setperiod;
end
    if(fmin<setperiod) begin
        final_set <= fmin;
end
	  
	  
	  
 end
  

 
endmodule