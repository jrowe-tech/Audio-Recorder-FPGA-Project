`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:51:38 04/26/2025 
// Design Name: 
// Module Name:    keypad_driver 
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
module keypad_driver(
	input [3:0] KYPD_ROW,
	input CLK,
	input enabled,
	output [3:0] KYPD_COL,
	output [7:0] keypad_button,
	output pressed_strobe
    );
	
	// INITIALIZE REGISTERS TO/FROM FSM
	reg [7:0] last_pressed;
	reg write_strobe;
	reg [3:0] COL_OUT;
	reg [1:0] state;
	reg DIVIDED_CLK;
	reg clk_counter;
	
	// INITIALIZATION
	initial begin
		last_pressed <= 8'b00000000;
		write_strobe <= 1'b0;
	end

	// 4-STATE MOORE MACHINE FSM FOR COLUMN SELECTION
	always@(posedge DIVIDED_CLK) begin
		if (enabled) begin
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
				write_strobe <= 1'b1;
			end
		end
		else begin
			write_strobe <= 1'b0;
			last_pressed[7:0] <= 8'b00000000;
		end
	end
	
	assign keypad_button = last_pressed;
	assign pressed_strobe = write_strobe;
	assign KYPD_COL = COL_OUT;
	
	// NEEDED DIVIDED CLOCK SIGNAL DUE TO UNSTABLE KEYPAD OUTPUT (EXPERIMENTALLY TESTED WITH test_keypad.v)
	// CLOCK DIVIDER
	always@(posedge CLK) begin
		if (enabled) begin
			if (clk_counter != 16'b1111111111111111) begin
				clk_counter <= clk_counter + 1'b1;
				DIVIDED_CLK <= 1'b0;
			end
			else begin
				clk_counter <= 16'b0000000000000000;
				DIVIDED_CLK <= 1'b1;
			end
		end
	end


endmodule
