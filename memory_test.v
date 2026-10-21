`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:40:54 05/09/2025 
// Design Name: 
// Module Name:    memory_test 
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
module memory_test(
	input [7:0] SW,
	input [3:1] BTN,
	input CLK,
	input reset,
	input slow_mem_clk,
	input [1:0] message_id,
	//input [1:0] message_id,
	output [7:0] LED,
	output hw_ram_rasn, hw_ram_casn, hw_ram_wen,
	output [2:0] hw_ram_ba,
	inout hw_ram_udqs_p, hw_ram_udqs_n,
	inout hw_ram_ldqs_p, hw_ram_ldqs_n,
	output hw_ram_udm, hw_ram_ldm,
	output hw_ram_ck, hw_ram_ckn,
	output hw_ram_cke, hw_ram_odt,
	output [12:0] hw_ram_ad,
	inout [15:0] hw_ram_dq,
	inout hw_rzq_pin, hw_zio_pin
    );
		
	reg 	[25:0] address = 0;
	reg 	[7:0]	RAMin;
	wire 	[7:0]	RAMOut;
	reg	[7:0] dataOut; 
	reg 			enableWrite;
	reg 			ackRead = 0;
	reg 			reqRead;
	wire 			systemCLK;
	
	wire rdy, 	dataPresent;
	wire [25:0]	max_ram_address;

	wire [7:0] data_in = test_data;
	reg [7:0] test_data;
	
	reg [7:0] leds;
	assign LED = leds;
	reg write_state;
	reg read_state;
	reg [25:0] write_address;
	reg [25:0] read_address;
	
	
	initial begin
		message_address <= 0;
		write_address[25:24] <= message_id;
		read_address <= 0;
	end
	
	always @ (posedge slow_mem_clk) begin
		if (reset) begin
			write_state <= 1'b0;
			read_state <= 1'b0;
			write_address[27:0] <= 0;
			read_address[27:0] <= 0;
			read_address[29:28] <= message_id;
			write_address[29:28] <= message_id;
		end else begin
			RAMin <= test_data;
			
			case (SW[7:6])
				2'b00: begin
					test_data <= 8'b10101010;
				end
				2'b01: begin
					test_data <= 8'b00110011;
				end
				2'b10: begin
					test_data <= 8'b10110100;
				end
				2'b11: begin
					test_data <= 8'b01001011;
				end
			endcase
			
			case (SW[1:0])
				2'b01: begin
					if (rdy) begin
						ackRead <= 1'b0;
						if (!write_state) begin
							enableWrite <= 1'b0;
						end else begin
							enableWrite <= 1'b1;
							
							if (write_address[23:0] != 24'hFFFFFF) begin
								leds <= test_data;
								write_address <= write_address + 1;
								address <= write_address;
							end else begin
								leds <= 8'b00000000;
							end
						end
						
						write_state <= ~write_state;
					end
				end
				2'b10: begin
					if (rdy) begin
						leds <= RAMOut;
						enableWrite <= 1'b0;
						if (!read_state) begin
							reqRead <= 1'b1;
							ackRead <= 1'b0;
						end else begin
							reqRead <= 1'b0;
							if (dataPresent) begin
								leds <= RAMOut;
								ackRead <= 1'b1;
								
								if (read_address[23:0] != 24'hFFFFFF) begin
									read_address <= read_address + 1;
									address <= read_address;
								end
							end
						end
						
						read_state <= ~read_state;
					end
				end
				default: begin
					ackRead <= 1'b0;
					read_address[23:0] <= 0;
					write_address[23:0] <= 0;
					read_address[25:24] <= message_id;
					write_address[25:24] <= message_id;
					leds <= write_address;
				end
				// DONT FORGET TO RESET ADDRESS MUHFUCKER
				
			endcase
		end
	end
	
	// ram interface instantiation
	ram_interface_wrapper RAMRapper (
					.address(address),				// input 
					.data_in(RAMin), 					// input
					.write_enable(enableWrite), 	//	input
					.read_request(reqRead), 		//	input
					.read_ack(ackRead), 
					.data_out(RAMOut), 				// output from ram to wire
					.reset(reset), 
					.clk(CLK), 
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
					.clkout(systemCLK), 
					.sys_clk(systemCLK), 
					.rdy(rdy), 
					.rd_data_pres(dataPresent),
					.max_ram_address(max_ram_address)
					);		
					
assign status = rdy; // ready signal from ram

endmodule
