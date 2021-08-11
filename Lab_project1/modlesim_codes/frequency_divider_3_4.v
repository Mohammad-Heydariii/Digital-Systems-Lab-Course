`timescale 1ns/1ns
module labb1 (
	output,
	D_MSE,
	C_MSE,
	B_MSB,
	A_MSB,
	D_LSB,
	C_LSB,
	B_LSB,
	A_LSB,
	clk,
	init);

 reg  clk,A_LSB,B_LSB,C_LSB,D_LSB,A_MSB,B_MSB,C_MSB,D_MSB,init;
 wire output;




  
labb1 t1 (output,D_MSE,C_MSE,B_MSE,A_MSE,D_LSB,C_LSB,B_LSB,A_LSB,clk,init); 
  
  initial begin
 
A_LSB=1;
B_LSB=1;
C_LSB=1;
D_LSB=1;
A_MSB=0;
B_MSB=0;
C_MSB=0;
D_MSB=1;

    int = 1'b0;
    
    #13 init = 1'b0;
    
    

    #1000 $finish;
  end
always
  begin
    #10 clk = ~clk;
  end

  
  
endmodule
