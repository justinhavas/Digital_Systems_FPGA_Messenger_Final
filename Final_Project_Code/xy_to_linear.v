// This module takes in an x-y coordinate and returns a memory address for the upper-left corner
// of the image to be displayed and the lower-right corner.

// x range: 1-63
// y range: 1-47

// 640x480

module xy_to_linear(input_x,
                     input_y,
                     upper_left_address,
                     upper_right_address);

	
input [5:0] input_x;
input [5:0] input_y;    
output [18:0]  upper_left_address;
output [18:0]  upper_right_address;


assign upper_left_address = 19'b0101001000101100000;
assign upper_right_address = 19'b0101101010011111000;

endmodule