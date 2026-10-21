`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:22:04 05/09/2025 
// Design Name: 
// Module Name:    switch_top 
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
module switch_top(
	input [7:0] SW,
	input [3:1] BTN,
	input CLK,
	input reset,
	output [7:0] LED,
	output debug_CLK,
	output debug_RAMCLK,
	
	// RAM IC I/O
	output hw_ram_rasn, hw_ram_casn, hw_ram_wen,
	output [2:0] hw_ram_ba,
	inout hw_ram_udqs_p, hw_ram_udqs_n,
	inout hw_ram_ldqs_p, hw_ram_ldqs_n,
	output hw_ram_udm, hw_ram_ldm,
	output hw_ram_ck, hw_ram_ckn,
	output hw_ram_cke, hw_ram_odt,
	output [12:0] hw_ram_ad,
	inout [15:0] hw_ram_dq,
	inout hw_rzq_pin, hw_zio_pin,
	
	// CODEC IC I/O
	inout  AUD_ADCLRCK,
	input  AUD_ADCDAT,

	inout  AUD_DACLRCK,
	output AUD_DACDAT,

	output AUD_XCK,
	inout  AUD_BCLK,

	output AUD_I2C_SCLK,
	inout  AUD_I2C_SDAT,

	output AUD_MUTE
	);
	
	
	// GENERAL I/O, REGS, WIRES
	wire CLK1;
	wire CLK2;
	wire ram_clock_out;
	reg [7:0] leds;
	assign debug_CLK = CLK1;
	assign debug_RAMCLK = ram_clock_out;
	
	
	// IMPORTANT!!! CLOCK SETUP ACCORDING TO PROJECT INSTRUCTIONS
	clk_converter clk_converter(
		.CLK_IN1(ram_clock_out),
		.RESET(reset),
		.CLK_OUT1(CLK1),
		.CLK_OUT2(CLK2)
	);
	
	wire [2:0] mem_op_code;
	wire [15:0] audio_input;
	wire [15:0] ram_audio_output;
	wire [1:0] message_id;
	wire slow_mem_clk;
	assign slow_mem_clk = audio_clock;
	// 001=Play, 010=Record, 011=Delete One, 100=Delete All
	// 000 OR UNDEFINED -> IDLE
	memory_unit_top RAM (
		.CLK(CLK),
		.reset(reset),
		.op_code(mem_op_code),
		.message_id(message_id),
		.audio_in(audio_input),
		.audio_out(ram_audio_output),
		.ram_clock_out(ram_clock_out),
		.slow_mem_clk(slow_mem_clk),
		
		// Physical IC Connections (FROM UCF FILE)
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
		
	wire play_recording;
	wire audio_clock;
	audio_top AUDIO(
		.clk100(CLK2),
		.reset(reset),
		.audio_in(audio_input),
		.ram_audio_out(ram_audio_output),
		.play_recording(play_recording),
		.audio_clock(audio_clock),
		.AUD_ADCLRCK(AUD_ADCLRCK),
		.AUD_ADCDAT(AUD_ADCDAT),
		.AUD_DACLRCK(AUD_DACLRCK),
		.AUD_DACDAT(AUD_DACDAT),
		.AUD_XCK(AUD_XCK),
		.AUD_BCLK(AUD_BCLK),
		.AUD_I2C_SCLK(AUD_I2C_SCLK),
		.AUD_I2C_SDAT(AUD_I2C_SDAT),
		.AUD_MUTE(AUD_MUTE)
	);
	
	reg volume_setting;
	reg [7:0] volume;
	reg [7:0] counter;
	
	reg [2:0] op_code;
	assign mem_op_code = op_code;
	
	reg [1:0] current_message;
	assign message_id = current_message;
	
	//assign LED = audio_input[15:8];
	assign LED = leds;
	reg writing_data;
	//assign ram_audio_output = audio_input;
	
	reg play_audio;
	assign play_recording = play_audio;
	initial begin
		volume_setting <= 1'b0;
		volume <= 8'h00;
		leds <= 8'h11;
		op_code <= 3'b000;
		current_message <= 2'b00;
		writing_data <= 1'b0;
	end
	
	always@(posedge CLK1) begin
		if (reset) begin
			volume_setting <= 1'b0; 
			leds <= 8'h00;
			op_code <= 3'b000;
			play_audio <= 1'b0;
			writing_data <= 1'b0;
			current_message <= 2'b00;
		end else begin
			current_message <= SW[7:6];
			if (!volume_setting) begin
				case (SW[4:0])
					5'b00001: begin
						// PLAY MESSAGE
						op_code <= 3'b010; 
						leds <= ram_audio_output[15:8];
						play_audio <= 1'b1;
					end
					5'b00010: begin
						play_audio <= 1'b0;
						// Record Message -> BTN[3] - RECORD NEW MESSAGE
						if (BTN[3]) begin
							op_code <= 3'b001;
							leds <= audio_input[15:8];//ram_audio_output[15:8];
						end else begin
							op_code <= 3'b000;
							leds <= 8'h00;
						end
					end
					5'b00100: begin
						play_audio <= 1'b0;
						// Delete First Message
						op_code <= 3'b011;
					end
					5'b01000: begin
						play_audio <= 1'b0;
						// Delete All Messages
						op_code <= 3'b100;
						leds <= 8'h08;
					end
					5'b10000: begin
						play_audio <= 1'b0;
						// Volume Control
						op_code <= 3'b000;
						volume_setting <= 1'b1;
					end
					default: begin
						play_audio <= 1'b0;
						op_code <= 3'b000;
						leds <= 8'h00;
					end
				endcase
			end else begin
				// Set the volume here (=
				if (BTN[3]) begin
					volume_setting <= 1'b0;
				end else begin
					leds <= ~SW;
					volume <= SW;
				end
			end
		end
	end
	

endmodule
