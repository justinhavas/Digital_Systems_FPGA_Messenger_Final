module skeleton(resetn, 
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
	CLOCK_50,
	data_writeReg,
	allAscii,
	q_imem,
	ctrl_writeEnable,
	ctrl_writeReg,
	wren,
	q_dmem,
	redLEDs,
	gpio,
	switches,
	outAscii,
	AUD_ADCDAT,

	// Bidirectionals
	AUD_BCLK,
	AUD_ADCLRCK,
	AUD_DACLRCK,

	I2C_SDAT,

	// Outputs
	AUD_XCK,
	AUD_DACDAT,
	
	I2C_SCLK,
	
	emoji_raw
	);
	
	wire [15:0] ding_audio_output, whoosh_audio_output, emoji_audio_out;
	
	input				CLOCK_50;
		
	wire			 clock;
//	gpio_clock_divider my_clock_divider(CLOCK_50, clock);
	assign clock = CLOCK_50;
	

	input [3:0] emoji_raw; //make this an input, and pin plan it to the GPIO bank
	wire [3:0] emoji_debounced;
	emoji_debouncer my_emoji_debouncer(CLOCK_50, emoji_raw, emoji_debounced);
	input [17:0] switches;
	
	//Audio
	input				AUD_ADCDAT;
	inout				AUD_BCLK;
	inout				AUD_ADCLRCK;
	inout				AUD_DACLRCK;
	inout				I2C_SDAT;
	output				AUD_XCK;
	output				AUD_DACDAT;
	output				I2C_SCLK;
	//Audio
	wire				audio_in_available;
	wire		[31:0]	left_channel_audio_in;
	wire		[31:0]	right_channel_audio_in;
	wire				read_audio_in;

	wire				audio_out_allowed;
	wire		[31:0]	left_channel_audio_out;
	wire		[31:0]	right_channel_audio_out;
	wire				write_audio_out;
	
	wire [31:0] left_in, right_in;
	reg [31:0] left_out, right_out;
	
	output [17:0] redLEDs;
	assign redLEDs[3:0] = emoji_debounced;
	assign redLEDs[7:4] = emoji_raw;
	
	//Begin GPIO
	inout [35:0] gpio;
	wire [17:0] gpio_tx;
	wire [17:0] gpio_rx;
	
	//Board A
	assign gpio[35:18] = gpio_tx;
	assign gpio_rx = gpio[17:0];
	
	//Board B
//	assign gpio[17:0] = gpio_tx;
//	assign gpio_rx = gpio[35:18];

	reg [7:0] text_tx;
	reg text_ready_tx;
	reg [31:0] audio_tx;
	reg audio_ready_tx;
	wire transmitting;
	wire outAscii_ready;
	
	initial
	begin
		text_tx = 8'd0;
		text_ready_tx = 1'b0;
		audio_tx = 32'd0;
		audio_ready_tx = 1'b0;
	end
	reg [31:0] audio_to_transmit;
	gpio_transmitter my_transmitter(
		clock,
		outAscii,
		outAscii_ready,
		audio_to_transmit,
		1'b1,
		gpio_tx,
		transmitting);
	
	wire [7:0] text_rx;
	wire text_ready_rx;
	wire [31:0] audio_rx;
	wire audio_ready_rx;
	wire should_output;
	wire [31:0] edge_num;
	wire rx_valid;
	wire [31:0] audio_received;
	gpio_receiver my_receiver(
		clock,
		gpio_rx,
		text_rx,
		text_ready_rx,
		audio_received,
		audio_ready_rx, should_output, edge_num, rx_valid);
		
	always @(posedge clock)
	begin
		if (audio_ready_rx)
		begin
			left_out = audio_received;
			right_out = audio_received;
		end
		if (audio_in_available)
		begin
			audio_to_transmit = right_channel_audio_in;
		end
	end
	//End GPIO

	wire [3:0] hex_0;
	wire [3:0] hex_1;
	wire [3:0] hex_2;
	wire [3:0] hex_3;
	wire [3:0] hex_4;
	wire [3:0] hex_5;
	wire [3:0] hex_6;
	wire [3:0] hex_7;
	
	// some LEDs that you could use for debugging if you wanted
	output 	[7:0] 	leds, lcd_data;
	assign leds =  {clock, transmitting, outAscii_ready, audio_ready_tx, text_ready_rx, audio_ready_rx, rx_valid, should_output};
	
	//////////////////////// Global  ////////////////////////////
	input 			resetn;
		
	////////////////////////	VGA	////////////////////////////
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[9:0]
	output	[7:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[9:0]
	
	////////////////////////	PS2	////////////////////////////
	inout                   ps2_data_in, ps2_clock;
	wire ps2_data_ready;
	wire reset_ps2, is_enter;
//	assign reset_ps2 = 1'b0; //this is temporary for testing. In the future the processor will assign the value of this wire.
	wire [7:0] ps2_ascii_code; 
	
	////////////////////////	LCD and Seven Segment	////////////////////////////
	output 			   lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon;
	output 	[6:0] 	seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;
	output 	[31:0] 	debug_data_in;
	output   [11:0]   debug_addr;
	
	wire			 lcd_write_en;
	wire 	[31:0] lcd_write_data;	
	
	// clock divider (by 5, i.e., 10 MHz)
	//pll div(CLOCK_50,inclock);
//	assign clock = CLOCK_50;
//	reg [31:0] num_edges;
//	initial
//	begin
//		clock = 1'b0;
//		num_edges = 32'd0;
//	end
//	always @(posedge CLOCK_50)
//	begin
//		if (num_edges >= 10000000)
//		begin
//			clock = ~clock;
//			num_edges = 32'd0;
//		end
//		else
//		begin
//			num_edges = num_edges + 32'd1;
//		end
//	end
	
	// UNCOMMENT FOLLOWING LINE AND COMMENT ABOVE LINE TO RUN AT 50 MHz
	//assign clock = inclock;
	
	// keyboard controller
	wire [31:0]  letter_num, last_letter_num_with_reset;
	ps2_interface_wrapper my_ps2_interface_wrapper(ps2_data_in, ps2_clock, CLOCK_50, reset_ps2|~resetn, ps2_data_ready, ps2_ascii_code, is_enter, ps2_key_pressed, emoji_debounced);

	
	// lcd controller
	lcd mylcd(clock, ~resetn, ps2_data_ready, ps2_ascii_code, lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon);
	
	assign hex_0 = ps2_ascii_code[3:0];
	assign hex_1 = ps2_ascii_code[7:4];
	assign hex_2 = allAscii[17:14];		//text_rx[3:0];           ///allAscii[17:14];
	assign hex_3 = allAscii[21:18];		//text_rx[7:4];             //allAscii[21:18];
	
	assign hex_4 = allAscii[10:7];
	assign hex_5 = {1'b0, allAscii[13:11]};
	assign hex_6 = allAscii[3:0];
	assign hex_7 = {1'b0, allAscii[6:4]};

	// example for sending ps2 data to the first two seven segment displays
	Hexadecimal_To_Seven_Segment hex1(hex_0, seg1);
	Hexadecimal_To_Seven_Segment hex2(hex_1, seg2);
	Hexadecimal_To_Seven_Segment hex3(hex_2, seg3);
	Hexadecimal_To_Seven_Segment hex4(hex_3, seg4);
	Hexadecimal_To_Seven_Segment hex5(hex_4, seg5);
	Hexadecimal_To_Seven_Segment hex6(hex_5, seg6);
	Hexadecimal_To_Seven_Segment hex7(hex_6, seg7);
	Hexadecimal_To_Seven_Segment hex8(hex_7, seg8);
		
	// VGA
	Reset_Delay			r0	(.iCLK(CLOCK_50),.oRESET(DLY_RST)	);
	VGA_Audio_PLL 		p1	(.areset(~DLY_RST),.inclk0(CLOCK_50),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);
	vga_controller vga_ins(.iRST_n(DLY_RST),
								 .iVGA_CLK(VGA_CLK),
								 .cBLANK_n(VGA_BLANK),
								 .cHS(VGA_HS),
								 .cVS(VGA_VS),
								 .b_data(VGA_B),
								 .g_data(VGA_G),
								 .r_data(VGA_R),
								 .FPGA_clock(clock),
								 .ascii_code(allAscii[21:14]),
								 .input_x(allAscii[12:7]),
								 .input_y(allAscii[5:0]));
	
	/** IMEM **/
	// Figure out how to generate a Quartus syncram component and commit the generated verilog file.
	// Make sure you configure it correctly!
	wire [11:0] address_imem;
	output [31:0] q_imem;
	imem my_imem(
		.address    (address_imem),            // address of data
		.clock      (~clock),                  // you may need to invert the clock
		.q          (q_imem)                   // the raw instruction
		);

	/** DMEM **/
	// Figure out how to generate a Quartus syncram component and commit the generated verilog file.
	// Make sure you configure it correctly!
	wire [11:0] address_dmem;
	wire [31:0] data;
	output wren;
	output [31:0] q_dmem;
	dmem my_dmem(
		.address    (address_dmem/* 12-bit wire */),       // address of data
		.clock      (~clock),                  // may need to invert the clock
		.data	    (data/* 32-bit data in */),    // data you want to write
		.wren	    (wren/* 1-bit signal */),      // write enable
		.q          (q_dmem/* 32-bit data out */)    // data from dmem
		);

	/** REGFILE **/
	// Instantiate your regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg; 
	wire [4:0] ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg, allAscii, outAscii;
	wire [31:0] data_readRegA, data_readRegB;

	regfile my_regfile(
		~clock,
		ctrl_writeEnable,
		~resetn,
		ctrl_writeReg,
		ctrl_readRegA,
		ctrl_readRegB,
		data_writeReg,
		data_readRegA,
		data_readRegB
		);

	/** PROCESSOR **/
	processor my_processor(
		// Control signals
		clock,                          // I: The master clock
		~resetn,                          // I: A reset signal

		// Imem
		address_imem,                   // O: The address of the data to get from imem
		q_imem,                         // I: The data from imem

		// Dmem
		address_dmem,                   // O: The address of the data to get or put from/to dmem
		data,                           // O: The data to write to dmem
		wren,                           // O: Write enable for dmem
		q_dmem,                         // I: The data from dmem

		// Regfile
		ctrl_writeEnable,               // O: Write enable for regfile
		ctrl_writeReg,                  // O: Register to write to in regfile
		ctrl_readRegA,                  // O: Register to read from port A of regfile
		ctrl_readRegB,                  // O: Register to read from port B of regfile
		data_writeReg,                  // O: Data to write to for regfile
		data_readRegA,                  // I: Data from port A of regfile
		data_readRegB,                   // I: Data from port B of regfile
		ps2_data_ready,
		is_enter,
		reset_ps2,
		ps2_ascii_code,
		allAscii,
		outAscii,
		transmitting,
		outAscii_ready,
		text_ready_rx,
		text_rx
		);
		
		
		
		
		
		
		
	wire [31:0] mult_amt = 32'd3125;
		
	wire [31:0] ding_to_play, whoosh_to_play, emoji_to_play;
	
	assign ding_to_play = {{16{ding_audio_output[15]}},ding_audio_output}*mult_amt;
	assign whoosh_to_play = {{16{whoosh_audio_output[15]}},whoosh_audio_output}*mult_amt;
	assign emoji_to_play = {{16{emoji_audio_out[15]}},emoji_audio_out}*mult_amt;
	
		
		
	assign left_in = left_channel_audio_in;
	assign right_in = right_channel_audio_in;
	assign left_channel_audio_out	= left_out + ding_to_play + whoosh_to_play + emoji_to_play;
	assign right_channel_audio_out	= right_out + ding_to_play + whoosh_to_play + emoji_to_play;
	
	Audio_Controller Audio_Controller (
		// Inputs
		.CLOCK_50						(CLOCK_50),
		.reset						(~resetn),

		.clear_audio_in_memory		(),
		.read_audio_in				(audio_in_available),

		.clear_audio_out_memory		(),
		.left_channel_audio_out		(left_channel_audio_out + ding_to_play + whoosh_to_play + emoji_to_play),
		.right_channel_audio_out	(right_channel_audio_out + ding_to_play + whoosh_to_play + emoji_to_play),
		.write_audio_out			(audio_out_allowed),

		.AUD_ADCDAT					(AUD_ADCDAT),

		// Bidirectionals
		.AUD_BCLK					(AUD_BCLK),
		.AUD_ADCLRCK				(AUD_ADCLRCK),
		.AUD_DACLRCK				(AUD_DACLRCK),


		// Outputs
		.audio_in_available			(audio_in_available),
		.left_channel_audio_in		(left_channel_audio_in),
		.right_channel_audio_in		(right_channel_audio_in),

		.audio_out_allowed			(audio_out_allowed),

		.AUD_XCK					(AUD_XCK),
		.AUD_DACDAT					(AUD_DACDAT),
		);

	avconf #(.USE_MIC_INPUT(1)) avc (
		.I2C_SCLK					(I2C_SCLK),
		.I2C_SDAT					(I2C_SDAT),
		.CLOCK_50					(CLOCK_50),
		.reset						(~resetn),
		.key1							(1'b1),
		.key2							(1'b1)
		);
		

		receive_sound_controller my_receive_controller(
			CLOCK_50,
			text_rx, 
			text_ready_rx, 
			ding_audio_output);
			
		send_sound_controller my_send_controller(
			CLOCK_50,
			outAscii, 
			outAscii_ready, 
			whoosh_audio_output);
			
		emoji_audio_controller my_emoji_audio_controller(
			CLOCK_50,
			allAscii[21:14],
			emoji_audio_out
			);

endmodule
