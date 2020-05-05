module emoji_debouncer(FPGA_clock, emoji_in, emoji_out);
	input FPGA_clock;
	input [3:0] emoji_in;
	output reg [3:0] emoji_out;
	
	reg debounce_clock;
	
	reg [31:0] num_clock_edges;
	initial
	begin
		debounce_clock = 1'b0;
		num_clock_edges = 32'd0;
	end
	
	always @(posedge FPGA_clock)
	begin
		if (num_clock_edges >= 32'd500000) //divide the clock to be 100 Hz in order to handle contact bounce
		begin
			debounce_clock = ~debounce_clock;
			num_clock_edges = 32'd0;
		end
		else
		begin
			num_clock_edges = num_clock_edges + 32'd1;
		end
	end
	
	always @(posedge debounce_clock)
	begin
		emoji_out = emoji_in;
	end

endmodule
