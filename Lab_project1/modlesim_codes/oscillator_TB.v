`timescale 1 ns / 1 ns
module ring_oscillator_test();
    reg init;
    wire pulse;
 
   ring_oscillator #(5,1.8) r1(init, pulse);
 
    initial begin
        init = 1'b1;
        #90 init = 1'b0;
    end

    initial begin
        #500 $stop;
    end
endmodule
