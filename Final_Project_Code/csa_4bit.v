module csa_4bit(a,b,cin,sum,cout);
	input [3:0] a,b;
	input cin;
	output [3:0] sum;
	output cout;
	wire c,c1,c2;
	wire [1:0] s1,s2;
	
	csa_2bit adder0(a[1:0],b[1:0],cin,sum[1:0],c);
	
	csa_2bit adder1(a[3:2],b[3:2],1'b0,s1,c1);
	csa_2bit adder2(a[3:2],b[3:2],1'b1,s2,c2);
	
	mux_2bit pick_s(s1,s2,c,sum[3:2]);
	mux_2bit pick_c(c1,c2,c,cout);
endmodule