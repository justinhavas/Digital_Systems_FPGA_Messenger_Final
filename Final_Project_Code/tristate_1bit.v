module tristate_1bit(in,en,out);
	input en;
	input in;
	output out;
	
	assign out = en ? in : 1'bz;
	
endmodule