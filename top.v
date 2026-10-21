`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:15:46 04/26/2025 
// Design Name: 
// Module Name:    top 
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
module top(
	input [3:0] KYPD_ROW,
	input [7:0] SW,
	input [3:0] BTN,
	input CLK,
	input rs232_rx,
	input reset,
	output [3:0] KYPD_COL,
	output [7:0] LED,
	output rs232_tx
	);
	/*
	output [7:0] port_debug,
	output [7:0] output_debug,
	output write_debug
    );
	 */
	
	// GENERAL I/O, REGS, WIRES
	wire ram_clock_out;
	
	// COOL FUNNY HAHA LED TRICK BECAUSE ITS THE ONLY FUCKING WAY IT WORKS
	wire [7:0] leds;
	assign LED = leds;
	
	// CPU I/O
	reg [7:0] pico_input;
	wire [7:0] pico_port;
	wire pico_reset;
	wire [7:0] pico_output;
	wire pico_write_strobe;
	wire pico_read_strobe;
	
	// CURRENTLY NO USE FOR INTERRUPT
	// CURRENTLY USING 100MHz Master Clock Signal
	picoblaze PROCESSOR(
		.in_port(pico_input),
		.clk(CLK),
		.port_id(pico_port),
		.out_port(pico_output),
		.write_strobe(pico_write_strobe),
		.read_strobe(pico_read_strobe),
		.reset(pico_reset)
	);
	
	assign port_debug = pico_port;
	assign output_debug = pico_output;
	assign pico_reset = reset;
	assign write_debug = pico_write_strobe;
	
	//KEYPAD DRIVER I/O
	wire keypad_enabled;
	wire [7:0] keypad_output;
	wire keypad_write;
	
	// CURRENTLY USING 100MHZ Master Clock Signal
	keypad_driver KEYPAD(
		.KYPD_ROW(KYPD_ROW),
		.CLK(CLK),
		.enabled(keypad_enabled),
		.KYPD_COL(KYPD_COL),
		.keypad_button(keypad_output),
		.pressed_strobe(keypad_write)
	);

	// ONLY ACTIVATE KEYPAD FSM WHEN NEEDED TO CONSERVE POWER
	assign keypad_enabled = pico_write_strobe & (pico_port == 8'b00000000);
	

	wire [7:0] led_values;
	
	/*
	led_driver LEDS(
		.led_values(led_values),
		.LED(leds)
	);
	*/
	
	// UART I/O
	wire tx_buffer_full;
	wire strobe_uart;
	wire uart_data;
	wire uart_reset;
	wire uart_out;
	reg read_from_uart;
	rs232_uart UART(
		.tx_data_in(pico_output),
		.write_tx_data(strobe_uart),
		.reset(uart_reset),
		.clk(CLK),
		.rs232_tx(rs232_tx),
		.rs232_rx(rs232_rx),
		.rx_data_out(),
		.read_rx_data_ack(),
		.rx_data_present(),
		.tx_buffer_full(tx_buffer_full)
	);
	assign strobe_uart = pico_write_strobe & (pico_port == 8'b00010001);
	assign uart_reset = reset;
	
	
	// SET LED's To 3 Modes -> Playing Loudess, Input Loudness, Set Volume
	// TODO
	assign leds = test_bullshit;
	
	
	reg [7:0] test_bullshit;
	initial begin
		test_bullshit <= 8'b00000000;
	end
	
	always@(posedge CLK) begin
		case (pico_port)
			8'b00000000: begin
				if (keypad_write) begin
					pico_input <= keypad_output;
				end
			end
			8'b00000001: begin
				pico_input <= SW;
			end
			8'b00000010: begin
				pico_input <= tx_buffer_full;
			end
			8'b00010001: begin
				if (pico_write_strobe) begin
					test_bullshit <= rs232_tx;
				end
			end
		endcase
		
		read_from_uart <= pico_read_strobe & (pico_port == 8'h04);
	end

endmodule
