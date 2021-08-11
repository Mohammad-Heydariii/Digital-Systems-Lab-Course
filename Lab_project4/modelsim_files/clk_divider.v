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