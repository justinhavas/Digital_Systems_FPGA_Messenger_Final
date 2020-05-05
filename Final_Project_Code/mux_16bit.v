module mux_16bit(in1,in2,ctrl,out);
	input [15:0] in1, in2;
	input ctrl;
	output [15:0] out;
	
	assign out = ctrl ? in2 : in1;
endmodule