module sign_extend(in,out);
	input [16:0] in;
	output [31:0] out;
	
	wire type0;
	
	assign out[16:0] = in;
	or or0(type0,in[16],1'b0);
	
	assign out[31] = type0;
	assign out[30] = type0;
	assign out[29] = type0;
	assign out[28] = type0;
	assign out[27] = type0;
	assign out[26] = type0;
	assign out[25] = type0;
	assign out[24] = type0;
	assign out[23] = type0;
	assign out[22] = type0;
	assign out[21] = type0;
	assign out[20] = type0;
	assign out[19] = type0;
	assign out[18] = type0;
	assign out[17] = type0;
endmodule