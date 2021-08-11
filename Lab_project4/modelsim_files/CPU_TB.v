`timescale 1ps/ 1ps
module CPU();


reg Ref_Clk=0,rst=1,adjust=0,inFreq=0;
reg [2:0]n= 3'b011; // n=3
reg start_acc=0;
reg [15:0] x=0;
wire[15:0] fracpart;
wire[1:0] intpart;
wire done_expo;
wire done_multiplier;



Integrated_Circuit i1(
done_multiplier,
adjust,
Ref_Clk,
rst,
inFreq,
n,
done_expo,
start_acc,
x,
fracpart,
intpart);


initial #30000 rst = 1'b0;

always #3333 Ref_Clk=~Ref_Clk; // 150Mhz frequency

always #50000 inFreq = ~inFreq; //10Mhz frequency Freq


initial begin
#40000 adjust = 1'b1; // start becomes one

#10000 adjust = 1'b0; // start becomes ziro


repeat (20) begin
#10000 if(done_multiplier == 1)begin
start_acc=1;
end

end



#100000 start_acc=0;
#10000000;
$stop;

end

endmodule
