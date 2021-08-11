`timescale 1us/1us
module timer_with_delay #(parameter Resistor1=1, parameter Resistor2=50, parameter capacitor=10) (rst, pulse);
    input rst;
    output reg pulse;

        localparam integer onduration = ((Resistor1 + Resistor2) * capacitor * 0.693);
	localparam integer offduration = (Resistor2 * capacitor * 0.693);

    always @(pulse or rst) begin
        if (rst == 1'b1)
            pulse <= 1'b0;
        else begin
            if (pulse == 1'b0)
                #(offduration) pulse <= ~pulse;
            else
                #(onduration) pulse <= ~pulse;
        end
    end
endmodule
