module tristate_5bit(in,en,out);
	input en;
	input [4:0] in;
	output [4:0] out;
	
	assign out = en ? in : 5'bz;

endmodule