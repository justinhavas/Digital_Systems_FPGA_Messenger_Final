module grid_converter(
input [9:0] pixel_x,
input [9:0] pixel_y,
output is_in_grid,
output [5:0] char_x,
output [5:0] char_y,
output [3:0] pixel_x_within_char,
output [3:0] pixel_y_within_char);
	
	assign is_in_grid = (pixel_x > 10'd139) & (pixel_y > 10'd79);
	assign char_x = is_in_grid?(pixel_x-10'd140)/10'd10:6'd0;
	assign char_y = is_in_grid?(pixel_y-10'd140)/10'd10:6'd0;
	assign pixel_x_within_char = is_in_grid?(pixel_x-10'd140)%10'd10:4'd0;
	assign pixel_y_within_char = is_in_grid?(pixel_y-10'd140)%10'd10:4'd0;
	
endmodule
