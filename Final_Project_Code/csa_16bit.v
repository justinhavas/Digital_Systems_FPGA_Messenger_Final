module csa_16bit(a,b,cin,sum,cout);
	input [15:0] a,b;
	input cin;
	output [15:0] sum;
	output cout;
	wire c,c1,c2;
	wire [7:0] s1,s2;
	
	csa_8bit adder0(a[7:0],b[7:0],cin,sum[7:0],c);
	
	csa_8bit adder1(a[15:8],b[15:8],1'b0,s1,c1);
	csa_8bit adder2(a[15:8],b[15:8],1'b1,s2,c2);
	
	mux_8bit pick_s(s1,s2,c,sum[15:8]);
	mux_8bit pick_c(c1,c2,c,cout);
endmodule