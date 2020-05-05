module vga_controller(
input iRST_n,
input iVGA_CLK,
output cBLANK_n,
output cHS,
output cVS,
output [7:0] b_data,
output [7:0] g_data,  
output [7:0] r_data, 

input FPGA_clock,
input [7:0] ascii_code,
input [5:0] input_x,
input [5:0] input_y);

	reg [18:0] ADDR;
	reg [23:0] bgr_data;
	wire VGA_CLK_n;
	wire [7:0] index;
	wire [23:0] bgr_data_raw;
//	wire cBLANK_n,cHS,cVS,rst;

	//convert address to pixel location
	wire [9:0] pixel_x, pixel_y;
	assign pixel_x = ADDR % 10'd640;
	assign pixel_y = ADDR / 10'd640;

	//convert pixel location to square in grid, and location within that square (and flag to say if it is in the grid at all)
	wire is_in_grid;
	wire [5:0] char_x;
	wire [5:0] char_y;
	wire [3:0] pixel_x_within_char;
	wire [3:0] pixel_y_within_char;
	grid_converter my_grid_converter(pixel_x, pixel_y, is_in_grid, char_x, char_y, pixel_x_within_char, pixel_y_within_char);

	//obtain ascii code at given grid position (and write input values when necessary)
	reg [7:0] prev_ascii_code;
	reg [5:0] prev_input_x;
	reg [5:0] prev_input_y;
	always @(posedge FPGA_clock)
	begin
		prev_ascii_code = ascii_code;
		prev_input_x = input_x;
		prev_input_y = input_y;
	end
	wire [10:0] address_dmem;
	wire wren = (ascii_code != prev_ascii_code | input_x != prev_input_x | input_y != prev_input_y);
	wire [7:0] ascii_code_to_display;
	vga_dmem my_dmem(
		.address    (address_dmem),
		.clock      (FPGA_clock),
		.data	    (ascii_code),
		.wren	    (wren),
		.q          (ascii_code_to_display)
		);
	vga_dmem_calculator my_vga_dmem_calc(wren?input_x:char_x,wren?input_y:char_y,address_dmem);
	
	//get the rgb values to display
	rgb_calc my_rgb_calc(ADDR, iVGA_CLK, is_in_grid, ascii_code_to_display, pixel_x_within_char, pixel_y_within_char, r_data, g_data, b_data);






/*********************************************************************************
*											Pre-written code											*
*********************************************************************************/
////
video_sync_generator LTM_ins (.vga_clk(iVGA_CLK),
                              .reset(~iRST_n),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS));
////
////Addresss generator
always@(posedge iVGA_CLK,negedge iRST_n)
begin
  if (!iRST_n)
     ADDR<=19'd0;
  else if (cHS==1'b0 && cVS==1'b0)
     ADDR<=19'd0;
  else if (cBLANK_n==1'b1)
     ADDR<=ADDR+1;
end
//////////////////////////
//////INDEX addr.
//assign VGA_CLK_n = ~iVGA_CLK;
//img_data	img_data_inst (
//	.address ( ADDR ),
//	.clock ( VGA_CLK_n ),
//	.q ( index )
//	);
//	
/////////////////////////
//////Add switch-input logic here
	
//////Color table output
//img_index	img_index_inst (
//	.address ( index ),
//	.clock ( iVGA_CLK ),
//	.q ( bgr_data_raw)
//	);	
//////
//////latch valid data at falling edge;
//always@(posedge VGA_CLK_n) bgr_data <= bgr_data_raw;
//assign b_data = bgr_data[23:16];
//assign g_data = bgr_data[15:8];
//assign r_data = bgr_data[7:0]; 
///////////////////
//////Delay the iHD, iVD,iDEN for one clock cycle;
//always@(negedge iVGA_CLK)
//begin
//  oHS<=cHS;
//  oVS<=cVS;
//  oBLANK_n<=cBLANK_n;
//end

endmodule
 	















