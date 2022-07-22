module DEC_INPUT_KEY(
	input input_key,
	input valid_cmd,
	input reset,
	input clk,
	output active,
	output mode);

	localparam IDLE = 3'b 000;
	localparam S1 = 3'b 001;
	localparam S2 = 3'b 011;
	localparam S3 = 3'b 010;
	localparam S4 = 3'b 110;
	localparam S5 = 3'b 111;
	localparam S6 = 3'b 101;


	wire s0 , s1 , s2 ;
	wire s0v, s1v, s2v;

	assign s2v = ~s2 & s1 & ~s0 & valid_cmd & ~input_key | s2 & s1 & ~s0 & valid_cmd | s2 & s0;
	assign s1v = ~s2 & ~s1 & s0 & valid_cmd & ~input_key | ~s2 & s1 & s0 & valid_cmd & input_key | s1 & ~s0 & valid_cmd & ~input_key | s2 & s1 & s0;
	assign s0v = ~s2 & ~s1 & ~s0 & valid_cmd & input_key | ~s2 & ~s1 & s0 & valid_cmd & ~input_key | s2 & s1 & ~s0 & valid_cmd | s2 & s0;

	dff d0(clk, reset, s0v, s0);
	dff d1(clk, reset, s1v, s1);
	dff d2(clk, reset, s2v, s2);

	assign mode = s2 & ~s1 & s0;
	assign active = s2 & s0;

endmodule
