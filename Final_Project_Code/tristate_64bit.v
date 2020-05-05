module tristate_64bit(in,en,out);
	input en;
	input [63:0] in;
	output [63:0] out;
	
	assign out = en ? in : 63'bz;
	
endmodule