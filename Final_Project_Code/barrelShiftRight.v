module barrelShiftRight(in,amt,out);
	input [31:0] in;
	input [4:0] amt;
	output [31:0] out;
	wire [31:0] shift16,shift15,shift8,shift4,shift2,shift1;
	wire [31:0] out16,out8,out4,out2;
	
	shiftRight shifting15(in,4'b1111,shift15);
	shiftRight shifting16(shift15,4'b0001,shift16);
	mux_32bit mux16(in,shift16,amt[4],out16);
	
	shiftRight shifting8(out16,4'b1000,shift8);
	mux_32bit mux8(out16,shift8,amt[3],out8);
	
	shiftRight shifting4(out8,4'b0100,shift4);
	mux_32bit mux4(out8,shift4,amt[2],out4);
	
	shiftRight shifting2(out4,4'b0010,shift2);
	mux_32bit mux2(out4,shift2,amt[1],out2);
	
	shiftRight shifting1(out2,4'b0001,shift1);
	mux_32bit mux1(out2,shift1,amt[0],out);
endmodule