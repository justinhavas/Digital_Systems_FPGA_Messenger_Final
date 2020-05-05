module csa_2bit(a,b,cin,sum,cout);
	input [1:0] a,b;
	input cin;
	output [1:0] sum;
	output cout;
	wire c,c1,c2,s1,s2;
	
	full_adder adder0(a[0],b[0],cin,sum[0],c);
	
	full_adder adder1(a[1],b[1],1'b0,s1,c1);
	full_adder adder2(a[1],b[1],1'b1,s2,c2);
	
	mux_1bit pick_s(s1,s2,c,sum[1]);
	mux_1bit pick_c(c1,c2,c,cout);
endmodule