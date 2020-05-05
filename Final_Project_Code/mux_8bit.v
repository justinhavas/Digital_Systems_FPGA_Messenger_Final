module mux_8bit(in1,in2,ctrl,out);
	input [7:0] in1, in2;
	input ctrl;
	output [7:0] out;
	
	assign out = ctrl ? in2 : in1;
endmodule