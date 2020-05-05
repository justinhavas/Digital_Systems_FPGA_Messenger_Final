// This module takes in an x-y coordinate and returns a memory address for the upper-left corner
// of the image to be displayed and the lower-right corner.

// x range: 1-63
// y range: 1-47

// 640x480 screen size

module is_in_square (input_x, input_y, full_address, in_square, m_clk);
	
input [9:0] input_x;
input [9:0] input_y;    
input [18:0]  full_address;
input m_clk;
output in_square;

wire [9:0] address_x;
wire [9:0] address_y;

wire [9:0] x_added;
wire [9:0] y_added;

reg buffer_in_square;

linear_to_xy m_conversion(full_address, address_x, address_y);
assign x_added = input_x + 10'b0000010111; 
assign y_added = input_y + 10'b0000010111; 

always@(posedge ~m_clk)
if (address_x >= input_x && address_x <= x_added && address_y >= input_y && address_y <= y_added)
	buffer_in_square = 1'b1;
else
	buffer_in_square = 1'b0;
	
assign in_square = buffer_in_square;	

endmodule