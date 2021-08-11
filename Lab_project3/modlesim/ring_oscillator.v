`timescale 1ps/1ps

module ring_oscillator#(
                        parameter NO_STAGES=5,      // No of inverter stage
                        parameter INV_DELAY_ns=4000      // Delay of single inverter in ns

                        )(
                            input  en,
                            output  clk_o
                        );    
    
    wire [NO_STAGES:0] wi;
    assign wi[0] = en ? wi[NO_STAGES] : 0;
    assign clk_o = en ? wi[NO_STAGES] : 0;
    genvar i;
    generate
        for(i = 0; i < NO_STAGES; i = i+1) begin
            if(i==0) begin
                    not #(INV_DELAY_ns) (wi[i+1], wi[0]);   
            end
           
            else begin
                    not #(INV_DELAY_ns) (wi[i+1], wi[i]);
            end
        end
    endgenerate   
    
endmodule                      