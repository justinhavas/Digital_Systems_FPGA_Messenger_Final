module send_sound_controller(
input FPGA_clock,
input [31:0] outAscii, 
input outAscii_ready, 
output [15:0] whoosh_audio_output);


	reg audio_clock;
	reg [11:0]  address;
	wire start = outAscii_ready & outAscii[7:0] == 8'h0A;
	reg prev_start;
	
	reg [31:0] num_clock_edges;
	initial
	begin
		audio_clock = 1'b0;
		num_clock_edges = 32'd0;
		address = 12'd0;
		prev_start = 1'b1;
	end
	
	always @(posedge FPGA_clock)
	begin
		if (num_clock_edges >= 32'd4535)
		begin
			audio_clock = ~audio_clock;
			num_clock_edges = 32'd0;
		end
		else
		begin
			num_clock_edges = num_clock_edges + 32'd1;
		end
	end
	
	always @(posedge audio_clock)
	begin
		if (start & ~prev_start) //this is our signal to start playing the sound
		begin
			address = 12'd0;
		end
		else
		begin
			if (address != 12'hFFF)
			begin
				address = address + 12'd1;
			end
		end
		
		prev_start = start;
	end
	
	send_dmem my_dmem(
		address,
		audio_clock,
		whoosh_audio_output);
endmodule
