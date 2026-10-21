`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   07:06:30 05/01/2025
// Design Name:   rs232_uart
// Module Name:   /home/ise/Desktop/CDA4203L/FINAL_PROJECT/FINAL_PROJECT/test_uart.v
// Project Name:  FINAL_PROJECT
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rs232_uart
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_uart;

	// Inputs
	reg [7:0] tx_data_in;
	reg write_tx_data;
	reg read_rx_data_ack;
	reg rs232_rx;
	reg reset;
	reg clk;

	// Outputs
	wire rs232_tx;
	wire tx_buffer_full;
	wire [7:0] rx_data_out;
	wire rx_data_present;

	// Instantiate the Unit Under Test (UUT)
	rs232_uart uut (
		.tx_data_in(tx_data_in), 
		.write_tx_data(write_tx_data), 
		.rs232_tx(rs232_tx), 
		.tx_buffer_full(tx_buffer_full), 
		.rx_data_out(rx_data_out), 
		.read_rx_data_ack(read_rx_data_ack), 
		.rs232_rx(rs232_rx), 
		.rx_data_present(rx_data_present), 
		.reset(reset), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		tx_data_in = 8'b01010101;
		write_tx_data = 1'b1;
		read_rx_data_ack = 0;
		rs232_rx = 0;
		reset = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		#100 write_tx_data = ~write_tx_data;
	end
      
endmodule

