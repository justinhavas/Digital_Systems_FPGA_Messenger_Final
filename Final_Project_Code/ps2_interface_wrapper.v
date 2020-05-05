module ps2_interface_wrapper(ps2_data_in, ps2_clock, fpga_clock, reset, data_ready, output_ascii, is_enter, ps2_key_pressed, emoji);

	output [7:0] output_ascii;

	input [3:0] emoji;
	reg [3:0] previous_emoji;
	reg [7:0] emoji_ascii;
	reg should_output_emoji;

	input fpga_clock; //the 50 MHz clock from the FPGA
	input reset; //if reset is asserted, then that de-asserts data_ready, but does not change ps2_ascii_code
	output reg data_ready; //asserted if a key has been pressed
	wire [7:0] ps2_ascii_code; //contains the ascii code of the key that was just pressed
	
	output is_enter;
	assign is_enter = output_ascii == 8'h0A;
	
	inout ps2_data_in, ps2_clock;
	
	wire [7:0] ps2_raw_code, ps2_prev_raw_code;
	output 			ps2_key_pressed;
	wire 	[7:0] 	ps2_key_data;
	wire 	[7:0] 	last_data_received;
	
	
	assign output_ascii = should_output_emoji ? emoji_ascii : ps2_ascii_code;
	
	
	
	PS2_Interface my_interface(fpga_clock, 1'b1, ps2_clock, ps2_data_in, 
	ps2_key_data, ps2_key_pressed, last_data_received);
	
	reg key_is_pressed_down;
	reg key_has_been_recorded;
	initial
	begin
		key_is_pressed_down = 1'b0;
		key_has_been_recorded = 1'b0;
		should_output_emoji = 1'b0;
	end
	always @(posedge fpga_clock)
	begin
		if (emoji == 4'd0 & previous_emoji != 4'd0)
		begin
			should_output_emoji = 1'b1;
			data_ready = 1'b1;
			
			if (previous_emoji == 4'b0001)
			begin
				emoji_ascii = 8'd128;
			end
			else if (previous_emoji == 4'b0010)
			begin
				emoji_ascii = 8'd129;
			end
			else if (previous_emoji == 4'b0100)
			begin
				emoji_ascii = 8'd130;
			end
			else if (previous_emoji == 4'b1000)
			begin
				emoji_ascii = 8'd131;
			end
			
		end
		else if (~should_output_emoji)
		begin
			key_is_pressed_down = last_data_received != 8'hF0;
			if (key_is_pressed_down & ~key_has_been_recorded)
			begin
				data_ready = 1'b1;
			end
			else if (~key_is_pressed_down)
			begin
				key_has_been_recorded = 1'b0;
				data_ready = 1'b0;
			end
		end
		
		if (reset)
		begin
			key_has_been_recorded = 1'b1;
			data_ready = 1'b0;
			should_output_emoji = 1'b0;
		end		
		previous_emoji = emoji;
	end
	
	ps2_to_ascii my_ps2_to_ascii(ps2_key_data, last_data_received, ps2_ascii_code);

endmodule
