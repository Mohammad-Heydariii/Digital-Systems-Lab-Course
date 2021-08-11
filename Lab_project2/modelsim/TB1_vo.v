`timescale 1ns/1ns
module senario1_tb();
  
  reg en=0;
  wire 	[7:0] adjusteddiv,final_sett;
  wire  co,co_passed_flipflop,increment,decrement;
  reg 	clk_frequency=1;
  reg 	rst_frequency=1'b1;
  wire 	ring_clk;
  reg 	init=1'b0;
  reg 	[7:0] setperiod=8'b01111101;   //125
  reg 	[7:0] fmin=8'b10100000;    //160
  reg 	[7:0] fmax=8'b01011010;    //90

  ring_oscillator ring(en,ring_clk);    
  frequency_requlator i1(
	co,
	clk_frequency,
	rst_frequency,
        fmax,
	fmin,
	setperiod,
	ring_clk,
	init,
	co_passed_flipflop,
        increment,
	decrement,
        final_sett,
	adjusteddiv);
 	
	
   always begin
   #10 clk_frequency=~clk_frequency;
   end
  
   initial begin
    #50 init=1;
    rst_frequency=0;
	  #500 en=1;
	  
	   #800000 ;
	  $stop;
	  
	  end
endmodule


