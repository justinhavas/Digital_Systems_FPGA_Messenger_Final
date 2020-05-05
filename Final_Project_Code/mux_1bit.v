module mux_1bit(in1,in2,ctrl,out);
	input in1, in2;
	input ctrl;
	output out;
	
	assign out = ctrl ? in2 : in1;
endmodule