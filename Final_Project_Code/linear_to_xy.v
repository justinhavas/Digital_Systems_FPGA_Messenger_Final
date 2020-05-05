// This module takes in an x-y coordinate and returns a memory address for the upper-left corner
// of the image to be displayed and the lower-right corner.

// x range: 1-63
// y range: 1-47

// 640x480 screen size

module linear_to_xy(input_address,
                     output_x,
                     output_y );

input [18:0] input_address;	
output [9:0] output_x;
output [9:0] output_y;    

wire [18:0] input_address_reg;

assign input_address_reg = input_address;

assign output_y = input_address_reg / 19'b1010000000; //640
assign output_x = input_address_reg - output_y*19'b1010000000;

endmodule