`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:09:17 04/30/2025
// Design Name:   top
// Module Name:   /home/ise/Desktop/CDA4203L/FINAL_PROJECT/FINAL_PROJECT/test_system.v
// Project Name:  FINAL_PROJECT
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_system;

	// Inputs
	reg [3:0] KYPD_ROW;
	wire [3:0] KYPD_COL;
	reg [7:0] SW;
	reg [3:0] BTN;
	reg test_clock;
	wire rs232_tx;
	reg reset;
	
	wire [7:0] port_debug;
	wire [7:0] output_debug;

	// Outputs
	wire [7:0] LED;
	wire write_debug;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.KYPD_ROW(KYPD_ROW), 
		.SW(SW), 
		.BTN(BTN), 
		.CLK(test_clock), 
		.rs232_tx(rs232_tx), 
		.KYPD_COL(KYPD_COL), 
		.LED(LED),
		.port_debug(port_debug),
		.output_debug(output_debug),
		.write_debug(write_debug),
		.reset(reset)
	);

	initial begin
		// Initialize Inputs
		KYPD_ROW = 0;
		SW = 8'b01010101;
		BTN = 0;
		test_clock = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always begin
		#1 test_clock <= ~test_clock;
	end
      
endmodule

