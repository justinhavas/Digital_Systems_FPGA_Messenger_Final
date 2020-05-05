`timescale 1 ns / 100 ps
module skeleton_tb();
	reg clock;
	wire resetn;
	assign resetn = 1'b1;
	
	wire			VGA_CLK;   				//	VGA Clock
	wire			VGA_HS;					//	VGA H_SYNC
	wire			VGA_VS;					//	VGA V_SYNC
	wire			VGA_BLANK;				//	VGA BLANK
	wire			VGA_SYNC;				//	VGA SYNC
	wire	[7:0]	VGA_R;   				//	VGA Red[9:0]
	wire	[7:0]	VGA_G;	 				//	VGA Green[9:0]
	wire	[7:0]	VGA_B;   				//	VGA Blue[9:0]
	wire				CLOCK_50;
	wire                   ps2_data_in, ps2_clock;
	wire reset_ps2, ps2_data_ready, is_enter;
	wire [7:0] ps2_ascii_code, ps2_raw_data, ps2_prev_raw_data;
	wire 			   lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon;
	wire 	[7:0] 	leds, lcd_data;
	wire 	[6:0] 	seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;
	wire 	[31:0] 	debug_data_in;
	wire   [11:0]   debug_addr;
	
	wire [35:0] gpio;
	
	assign CLOCK_50 = clock;
	
	skeleton my_skeleton(resetn, 
	ps2_clock, ps2_data_in, 										// ps2 related I/O
	debug_data_in, debug_addr, leds, 						// extra debugging ports
	lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon,// LCD info
	seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8,		// seven segements
	VGA_CLK,   														//	VGA Clock
	VGA_HS,															//	VGA H_SYNC
	VGA_VS,															//	VGA V_SYNC
	VGA_BLANK,														//	VGA BLANK
	VGA_SYNC,														//	VGA SYNC
	VGA_R,   														//	VGA Red[9:0]
	VGA_G,	 														//	VGA Green[9:0]
	VGA_B,															//	VGA Blue[9:0]
	CLOCK_50,	  													// 50 MHz clock
	gpio);
	
	integer i;
	initial
	begin
		clock = 1'b0;
		for (i = 0; i < 30; i=i+1)
		begin
			@(posedge clock);
		end
		$stop;
	end
	
	always
	begin
		#10
		clock = ~clock;
	end
	
endmodule
