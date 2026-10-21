`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:14:10 05/09/2025
// Design Name:   switch_top
// Module Name:   /home/ise/Desktop/CDA4203L/FINAL_PROJECT/FINAL_PROJECT/test_switch_top.v
// Project Name:  FINAL_PROJECT
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: switch_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_switch_top;

	// Inputs
	reg [7:0] SW;
	reg [3:0] BTN;
	reg CLK;
	reg reset;
	reg AUD_ADCDAT;

	// Outputs
	wire [7:0] LED;
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
	wire AUD_DACDAT;
	wire AUD_XCK;
	wire AUD_I2C_SCLK;
	wire AUD_MUTE;

	// Bidirs
	wire hw_ram_udqs_p;
	wire hw_ram_udqs_n;
	wire hw_ram_ldqs_p;
	wire hw_ram_ldqs_n;
	wire [15:0] hw_ram_dq;
	wire hw_rzq_pin;
	wire hw_zio_pin;
	wire AUD_ADCLRCK;
	wire AUD_DACLRCK;
	wire AUD_BCLK;
	wire AUD_I2C_SDAT;
	wire debug_CLK;
	wire debug_RAMCLK;

	// Instantiate the Unit Under Test (UUT)
	switch_top uut (
		.SW(SW), 
		.BTN(BTN), 
		.CLK(CLK), 
		.reset(reset), 
		.LED(LED), 
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
		.hw_zio_pin(hw_zio_pin), 
		.AUD_ADCLRCK(AUD_ADCLRCK), 
		.AUD_ADCDAT(AUD_ADCDAT), 
		.AUD_DACLRCK(AUD_DACLRCK), 
		.AUD_DACDAT(AUD_DACDAT), 
		.AUD_XCK(AUD_XCK), 
		.AUD_BCLK(AUD_BCLK), 
		.AUD_I2C_SCLK(AUD_I2C_SCLK), 
		.AUD_I2C_SDAT(AUD_I2C_SDAT), 
		.AUD_MUTE(AUD_MUTE),
		.debug_CLK(debug_CLK),
		.debug_RAMCLK(debug_RAMCLK)
	);

	initial begin
		// Initialize Inputs
		SW = 0;
		BTN = 0;
		CLK = 0;
		reset = 0;
		AUD_ADCDAT = 0;

		// Wait 100 ns for global reset to finish
		#1000;
        
		// Add stimulus here
		SW = 8'b00000010;

	end
	
	always begin
		#10 CLK = ~CLK;
	end
      
endmodule

