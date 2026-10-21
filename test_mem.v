`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:06:53 05/09/2025
// Design Name:   memory_unit_top
// Module Name:   /home/ise/Desktop/CDA4203L/FINAL_PROJECT/FINAL_PROJECT/test_mem.v
// Project Name:  FINAL_PROJECT
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: memory_unit_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_mem;

	// Inputs
	reg clk_100mhz;
	reg rst;
	reg [1:0] op_code;
	reg [3:0] message_id;
	reg [15:0] audio_in;

	// Outputs
	wire [15:0] audio_out;
	wire ram_clock_out;
	wire hw_ram_rasn;
	wire hw_ram_casn;
	wire hw_ram_wen;
	wire [2:0] hw_ram_ba;
	wire hw_ram_udm;
	wire hw_ram_ldm;
	wire hw_ram_ck;
	wire hw_ram_ckn;
	wire hw_ram_cke;
	wire hw_ram_odt;
	wire [12:0] hw_ram_ad;

	// Bidirs
	wire hw_ram_udqs_p;
	wire hw_ram_udqs_n;
	wire hw_ram_ldqs_p;
	wire hw_ram_ldqs_n;
	wire [15:0] hw_ram_dq;
	wire hw_rzq_pin;
	wire hw_zio_pin;

	// Instantiate the Unit Under Test (UUT)
	memory_unit_top uut (
		.clk_100mhz(clk_100mhz), 
		.rst(rst), 
		.op_code(op_code), 
		.message_id(message_id), 
		.audio_in(audio_in), 
		.audio_out(audio_out), 
		.ram_clock_out(ram_clock_out), 
		.hw_ram_rasn(hw_ram_rasn), 
		.hw_ram_casn(hw_ram_casn), 
		.hw_ram_wen(hw_ram_wen), 
		.hw_ram_ba(hw_ram_ba), 
		.hw_ram_udqs_p(hw_ram_udqs_p), 
		.hw_ram_udqs_n(hw_ram_udqs_n), 
		.hw_ram_ldqs_p(hw_ram_ldqs_p), 
		.hw_ram_ldqs_n(hw_ram_ldqs_n), 
		.hw_ram_udm(hw_ram_udm), 
		.hw_ram_ldm(hw_ram_ldm), 
		.hw_ram_ck(hw_ram_ck), 
		.hw_ram_ckn(hw_ram_ckn), 
		.hw_ram_cke(hw_ram_cke), 
		.hw_ram_odt(hw_ram_odt), 
		.hw_ram_ad(hw_ram_ad), 
		.hw_ram_dq(hw_ram_dq), 
		.hw_rzq_pin(hw_rzq_pin), 
		.hw_zio_pin(hw_zio_pin)
	);

	initial begin
		// Initialize Inputs
		clk_100mhz = 0;
		rst = 0;
		op_code = 0;
		message_id = 0;
		audio_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		

	end
      
	always begin
		#10 clk_100mhz = ~clk_100mhz;
	end
endmodule

