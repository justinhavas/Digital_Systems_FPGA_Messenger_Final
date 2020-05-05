module clock_divider_general(
input CLOCK_50, 
input [31:0] desired_freq, 
output reg clock_out);

	reg [31:0] num_clock_edges;
	initial
	begin
		clock_out = 1'b0;
		num_clock_edges = 32'd0;
	end
	
	always @(posedge CLOCK_50)
	begin
		if (num_clock_edges >= (32'd50000000/desired_freq))
		begin
			clock_out = ~clock_out;
			num_clock_edges = 32'd0;
		end
		else
		begin
			num_clock_edges = num_clock_edges + 32'd1;
		end
	end

endmodule
