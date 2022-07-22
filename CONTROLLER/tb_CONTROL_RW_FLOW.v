module tb_CONTROL_RW_FLOW;

	reg valid_cmd;
	reg rw;
	reg active;
	reg mode;
	reg tx_done;
	reg reset;
	reg clk;
	wire ac_mem;
	wire rw_mem;
	wire p_load;
	wire tx_dat;
	wire busy;

	CONTROL_RW_FLOW DUT (valid_cmd, rw, active, mode, tx_done, reset, clk, ac_mem, rw_mem, p_load, tx_dat, busy);

	initial begin

		$dumpvars(0,tb_CONTROL_RW_FLOW);
    	$dumpfile("my.vcd");

		clk = 0;
		forever
			#5 clk = ~clk;

	end

	initial begin
		
		#5

		reset = 1;
		#5
		display;

		reset = 0;
		valid_cmd = 1;
		rw = 0;
		active = 1;
		mode = 1;
		tx_done = 1;
		#5
		display;

		valid_cmd = 1;
		rw = 0;
		active = 1;
		mode = 1;
		tx_done = 1;
		#5
		display;

		valid_cmd = 1;
		rw = 0;
		active = 1;
		mode = 1;
		tx_done = 1;
		#5
		display;

		valid_cmd = 1;
		rw = 0;
		active = 1;
		mode = 1;
		tx_done = 1;
		#5
		display;

		valid_cmd = 1;
		rw = 0;
		active = 1;
		mode = 1;
		tx_done = 1;
		#5
		display;

		valid_cmd = 1;
		rw = 0;
		active = 1;
		mode = 1;
		tx_done = 0;
		#5
		display;

		valid_cmd = 1;
		rw = 0;
		active = 1;
		mode = 1;
		tx_done = 0;
		#5
		display;

		valid_cmd = 1;
		rw = 0;
		active = 1;
		mode = 1;
		tx_done = 0;
		#4
		display;

		valid_cmd = 1;
		rw = 0;
		active = 1;
		mode = 1;
		tx_done = 0;
		#5
		display;

		valid_cmd = 1;
		rw = 0;
		active = 1;
		mode = 1;
		tx_done = 1;
		#5
		display;

		valid_cmd = 1;
		rw = 1;
		active = 1;
		mode = 1;
		tx_done = 1;
		#5
		display;

		valid_cmd = 1;
		rw = 1;
		active = 1;
		mode = 1;
		tx_done = 1;
		#5
		display;



		#300
		$finish;


	end

	task display;
		$display("r=%0b, clk=%0b, valid=%0b, rw=%0b, active=%0b, mode=%0b, tx_done=%0b, ac_mem=%0b, rw_mem=%0b, p_load=%0b, tx_dat=%0b, busy=%0b",
             reset, clk, valid_cmd, rw, active, mode, tx_done, ac_mem, rw_mem, p_load, tx_dat, busy);
  	endtask

endmodule
