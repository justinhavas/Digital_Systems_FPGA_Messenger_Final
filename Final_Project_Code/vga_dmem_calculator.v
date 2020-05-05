module vga_dmem_calculator(
input [5:0] x,
input [5:0] y,
output [10:0] address_dmem);
	assign address_dmem = (y*6'd50)+x;
endmodule
