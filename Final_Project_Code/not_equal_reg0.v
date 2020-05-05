module not_equal_reg0(in,out);
	input [4:0] in;
	output out;
	
	wire w1,w2,w3,w4,w5;
	
	nor nor0(w1,in[4],1'b0);
	nor nor1(w2,in[3],1'b0);
	nor nor2(w3,in[2],1'b0);
	nor nor3(w4,in[1],1'b0);
	nor nor4(w5,in[0],1'b0);
	
	nand nand0(out,w1,w2,w3,w4,w5);
endmodule	