module tristate(in,en,out);
	input en;
	input [31:0] in;
	output [31:0] out;
	
	assign out = en ? in : 32'bz;
	
endmodule