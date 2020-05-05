module gpio_clock_divider(FPGA_clock, gpio_clock);
	input FPGA_clock;
	output reg gpio_clock;
	
	reg [31:0] num_clock_edges;
	initial
	begin
		gpio_clock = 1'b0;
		num_clock_edges = 32'd0;
	end
	
	always @(posedge FPGA_clock)
	begin
		if (num_clock_edges >= 32'd5000)
		begin
			gpio_clock = ~gpio_clock;
			num_clock_edges = 32'd0;
		end
		else
		begin
			num_clock_edges = num_clock_edges + 32'd1;
		end
	end

//	output gpio_clock;
//	assign gpio_clock = FPGA_clock;
	
endmodule
