`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:26:41 04/28/2025 
// Design Name: 
// Module Name:    led_driver 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module led_driver(
	input [7:0] led_values,
	output [7:0] LED
    );
	 
	// This will only show a 'Bar' of LED's up to the maximum value
	assign LED[7] = led_values[7];
	assign LED[6] = led_values[7] | led_values[6];
	assign LED[5] = led_values[7] | led_values[6] | led_values[5];
	assign LED[4] = led_values[7] | led_values[6] | led_values[5] | led_values[4];
	assign LED[3] = led_values[7] | led_values[6] | led_values[5] | led_values[4]
							| led_values[3];
	assign LED[2] = led_values[7] | led_values[6] | led_values[5] | led_values[4] 
							| led_values[3] | led_values[2];
	assign LED[1] = led_values[7] | led_values[6] | led_values[5] | led_values[4] 
							| led_values[3] | led_values[2] | led_values[1];
	assign LED[0] = led_values[7] | led_values[6] | led_values[5] | led_values[4] 
							| led_values[3] | led_values[2] | led_values[1] | led_values[0];

endmodule
