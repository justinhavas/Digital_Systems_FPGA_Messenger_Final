module rgb_calc(
input [18:0] ADDR,
input VGA_clock,
input is_in_grid, 
input [7:0] ascii_code_to_display, 
input [3:0] pixel_x, 
input [3:0] pixel_y, 
output [7:0] r_data, 
output [7:0] g_data, 
output [7:0] b_data);

wire [18:0] address;
assign address = (pixel_y*4'd10) + pixel_x;
wire clock;
wire [7:0] q;

wire [7:0] index_letter_a;
wire [7:0] index_letter_b;
wire [7:0] index_letter_c;
wire [7:0] index_letter_d;
wire [7:0] index_letter_e;
wire [7:0] index_letter_f;
wire [7:0] index_letter_g;
wire [7:0] index_letter_h;
wire [7:0] index_letter_i;
wire [7:0] index_letter_j;
wire [7:0] index_letter_k;
wire [7:0] index_letter_l;
wire [7:0] index_letter_m;
wire [7:0] index_letter_n;
wire [7:0] index_letter_o;
wire [7:0] index_letter_p;
wire [7:0] index_letter_q;
wire [7:0] index_letter_r;
wire [7:0] index_letter_s;
wire [7:0] index_letter_t;
wire [7:0] index_letter_u;
wire [7:0] index_letter_v;
wire [7:0] index_letter_w;
wire [7:0] index_letter_x;
wire [7:0] index_letter_y;
wire [7:0] index_letter_z;
wire [7:0] index_letter_period;
wire [7:0] index_letter_plus;
wire [7:0] index_letter_question;
wire [7:0] index_letter_quote;
wire [7:0] index_letter_semicolon;
wire [7:0] index_letter_slash;
wire [7:0] index_letter_comma;
wire [7:0] index_letter_dash;
wire [7:0] index_letter_exclamation;
wire [7:0] index_letter_2;
wire [7:0] index_letter_3;
wire [7:0] index_letter_4;
wire [7:0] index_letter_5;
wire [7:0] index_letter_6;
wire [7:0] index_letter_7;
wire [7:0] index_letter_8;
wire [7:0] index_letter_9;
wire [7:0] index_letter_heart;
wire [7:0] index_letter_crying;
wire [7:0] index_letter_laughing;
wire [7:0] index_letter_kiss;

wire [23:0] data_letter_a;
wire [23:0] data_letter_b;
wire [23:0] data_letter_c;
wire [23:0] data_letter_d;
wire [23:0] data_letter_e;
wire [23:0] data_letter_f;
wire [23:0] data_letter_g;
wire [23:0] data_letter_h;
wire [23:0] data_letter_i;
wire [23:0] data_letter_j;
wire [23:0] data_letter_k;
wire [23:0] data_letter_l;
wire [23:0] data_letter_m;
wire [23:0] data_letter_n;
wire [23:0] data_letter_o;
wire [23:0] data_letter_p;
wire [23:0] data_letter_q;
wire [23:0] data_letter_r;
wire [23:0] data_letter_s;
wire [23:0] data_letter_t;
wire [23:0] data_letter_u;
wire [23:0] data_letter_v;
wire [23:0] data_letter_w;
wire [23:0] data_letter_x;
wire [23:0] data_letter_y;
wire [23:0] data_letter_z;
wire [23:0] data_letter_period;
wire [23:0] data_letter_plus;
wire [23:0] data_letter_question;
wire [23:0] data_letter_quote;
wire [23:0] data_letter_semicolon;
wire [23:0] data_letter_slash;
wire [23:0] data_letter_comma;
wire [23:0] data_letter_dash;
wire [23:0] data_letter_exclamation;
wire [23:0] data_letter_2;
wire [23:0] data_letter_3;
wire [23:0] data_letter_4;
wire [23:0] data_letter_5;
wire [23:0] data_letter_6;
wire [23:0] data_letter_7;
wire [23:0] data_letter_8;
wire [23:0] data_letter_9;
wire [23:0] data_letter_heart;
wire [23:0] data_letter_crying;
wire [23:0] data_letter_laughing;
wire [23:0] data_letter_kiss;



wire [23:0] background_data;

reg [23:0] bgr;
assign r_data = bgr[23:16];
assign g_data = bgr[15:8];
assign b_data = bgr[7:0];

	always
	begin
		if (~is_in_grid | ascii_code_to_display == 8'd0)
			bgr <= background_data;
		if (ascii_code_to_display == 8'b01000001)
			bgr <= data_letter_a;
		else if (ascii_code_to_display == 8'b01000010)
			bgr <= data_letter_b;
		else if (ascii_code_to_display == 8'b01000011)
			bgr <= data_letter_c;
		else if (ascii_code_to_display == 8'b01000100)
			bgr <= data_letter_d;
		else if (ascii_code_to_display == 8'b01000101)
			bgr <= data_letter_e;
		else if (ascii_code_to_display == 8'b01000110)
			bgr <= data_letter_f;
		else if (ascii_code_to_display == 8'b01000111)
			bgr <= data_letter_g;
		else if (ascii_code_to_display == 8'b01001000)
			bgr <= data_letter_h;
		else if (ascii_code_to_display == 8'b01001001)
			bgr <= data_letter_i;
		else if (ascii_code_to_display == 8'b01001010)
			bgr <= data_letter_j;
		else if (ascii_code_to_display == 8'b01001011)
			bgr <= data_letter_k;
		else if (ascii_code_to_display == 8'b01001100)
			bgr <= data_letter_l;
		else if (ascii_code_to_display == 8'b01001101)
			bgr <= data_letter_m;
		else if (ascii_code_to_display == 8'b01001110)
			bgr <= data_letter_n;
		else if (ascii_code_to_display == 8'b01001111)
			bgr <= data_letter_o;
		else if (ascii_code_to_display == 8'b01010000)
			bgr <= data_letter_p;
		else if (ascii_code_to_display == 8'b01010001)
			bgr <= data_letter_q;
		else if (ascii_code_to_display == 8'b01010010)
			bgr <= data_letter_r;
		else if (ascii_code_to_display == 8'b01010011)
			bgr <= data_letter_s;
		else if (ascii_code_to_display == 8'b01010100)
			bgr <= data_letter_t;
		else if (ascii_code_to_display == 8'b01010101)
			bgr <= data_letter_u;
		else if (ascii_code_to_display == 8'b01010110)
			bgr <= data_letter_v;
		else if (ascii_code_to_display == 8'b01010111)
			bgr <= data_letter_w;
		else if (ascii_code_to_display == 8'b01011000)
			bgr <= data_letter_x;
		else if (ascii_code_to_display == 8'b01011001)
			bgr <= data_letter_y;
		else if (ascii_code_to_display == 8'b01011010)
			bgr <= data_letter_z;
		else if (ascii_code_to_display == 8'b00111110)
			bgr <= data_letter_period;
		else if (ascii_code_to_display == 8'b00101011)
			bgr <= data_letter_plus;
		else if (ascii_code_to_display == 8'b00111111)
			bgr <= data_letter_question;
		else if (ascii_code_to_display == 8'b00100010)
			bgr <= data_letter_quote;
//		else if (ascii_code_to_display == 8'b00111010)
//			bgr <= data_letter_semicolon;
//		else if (ascii_code_to_display == 8'b01111100)
//			bgr <= data_letter_slash;
//		else if (ascii_code_to_display == 8'b00111100)
//			bgr <= data_letter_comma;
//		else if (ascii_code_to_display == 8'b01011111)
//			bgr <= data_letter_dash;
//		else if (ascii_code_to_display == 8'b00100001)
//			bgr <= data_letter_exclamation;
//		else if (ascii_code_to_display == 8'b01000000)
//			bgr <= data_letter_two;
//		else if (ascii_code_to_display == 8'b00100011)
//			bgr <= data_letter_three;
//		else if (ascii_code_to_display == 8'b00100100)
//			bgr <= data_letter_four;
//		else if (ascii_code_to_display == 8'b00100101)
//			bgr <= data_letter_five;
//		else if (ascii_code_to_display == 8'b01011110)
//			bgr <= data_letter_six;
//		else if (ascii_code_to_display == 8'b00100110)
//			bgr <= data_letter_seven;
//		else if (ascii_code_to_display == 8'b00101010)
//			bgr <= data_letter_eight;
//		else if (ascii_code_to_display == 8'b00101000)
//			bgr <= data_letter_nine;
		else if (ascii_code_to_display == 8'b10000000)
			bgr <= data_letter_heart;
		else if (ascii_code_to_display == 8'b10000001)
			bgr <= data_letter_crying;
		else if (ascii_code_to_display == 8'b10000010)
			bgr <= data_letter_laughing;
		else if (ascii_code_to_display == 8'b10000011)
			bgr <= data_letter_kiss;
		else
			bgr <= background_data;
	end

	// A
	a_img_data	img_data_inst_a (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_a )
		);

	a_img_index	img_index_inst_a (
		.address ( index_letter_a ),
		.clock ( VGA_clock ),
		.q ( data_letter_a )
		);		
		
		
	// B
	b_img_data	img_data_inst_b (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_b )
		);

	b_img_index	img_index_inst_b (
		.address ( index_letter_b ),
		.clock ( VGA_clock ),
		.q ( data_letter_b  )
		);			
		
		
	// C
	c_img_data	img_data_inst_c (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_c )
		);

	c_img_index	img_index_inst_c (
		.address ( index_letter_c ),
		.clock ( VGA_clock ),
		.q ( data_letter_c )
		);		

	// D
	d_img_data	img_data_inst_d (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_d )
		);

	d_img_index	img_index_inst_d (
		.address ( index_letter_d ),
		.clock ( VGA_clock ),
		.q ( data_letter_d )
		);		

	// e
	e_img_data	img_data_inst_e (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_e )
		);

	e_img_index	img_index_inst_e (
		.address ( index_letter_e ),
		.clock ( VGA_clock ),
		.q ( data_letter_e )
		);		

	// f
	f_img_data	img_data_inst_f (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_f )
		);

	f_img_index	img_index_inst_f (
		.address ( index_letter_f ),
		.clock ( VGA_clock ),
		.q ( data_letter_f )
		);		

	// g
	g_img_data	img_data_inst_g (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_g )
		);

	g_img_index	img_index_inst_g (
		.address ( index_letter_g ),
		.clock ( VGA_clock ),
		.q ( data_letter_g )
		);		

	// H
	h_img_data	img_data_inst_h (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_h )
		);

	h_img_index	img_index_inst_h (
		.address ( index_letter_h ),
		.clock ( VGA_clock ),
		.q ( data_letter_h )
		);		

	// I
	i_img_data	img_data_inst_i (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_i )
		);

	i_img_index	img_index_inst_i (
		.address ( index_letter_i ),
		.clock ( VGA_clock ),
		.q ( data_letter_i )
		);		

	// J
	j_img_data	img_data_inst_j (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_j )
		);

	j_img_index	img_index_inst_j (
		.address ( index_letter_j ),
		.clock ( VGA_clock ),
		.q ( data_letter_j )
		);	
		
	// K
	k_img_data	img_data_inst_k (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_k )
		);

	k_img_index	img_index_inst_k (
		.address ( index_letter_k ),
		.clock ( VGA_clock ),
		.q ( data_letter_k )
		);		

	// L
	l_img_data	img_data_inst_l (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_l )
		);

	l_img_index	img_index_inst_l (
		.address ( index_letter_l ),
		.clock ( VGA_clock ),
		.q ( data_letter_l )
		);		

	// M
	m_img_data	img_data_inst_m (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_m )
		);

	m_img_index	img_index_inst_m (
		.address ( index_letter_m ),
		.clock ( VGA_clock ),
		.q ( data_letter_m )
		);		

	// N
	n_img_data	img_data_inst_n (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_n )
		);

	n_img_index	img_index_inst_n (
		.address ( index_letter_n ),
		.clock ( VGA_clock ),
		.q ( data_letter_n )
		);		

	// O
	o_img_data	img_data_inst_o (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_o )
		);

	o_img_index	img_index_inst_o (
		.address ( index_letter_o ),
		.clock ( VGA_clock ),
		.q ( data_letter_o )
		);		

	// P
	p_img_data	img_data_inst_p (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_p )
		);

	p_img_index	img_index_inst_p (
		.address ( index_letter_p ),
		.clock ( VGA_clock ),
		.q ( data_letter_p )
		);		

	// Q
	q_img_data	img_data_inst_q (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_q )
		);

	q_img_index	img_index_inst_q (
		.address ( index_letter_q ),
		.clock ( VGA_clock ),
		.q ( data_letter_q )
		);		

	// R
	r_img_data	img_data_inst_r (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_r )
		);

	r_img_index	img_index_inst_r (
		.address ( index_letter_r ),
		.clock ( VGA_clock ),
		.q ( data_letter_r )
		);		

	// S
	s_img_data	img_data_inst_s (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_s )
		);

	s_img_index	img_index_inst_s (
		.address ( index_letter_s ),
		.clock ( VGA_clock ),
		.q ( data_letter_s )
		);		

	// T
	t_img_data	img_data_inst_t (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_t )
		);

	t_img_index	img_index_inst_t (
		.address ( index_letter_t ),
		.clock ( VGA_clock ),
		.q ( data_letter_t )
		);		

	// U
	u_img_data	img_data_inst_u (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_u )
		);

	u_img_index	img_index_inst_u (
		.address ( index_letter_u ),
		.clock ( VGA_clock ),
		.q ( data_letter_u )
		);		

	// V
	v_img_data	img_data_inst_v (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_v )
		);

	v_img_index	img_index_inst_v (
		.address ( index_letter_v ),
		.clock ( VGA_clock ),
		.q ( data_letter_v )
		);		

	// W
	w_img_data	img_data_inst_w (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_w )
		);

	w_img_index	img_index_inst_w (
		.address ( index_letter_w ),
		.clock ( VGA_clock ),
		.q ( data_letter_w )
		);		

	// X
	x_img_data	img_data_inst_x (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_x )
		);

	x_img_index	img_index_inst_x (
		.address ( index_letter_x ),
		.clock ( VGA_clock ),
		.q ( data_letter_x )
		);		

	// Y
	y_img_data	img_data_inst_y (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_y )
		);

	y_img_index	img_index_inst_y (
		.address ( index_letter_y ),
		.clock ( VGA_clock ),
		.q ( data_letter_y )
		);		

	// Z
	z_img_data	img_data_inst_z (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_z )
		);

	z_img_index	img_index_inst_z (
		.address ( index_letter_z ),
		.clock ( VGA_clock ),
		.q ( data_letter_z )
		);
		
		// period
	period_img_data	img_data_inst_period (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_period )
		);

	period_img_index	img_index_inst_period (
		.address ( index_letter_period ),
		.clock ( VGA_clock ),
		.q ( data_letter_period )
		);
		
		// plus
	plus_img_data	img_data_inst_plus (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_plus )
		);

	plus_img_index	img_index_inst_plus (
		.address ( index_letter_plus ),
		.clock ( VGA_clock ),
		.q ( data_letter_plus )
		);
		
		// question
	question_img_data	img_data_inst_question (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_question )
		);

	question_img_index	img_index_inst_question (
		.address ( index_letter_question ),
		.clock ( VGA_clock ),
		.q ( data_letter_question )
		);
		
   // quote
	quote_img_data	img_data_inst_quote (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_quote )
		);

	quote_img_index	img_index_inst_quote (
		.address ( index_letter_quote ),
		.clock ( VGA_clock ),
		.q ( data_letter_quote )
		);
	
//	// semicolon
//	semicolon_img_data	img_data_inst_semicolon (
//		.address ( address ),
//		.clock ( ~VGA_clock ),
//		.q ( index_letter_semicolon )
//		);
//
//	semicolon_img_index	img_index_inst_semicolon (
//		.address ( index_letter_semicolon ),
//		.clock ( VGA_clock ),
//		.q ( data_letter_semicolon )
//		);
//		
//		// slash
//	slash_img_data	img_data_inst_slash (
//		.address ( address ),
//		.clock ( ~VGA_clock ),
//		.q ( index_letter_slash )
//		);
//
//	slash_img_index	img_index_inst_slash (
//		.address ( index_letter_slash ),
//		.clock ( VGA_clock ),
//		.q ( data_letter_slash )
//		);
//		
//		// comma
//	comma_img_data	img_data_inst_comma (
//		.address ( address ),
//		.clock ( ~VGA_clock ),
//		.q ( index_letter_comma )
//		);
//
//	comma_img_index	img_index_inst_comma (
//		.address ( index_letter_comma ),
//		.clock ( VGA_clock ),
//		.q ( data_letter_comma )
//		);
//		
//		// dash
//	dash_img_data	img_data_inst_dash (
//		.address ( address ),
//		.clock ( ~VGA_clock ),
//		.q ( index_letter_dash )
//		);
//
//	dash_img_index	img_index_inst_dash (
//		.address ( index_letter_dash ),
//		.clock ( VGA_clock ),
//		.q ( data_letter_dash )
//		);
//		
//		// exclamation
//	exclamation_img_data	img_data_inst_exclamation (
//		.address ( address ),
//		.clock ( ~VGA_clock ),
//		.q ( index_letter_exclamation )
//		);
//
//	exclamation_img_index	img_index_inst_exclamation (
//		.address ( index_letter_exclamation ),
//		.clock ( VGA_clock ),
//		.q ( data_letter_exclamation )
//		);
//		
//		// two
//	two_img_data	img_data_inst_two (
//		.address ( address ),
//		.clock ( ~VGA_clock ),
//		.q ( index_letter_two )
//		);
//
//	two_img_index	img_index_inst_two (
//		.address ( index_letter_two ),
//		.clock ( VGA_clock ),
//		.q ( data_letter_two )
//		);
//		
//		// three
//	three_img_data	img_data_inst_three (
//		.address ( address ),
//		.clock ( ~VGA_clock ),
//		.q ( index_letter_three )
//		);
//
//	three_img_index	img_index_inst_three (
//		.address ( index_letter_three ),
//		.clock ( VGA_clock ),
//		.q ( data_letter_three )
//		);
//		
//		// four
//	four_img_data	img_data_inst_four (
//		.address ( address ),
//		.clock ( ~VGA_clock ),
//		.q ( index_letter_four )
//		);
//
//	four_img_index	img_index_inst_four (
//		.address ( index_letter_four ),
//		.clock ( VGA_clock ),
//		.q ( data_letter_four )
//		);
//		
//		// five
//	five_img_data	img_data_inst_five (
//		.address ( address ),
//		.clock ( ~VGA_clock ),
//		.q ( index_letter_five )
//		);
//
//	five_img_index	img_index_inst_five (
//		.address ( index_letter_five ),
//		.clock ( VGA_clock ),
//		.q ( data_letter_five )
//		);
//		
//		// six
//	six_img_data	img_data_inst_six (
//		.address ( address ),
//		.clock ( ~VGA_clock ),
//		.q ( index_letter_six )
//		);
//
//	six_img_index	img_index_inst_six (
//		.address ( index_letter_six ),
//		.clock ( VGA_clock ),
//		.q ( data_letter_six )
//		);
//		
//		// seven
//	seven_img_data	img_data_inst_seven (
//		.address ( address ),
//		.clock ( ~VGA_clock ),
//		.q ( index_letter_seven )
//		);
//
//	seven_img_index	img_index_inst_seven (
//		.address ( index_letter_seven ),
//		.clock ( VGA_clock ),
//		.q ( data_letter_seven )
//		);
//		
//		// eight
//	eight_img_data	img_data_inst_eight (
//		.address ( address ),
//		.clock ( ~VGA_clock ),
//		.q ( index_letter_eight )
//		);
//
//	eight_img_index	img_index_inst_eight (
//		.address ( index_letter_eight ),
//		.clock ( VGA_clock ),
//		.q ( data_letter_eight )
//		);
//		
//		// nine
//	nine_img_data	img_data_inst_nine (
//		.address ( address ),
//		.clock ( ~VGA_clock ),
//		.q ( index_letter_nine )
//		);
//
//	nine_img_index	img_index_inst_nine (
//		.address ( index_letter_nine ),
//		.clock ( VGA_clock ),
//		.q ( data_letter_nine )
//		);
		
   // heart
	heart_img_data	img_data_inst_heart (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_heart )
		);

	heart_img_index	img_index_inst_heart (
		.address ( index_letter_heart ),
		.clock ( VGA_clock ),
		.q ( data_letter_heart )
		);
		
	// crying
	crying_img_data	img_data_inst_crying (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_crying )
		);

	crying_img_index	img_index_inst_crying (
		.address ( index_letter_crying ),
		.clock ( VGA_clock ),
		.q ( data_letter_crying )
		);
		
	// laughing
	laughing_img_data	img_data_inst_laughing (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_laughing )
		);

	laughing_img_index	img_index_inst_laughing (
		.address ( index_letter_laughing ),
		.clock ( VGA_clock ),
		.q ( data_letter_laughing )
		);
		
	// kiss
	kiss_img_data	img_data_inst_kiss (
		.address ( address ),
		.clock ( ~VGA_clock ),
		.q ( index_letter_kiss )
		);

	kiss_img_index	img_index_inst_kiss (
		.address ( index_letter_kiss ),
		.clock ( VGA_clock ),
		.q ( data_letter_kiss )
		);
		
		
	//background
	wire [7:0] index;
	img_data	img_data_inst (
	.address ( ADDR ),
	.clock ( ~VGA_clock ),
	.q ( index )
	);
	
	img_index	img_index_inst (
	.address ( index ),
	.clock ( VGA_clock ),
	.q ( background_data )
	);	
	
	
endmodule
