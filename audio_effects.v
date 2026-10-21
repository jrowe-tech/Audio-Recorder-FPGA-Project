module audio_effects (
    input  clk,
    input  sample_end,
    input  sample_req,
    output [15:0] audio_output,
    input  [15:0] audio_input,
	 input play_recording
);

reg [15:0] romdata [0:99];
reg [6:0]  index = 7'd0;
reg [15:0] last_sample;
reg [15:0] dat;

assign audio_output = dat;

always @(posedge clk) begin
    if (sample_end) begin
        last_sample <= audio_input;
    end

    if (sample_req) begin
		  if (play_recording) begin
            dat <= last_sample;
        end else begin
            dat <= 16'd0;
		  end
    end
end

endmodule
