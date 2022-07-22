module CONTROL_RW_FLOW(
	input valid_cmd,
	input rw,
	input active,
	input mode,
	input tx_done,
	input reset,
	input clk,
	output reg ac_mem,
	output reg rw_mem,
	output reg p_load,
	output reg tx_dat,
	output reg busy);


	localparam IDLE = 3'b 000;
	localparam S1 = 3'b 001;
	localparam S2 = 3'b 011;
	localparam S3 = 3'b 010;
	localparam S4 = 3'b 110;
	localparam S5 = 3'b 111;
	localparam S6 = 3'b 101;

	reg [2:0] s_c;
	reg [2:0] s_v;

	always @(valid_cmd, rw, active, mode, tx_done, s_c)

		case(s_c)

			IDLE:
				if(valid_cmd == 1 & rw == 0 & active == 1 & mode == 1 & tx_done == 1)
					s_v = S1;
				else if(valid_cmd == 1 & rw == 1 & active == 1 & mode == 1)
					s_v = S4;
				else if(valid_cmd == 1 & active == 1 & mode == 0 & tx_done == 1)
					s_v = S5;

			S1:
				if(active == 1 & mode == 1 & tx_done == 1)
					s_v = S2;
				else
					s_v = IDLE;

			S2:
				if(active == 1 & mode == 1)
					s_v = S3;
				else
					s_v = IDLE;

			S3:
				if(active == 1 & mode == 1 & tx_done == 0)
					s_v = S3;
				else
					s_v = IDLE;

			S4:
				s_v = IDLE;

			S5:
				if(active == 1 & mode == 0)
					s_v = S6;
				else
					s_v = IDLE;

			S6:
				if(active == 1 & mode == 0 & tx_done)
					s_v = S6;
				else
					s_v = IDLE;

			default:
				s_v = IDLE;
		endcase


	always @(posedge clk, posedge reset) begin

		if(reset) s_c <= IDLE;
		else s_c <= s_v;

	end

	always @(s_c)

		case(s_c)

			IDLE:
			begin ac_mem = 0; rw_mem = 0; p_load = 0; tx_dat = 0; busy = 0; end

			S1:
			begin ac_mem = 1; rw_mem = 0; p_load = 0; tx_dat = 0; busy = 1; end

			S2:
			begin ac_mem = 0; rw_mem = 0; p_load = 1; tx_dat = 1; busy = 1; end

			S3:
			begin ac_mem = 0; rw_mem = 0; p_load = 0; tx_dat = 0; busy = 1; end

			S4:
			begin ac_mem = 1; rw_mem = 1; p_load = 0; tx_dat = 0; busy = 0; end

			S5:
			begin ac_mem = 0; rw_mem = 0; p_load = 1; tx_dat = 1; busy = 1; end

			S1:
			begin ac_mem = 0; rw_mem = 0; p_load = 0; tx_dat = 0; busy = 1; end

		endcase

endmodule
