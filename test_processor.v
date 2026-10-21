`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   05:07:02 04/30/2025
// Design Name:   picoblaze
// Module Name:   /home/ise/Desktop/CDA4203L/FINAL_PROJECT/FINAL_PROJECT/test_processor.v
// Project Name:  FINAL_PROJECT
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: picoblaze
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_processor;

	// Inputs
	reg [7:0] in_port;
	reg interrupt;
	reg reset;
	reg clk;

	// Outputs
	wire [7:0] port_id;
	wire read_strobe;
	wire write_strobe;
	wire [7:0] out_port;
	wire interrupt_ack;

	// Instantiate the Unit Under Test (UUT)
	picoblaze uut (
		.port_id(port_id), 
		.read_strobe(read_strobe), 
		.in_port(in_port), 
		.write_strobe(write_strobe), 
		.out_port(out_port), 
		.reset(reset), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		in_port = 0;
		interrupt = 0;
		reset = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
	always begin
		#1 clk = ~clk;
	end
endmodule

