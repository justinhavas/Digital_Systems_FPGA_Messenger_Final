module shiftRight(in,amt,out);
    input [31:0] in;
    input [3:0] amt;
    output [31:0] out;
	 
	 assign out = $signed(in) >>> amt;
endmodule