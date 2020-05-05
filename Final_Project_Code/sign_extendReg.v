module sign_extendReg(in,out);
	input [4:0] in;
	output [31:0] out;
	
	wire type0;
	
	assign out[4:0] = in;
	or or0(type0,in[4],1'b0);
	
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
	assign out[16] = type0;
	assign out[15] = type0;
	assign out[14] = type0;
	assign out[13] = type0;
	assign out[12] = type0;
	assign out[11] = type0;
	assign out[10] = type0;
	assign out[9] = type0;
	assign out[8] = type0;
	assign out[7] = type0;
	assign out[6] = type0;
	assign out[5] = type0;
endmodule