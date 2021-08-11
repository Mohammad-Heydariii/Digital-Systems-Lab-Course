module datapath(input clk,rst, zx,initx,ldx, zt,initt,ldt, zr,initr,ldr, zc,ldc,enc, s,
		 input [15:0] x, output co,output logic[17:0]result);
	wire [15:0] xptwo;
	wire [2:0] c_in = 0;
	wire [15:0] data,m_out,temp_in,ymux;
	logic [15:0] xptwor,temp_out,xr;
	wire [17:0] res_in;
	wire [3:0] adr;

	register regx(clk,rst,zx,initx,ldx,x,xr);

	counter count(clk,rst,zc,ldc,enc,c_in,adr,co);

	LUT lut(adr,data);
	
	mux2to1 mux(xr,data,s,m_out);

	multiplier mult(m_out,temp_out,temp_in);

	register rtemp(clk,rst,zt,initt,ldt,temp_in,temp_out);
	adder add(result,{2'b00,temp_out},res_in);
	
	register18 rres(clk,rst,zr,initr,ldr,res_in,result);
endmodule



module controller(input clk,rst,start,co,
		    output logic done, zx,initx,ldx, zt,initt,ldt, zr,initr,ldr, zc,ldc,enc, s);

	reg [2:0] ps, ns;
	parameter [2:0]
	Idle = 0, Initialization = 1, Begin = 2, Mult1 = 3, Mult2 = 4, Add=5;
	always@(ps,co,start)begin
		ns = Idle;
		case(ps)
			Idle:
				ns = (start)? Initialization : Idle;
			Initialization:
				ns = (start)? Initialization : Begin;
			Begin:
				ns = Mult1;
			Mult1:
				ns = Mult2;
			Mult2:
				ns = Add;
			Add:
				ns = (co)? Idle : Mult1;
		endcase
	end

	always@(ps,co,start)begin
	done = 1'b0; zx = 1'b0; initx = 1'b0; ldx = 1'b0; zt = 1'b0; initt = 1'b0; ldt = 1'b0; 
	zr = 1'b0; initr = 1'b0; ldr = 1'b0;  zc = 1'b0; ldc = 1'b0; enc = 1'b0; s = 1'b0;
		case(ps)
			Idle:begin
				zx = 1'b1;
				zt = 1'b1;
				//zr = 1'b1;
				zc = 1'b1;
				done = 1'b1;
			end
			Initialization: begin
				ldx = 1'b1;
			end
			Begin:begin
				initr = 1'b1;
				initt = 1'b1;
			end
			Mult1:begin
				s = 1'b0;
				ldt = 1'b1;
			end
			Mult2:begin
				s = 1'b1;
				ldt = 1'b1;
			end
			Add:begin
				enc =1'b1;
				ldr = 1'b1;
			end
		endcase
	end

	always@(posedge clk,posedge rst)begin
		if(rst == 1'b1)
			ps <= Idle;
		else
			ps <= ns;
	end
endmodule


module exponential(input clk,rst,start, input [15:0] x, 
		   output done, output[1:0] intpart, output [15:0]fracpart);
	
	wire co,zx,initx,ldx,zt,initt,ldt,zr,initr,ldr,zc,ldc,enc,s;
	
	controller control(clk,rst,start,co,done, zx,initx,ldx, 
			  zt,initt,ldt, zr,initr,ldr, zc,ldc,enc, s);

	datapath dP(clk,rst, zx,initx,ldx, zt,initt,ldt,
		    zr,initr,ldr, zc,ldc,enc, s,x,co,{intpart,fracpart});

endmodule



