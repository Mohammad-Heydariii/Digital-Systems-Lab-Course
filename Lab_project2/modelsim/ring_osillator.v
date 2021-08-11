`timescale 1ps/1ps

module ring_oscillator #( parameter n=5,  parameter delay=1800)(input init, output pulse); 

wire [n:0]data;

genvar i;
generate
for(i=0; i<n;i=i+1) begin
not #(delay) ni(data[i+1],data[i]);                                          
end
endgenerate   
                       
assign data[0] = init?0:data[n];
 assign pulse = init?0:data[n];
                    
endmodule                      


