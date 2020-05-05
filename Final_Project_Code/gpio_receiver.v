module gpio_receiver(
FPGA_clock,
rx_pins,
text_out,
text_ready_out,
audio_out,
audio_ready_out, should_output, edge_num, rx_valid);

	input FPGA_clock;
	input [17:0] rx_pins;
	output reg [7:0] text_out;
	output reg text_ready_out;
	output reg [31:0] audio_out;
	output reg audio_ready_out;
	
	wire rx_clock;
	assign rx_clock = rx_pins[17];
	output wire rx_valid;
	assign rx_valid = rx_pins[16];
	reg prev_rx_valid;
	
	reg [7:0] text;
	reg text_ready;
	reg [31:0] audio;
	reg audio_ready;
	output reg [31:0] edge_num;
	output reg should_output;
	initial
	begin
		should_output = 1'b0;
		edge_num = 32'hFFFFFFFF;
	end
	always @(posedge rx_clock)
	begin
		if (rx_valid & ~prev_rx_valid)
		begin
			edge_num = 32'd0;
		end
		if (edge_num == 32'd0)
		begin
			should_output = 1'b0;
			text_ready = rx_pins[15];
			audio_ready = rx_pins[14];
			text = rx_pins[7:0];
			edge_num = 32'd1;
		end
		else if (edge_num == 32'd1)
		begin
			audio[31:16] = rx_pins[15:0];
			edge_num = 32'd2;
		end
		else if (edge_num == 32'd2)
		begin
			audio[15:0] = rx_pins[15:0];
			edge_num = 32'd3;
		end
		else if (edge_num == 32'd3)
		begin
			should_output = 1'b1;
			edge_num = 32'd4;
		end
		else
		begin
			should_output = 1'b0;
			edge_num = 32'hFFFFFFFF;
		end
		
		prev_rx_valid = rx_valid;
	end
	
	always @(posedge rx_clock)
	begin
		if (should_output)
		begin
			text_out = text & {8{text_ready}};
			text_ready_out = text_ready;
			audio_out = audio & {32{audio_ready}};
			audio_ready_out = audio_ready;
		end
		else
		begin
			text_out = 8'b0;
			text_ready_out = 1'b0;
			audio_out = 32'b0;
			audio_ready_out = 1'b0;
		end
	end
	
endmodule
