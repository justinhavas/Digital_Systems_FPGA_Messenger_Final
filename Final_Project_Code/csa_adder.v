module csa_adder(a,b,cin,sum,overflow);
	input [31:0] a,b;
	input cin;
	output [31:0] sum;
	output overflow;
	wire c,c1,c2,cout,c30;
	wire [15:0] s1,s2;
	
	csa_16bit adder0(a[15:0],b[15:0],cin,sum[15:0],c);
	
	csa_16bit adder1(a[31:16],b[31:16],1'b0,s1,c1);
	csa_16bit adder2(a[31:16],b[31:16],1'b1,s2,c2);
	
	mux_16bit pick_s(s1,s2,c,sum[31:16]);
	mux_16bit pick_c(c1,c2,c,cout);
   
	//calc overflow
	xor c_xor(c30,sum[31],a[31],b[31]);
   xor overflow_xor(overflow,c30,cout);
endmodule