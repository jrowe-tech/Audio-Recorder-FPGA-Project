`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:50:10 04/26/2025 
// Design Name: 
// Module Name:    test_keypad 
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
module test_keypad(
	input [7:0] SW,
	input [3:0] KYPD_ROW,
	input CLK,
	output [3:0] KYPD_COL,
	output [7:0] LED
    );
	 
	reg [7:0] last_pressed;
	reg [2:0] state;
	reg [3:0] COL_OUT;
	reg DIVIDED_CLK;
	reg [26:0] clk_counter;
	
	initial begin
		state <= 2'b00;
	end
	
	always@(posedge DIVIDED_CLK) begin
		case (state)
			2'b00: begin
				state <= 2'b01;
				COL_OUT <= 4'b1110;
			end
			2'b01: begin
				state <= 2'b10;
				COL_OUT <= 4'b0111;
			end
			2'b10: begin
				state <= 2'b11;
				COL_OUT <= 4'b1011;
			end
			2'b11: begin
				state <= 2'b00;
				COL_OUT <= 4'b1101;
			end
		endcase
		
		if (KYPD_ROW != 4'b1111) begin
			last_pressed[7:4] <= KYPD_COL;
			last_pressed[3:0] <= KYPD_ROW;
		end
	end
	
	wire [7:0] test_fuckery;
	assign LED[7:0] = test_fuckery;
	assign test_fuckery = SW;
	
	assign KYPD_COL = COL_OUT;
	
	// CLOCK DIVIDER
	always@(posedge CLK) begin
		if (clk_counter != 27'b000000000001111111111111111) begin
			clk_counter <= clk_counter + 1'b1;
			DIVIDED_CLK <= 1'b0;
		end
		else begin
			clk_counter <= 27'b000000000000000000000000000;
			DIVIDED_CLK <= 1'b1;
		end
	end
	
endmodule
