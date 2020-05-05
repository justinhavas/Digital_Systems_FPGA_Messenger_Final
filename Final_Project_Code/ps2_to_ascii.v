module ps2_to_ascii(ps2, ps2_prev, ascii);
	input [7:0] ps2, ps2_prev;
	output reg [7:0] ascii;
	
	reg left_shift, right_shift, caps_lock, have_changed_caps_lock;
	wire shift;
	assign shift = left_shift | right_shift | caps_lock;
	
	initial
	begin
		left_shift <= 1'b0;
		right_shift <= 1'b0;
		caps_lock <= 1'b0;
		ascii <= 8'h00;
	end
	
	always @(*)
	begin
		if (ps2 == 8'h12)
		begin
			left_shift <= ps2_prev != 8'hF0; //if ps2 if the left shift code, then if ps2_prev == 8'hF0, then left shift was released, otherwise it was pressed down
		end
		else if (left_shift)
			left_shift <= 1'b1;
		else
			left_shift <= 1'b0;
		
		if (ps2 == 8'h59)
		begin
			right_shift <= ps2_prev != 8'hF0; //if ps2 if the right shift code, then if ps2_prev == 8'hF0, then right shift was released, otherwise it was pressed down
		end
		else if (right_shift)
			right_shift <= 1'b1;
		else
			right_shift <= 1'b0;

		caps_lock <= 1'b0;
		
//		if (ps2 == 8'h58 & ps2_prev != 8'hF0)
//		begin
//			if (!have_changed_caps_lock)
//			begin
//				caps_lock <= ~caps_lock;
//			end
//			have_changed_caps_lock <= 1'b1;
//		end
//		else
//		begin
//			have_changed_caps_lock <= 1'b0;
//		end
	end
		
	always @(*)
		begin
		
		
		
		if (shift)
		begin
			case (ps2)
			8'h1c: ascii <= 8'h41; //A
			8'h32: ascii <= 8'h42; //B
			8'h21: ascii <= 8'h43; //C
			8'h23: ascii <= 8'h44; //D
			8'h24: ascii <= 8'h45; //E
			8'h2B: ascii <= 8'h46; //F
			8'h34: ascii <= 8'h47; //G
			8'h33: ascii <= 8'h48; //H
			8'h43: ascii <= 8'h49; //I
			8'h3B: ascii <= 8'h4A; //J
			8'h42: ascii <= 8'h4B; //K
			8'h4B: ascii <= 8'h4C; //L
			8'h3A: ascii <= 8'h4D; //M
			8'h31: ascii <= 8'h4E; //N
			8'h44: ascii <= 8'h4F; //O
			8'h4D: ascii <= 8'h50; //P
			8'h15: ascii <= 8'h51; //Q
			8'h2D: ascii <= 8'h52; //R
			8'h1B: ascii <= 8'h53; //S
			8'h2C: ascii <= 8'h54; //T
			8'h3C: ascii <= 8'h55; //U
			8'h2A: ascii <= 8'h56; //V
			8'h1D: ascii <= 8'h57; //W
			8'h22: ascii <= 8'h58; //X
			8'h35: ascii <= 8'h59; //Y
			8'h1A: ascii <= 8'h5A; //Z
			
			8'h29: ascii <= 8'h20; //space
			8'h5A: ascii <= 8'h0A; //enter
			8'h66: ascii <= 8'h08; //backspace
			
			8'h16: ascii <= 8'h21; //!
			8'h1E: ascii <= 8'h40; //@
			8'h26: ascii <= 8'h23; //#
			8'h25: ascii <= 8'h24; //$
			8'h2E: ascii <= 8'h25; //%
			8'h36: ascii <= 8'h5E; //^
			8'h3D: ascii <= 8'h26; //&
			8'h3E: ascii <= 8'h2A; //*
			8'h46: ascii <= 8'h28; //(
			8'h45: ascii <= 8'h29; //)
			
			8'h0E: ascii <= 8'h7E;//~
			8'h4E: ascii <= 8'h5F;//_
			8'h55: ascii <= 8'h2B;//+
			8'h54: ascii <= 8'h7B;//{
			8'h5B: ascii <= 8'h7D;//}
			8'h5D: ascii <= 8'h7C;//|
			8'h4C: ascii <= 8'h3A;//:
			8'h52: ascii <= 8'h22;//"
			8'h41: ascii <= 8'h3C;//<
			8'h49: ascii <= 8'h3E;//>
			8'h4A: ascii <= 8'h3F;//?
			
			default: ascii <= 8'h00;
			endcase
		end
		else
		begin
			case (ps2)
			8'h1c: ascii <= 8'h61; //a
			8'h32: ascii <= 8'h62; //b
			8'h21: ascii <= 8'h63; //c
			8'h23: ascii <= 8'h64; //d
			8'h24: ascii <= 8'h65; //e
			8'h2B: ascii <= 8'h66; //f
			8'h34: ascii <= 8'h67; //g
			8'h33: ascii <= 8'h68; //h
			8'h43: ascii <= 8'h69; //i
			8'h3B: ascii <= 8'h6A; //j
			8'h42: ascii <= 8'h6B; //k
			8'h4B: ascii <= 8'h6C; //l
			8'h3A: ascii <= 8'h6D; //m
			8'h31: ascii <= 8'h6E; //n
			8'h44: ascii <= 8'h6F; //o
			8'h4D: ascii <= 8'h70; //p
			8'h15: ascii <= 8'h71; //q
			8'h2D: ascii <= 8'h72; //r
			8'h1B: ascii <= 8'h73; //s
			8'h2C: ascii <= 8'h74; //t
			8'h3C: ascii <= 8'h75; //u
			8'h2A: ascii <= 8'h76; //v
			8'h1D: ascii <= 8'h77; //w
			8'h22: ascii <= 8'h78; //x
			8'h35: ascii <= 8'h79; //y
			8'h1A: ascii <= 8'h7A; //z
			
			8'h29: ascii <= 8'h20; //space
			8'h5A: ascii <= 8'h0A; //enter
			8'h66: ascii <= 8'h08; //backspace
			
			8'h45: ascii <= 8'h30; //0
			8'h16: ascii <= 8'h31; //1
			8'h1E: ascii <= 8'h32; //2
			8'h26: ascii <= 8'h33; //3
			8'h25: ascii <= 8'h34; //4
			8'h2E: ascii <= 8'h35; //5
			8'h36: ascii <= 8'h36; //6
			8'h3D: ascii <= 8'h37; //7
			8'h3E: ascii <= 8'h38; //8
			8'h46: ascii <= 8'h39; //9
			
			8'h0E: ascii <= 8'h60;//`
			8'h4E: ascii <= 8'h2D;//-
			8'h55: ascii <= 8'h3D;//=
			8'h54: ascii <= 8'h5B;//[
			8'h5B: ascii <= 8'h5D;//]
			8'h5D: ascii <= 8'h5C;//\
			8'h4C: ascii <= 8'h3B;//;
			8'h52: ascii <= 8'h27;//'
			8'h41: ascii <= 8'h2C;//,
			8'h49: ascii <= 8'h2E;//.
			8'h4A: ascii <= 8'h2F;///
			
			default: ascii <= 8'h00;
			endcase
		end
	end
	
endmodule
