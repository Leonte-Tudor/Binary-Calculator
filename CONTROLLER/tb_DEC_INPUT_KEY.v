module tb_DEC_INPUT_KEY;

	reg input_key;
	reg valid_cmd;
	reg reset;
	reg clk;
	wire active;
	wire mode;

	DEC_INPUT_KEY DUT (input_key, valid_cmd, reset, clk, active, mode);

	initial begin

                $dumpvars(0, tb_DEC_INPUT_KEY);
                $dumpfile("my.vcd");

                clk = 0;
                forever
                        #5 clk = ~clk;

        end

	
	initial begin

		reset = 1;
		valid_cmd = 0;
		input_key = 0;
		#4
		display;

		reset = 0;
		valid_cmd = 1;
		input_key = 1;
		#12
		display;

		valid_cmd = 1;
		input_key = 0;
		#12
		display;

		valid_cmd = 1;
		input_key = 1;
		#12
		display;

		valid_cmd = 1;
		input_key = 0;
		#12
		display;

		valid_cmd = 1;
		input_key = 1;
		#12
		display;

		valid_cmd = 1;
		input_key = 0;
		#12
		display;

		#300
		$finish;

	end


	task display;
		$display("reset = %0h, clk = %0h, valid = %0h, in = %0h, active = %0h, mode = %0h", reset, clk, valid_cmd, input_key, active, mode);
	endtask

endmodule

