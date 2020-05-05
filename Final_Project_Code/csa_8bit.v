module csa_8bit(a,b,cin,sum,cout);
	input [7:0] a,b;
	input cin;
	output [7:0] sum;
	output cout;
	wire c,c1,c2;
	wire [3:0] s1,s2;
	
	csa_4bit adder0(a[3:0],b[3:0],cin,sum[3:0],c);
	
	csa_4bit adder1(a[7:4],b[7:4],1'b0,s1,c1);
	csa_4bit adder2(a[7:4],b[7:4],1'b1,s2,c2);
	
	mux_4bit pick_s(s1,s2,c,sum[7:4]);
	mux_4bit pick_c(c1,c2,c,cout);
endmodule