module full_adder(a,b,cin,sum,cout);
	input a,b,cin;
	output sum,cout;
	wire w1,w2,w3;
	
	xor sum_xor(sum,a,b,cin);
	and and1(w1,a,b);
	or or1(w2,a,b);
	and and3(w3,w2,cin);
	or or2(cout,w3,w1);
endmodule