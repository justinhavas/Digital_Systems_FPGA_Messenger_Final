module mux_32bit(in1,in2,ctrl,out);
	input [31:0] in1, in2;
	input ctrl;
	output [31:0] out;
	
	assign out = ctrl ? in2 : in1;
endmodule