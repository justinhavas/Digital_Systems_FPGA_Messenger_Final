module mux_4bit(in1,in2,ctrl,out);
	input [3:0] in1, in2;
	input ctrl;
	output [3:0] out;
	
	assign out = ctrl ? in2 : in1;
endmodule