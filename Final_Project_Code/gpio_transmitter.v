module gpio_transmitter(
FPGA_clock,
text_in,
text_ready_in,
audio_in,
audio_ready_in,
tx_pins,
transmitting);
	input FPGA_clock;
	input [7:0] text_in;
	input text_ready_in;
	input [31:0] audio_in;
	input audio_ready_in;
	output reg [17:0] tx_pins;
	output transmitting;
	assign transmitting = tx_pins[16];
	
	wire gpio_clock;
	gpio_clock_divider my_clock_divider(FPGA_clock, gpio_clock);
	
	reg [7:0] text;
	reg text_ready;
	reg [31:0] audio;
	reg audio_ready;
	always @(gpio_clock)
	begin
		tx_pins[17] = gpio_clock;
	end
	
	reg [31:0] edge_num;
	initial
	begin
		edge_num = 32'hFFFFFFFF;
	end
	always @(posedge gpio_clock)
	begin
		
		if (edge_num == 32'hFFFFFFFF)
		begin
			text = text_in;
			text_ready = text_ready_in;
			audio = audio_in;
			audio_ready = audio_ready_in;
			if (text_ready | audio_ready)
			begin
				edge_num = 32'd0;
			end
		end
				
		if (edge_num == 32'd0)
		begin
			tx_pins[16] = 1'b1;
			tx_pins[15:14] = {text_ready, audio_ready};
			tx_pins[7:0] = text;
			edge_num = 32'd1;
		end
		else if (edge_num == 32'd1)
		begin
			tx_pins[15:0] = audio[31:16];
			edge_num = 32'd2;
		end
		else if (edge_num == 32'd2)
		begin
			tx_pins[15:0] = audio[15:0];
			edge_num = 32'd3;
		end
		else
		begin
			tx_pins[16] = 1'b0;
			edge_num = 32'hFFFFFFFF;
		end
	end
	
endmodule
