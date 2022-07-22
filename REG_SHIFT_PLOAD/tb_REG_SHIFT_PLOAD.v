module tb_REG_SHIFT_PLOAD;

	reg [31:0] Din;
	reg p_load;
	reg start_tx;
	reg reset;
	reg clk;
	reg clk_tx;
	wire tx_done;
	wire tx_busy;
	wire Dout;

	REG_SHIFT_PLOAD DUT (Din, p_load, start_tx, reset, clk, clk_tx, tx_done, tx_busy, Dout);

	initial begin

		$dumpvars(0,tb_REG_SHIFT_PLOAD);
    	$dumpfile("my.vcd");

		clk = 0;
		forever
			#5 clk = ~clk;

	end

	initial begin

		clk_tx = 0;
		forever
			#10 clk_tx = ~clk_tx;

	end

	initial begin

		reset = 1;
		#5
		display;

		reset = 0;
		Din = 32'hF0F0FF0F;
		p_load = 1'b1;
		start_tx = 1'b0;
		#15
		display;

		p_load = 1'b0;
		start_tx = 1'b1;
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

		#650
		$finish;

	end
		
		task display;
		$display("r = %0h, clk = %0h, clk_tx = %0h, Din = %0h, p_load = %0h, start_tx = %0h, tx_done = %0h, tx_busy = %0h, Dout = %0h,", reset, clk, clk_tx, Din, p_load, start_tx, tx_done, tx_busy, Dout);
	endtask



endmodule


