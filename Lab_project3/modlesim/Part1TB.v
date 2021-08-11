`timescale 1ns/1ns

module wave_generatorTB();
  reg clk =0,rst =0;
  wire [7:0]wave ;
  reg [2:0]SW =3'b0;
  
  Waveform_Generator i1(wave, SW, clk, rst);


  always begin
    #10 clk= ~clk;
  end
  
  initial begin
    #5 rst= 1;
    #10 rst= 0;
    #10 SW= 3'b000;
    #150000 SW= 3'b001;
    #150000 SW= 3'b010;
    #150000 SW= 3'b011;
    #150000 SW= 3'b100;
    #150000 SW= 3'b101;
    #150000 SW= 3'b110;
    #150000 SW= 3'b111;
    #150000 $finish;
    
    
  end
  
  
endmodule
