module tb_DIV_FREQ;

	reg [31:0] Din;
	reg conf_div;
	reg ctrl_tr_dat;
	reg reset;
	reg clk;
	wire clk_out;

	DIV_FREQ DUT (Din, conf_div, ctrl_tr_dat, reset, clk, clk_out);

	initial begin

		$dumpvars(0,tb_DIV_FREQ);
    	$dumpfile("my.vcd");

		clk = 0;
		forever
			#5 clk = ~clk;

	end

	initial begin

		reset = 1;
		#5
		display;

		reset = 0;
		Din = 32'h3;
		ctrl_tr_dat = 1;
		#5
		display;
		#5
		display;
		#5
		display;
		#5
		display;
		#5
		display;
		#5
		display;
		#5
		display;
		#5
		display;
		#5
		display;
		#5
		display;

		reset = 1;
		ctrl_tr_dat = 0;
		#5
		display;

		reset = 0;
		Din = 32'h2;
		conf_div = 1;
		#5
		display;
		#5

		conf_div = 0;
		Din = 32'h3;
		display;
		#5
		display;
		#5
		display;
		#5
		display;
		#5
		display;
		#5
		display;
		#5
		display;


		#5
		display;
		#5
		display;
		#5
		display;
		#5
		display;
		#5
		display;

		#300
		$finish;
	end



	task display;
		$display("r = %0h, clk = %0h, clk_out = %0h, Din = %0h, conf_div = %0h, ctrl_tr_dat = %0h, ", reset, clk, clk_out, Din, conf_div, ctrl_tr_dat);
	endtask

endmodule
