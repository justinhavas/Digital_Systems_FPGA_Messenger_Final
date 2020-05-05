module mux_2bit(in1,in2,ctrl,out);
	input [1:0] in1, in2;
	input ctrl;
	output [1:0] out;
	
	assign out = ctrl ? in2 : in1;
endmodule