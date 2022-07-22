module testbench_MEMORY;
	parameter WIDTH = 8;
	reg [31:0] Din;
	reg [7:0] Addr;
	reg rw;
	reg Valid;
	reg reset;
	reg clk;
	wire [31:0] Dout;

	MEMORY DUT (Din, Addr, rw, Valid, reset, clk, Dout);

	initial begin

		$dumpvars(0, testbench_MEMORY);
		$dumpfile("my.vcd");

		clk = 0;
		forever
			#5 clk = ~clk;

	end

	initial begin 

		reset = 1;
		Din = 32'h5;
		Addr = 8'h0;
		#5
		display;

		reset = 0;
		Valid = 1;
		rw = 1;
		Din = 32'h5;
		Addr = 8'h0;
		#5
		display;

		rw = 1;
		Din = 32'h5;
		Addr = 8'h0;
		#5
		display;

		rw = 0;
		Din = 32'h5;
		Addr = 8'h0;
		#5
		display;

		rw = 1;
		Din = 32'h5;
		Addr = 8'h0;
		#5
		display;

		Valid = 0;
		rw = 1;
		Din = 32'h5;
		Addr = 8'h0;
		#5
		display;

		Valid = 1;
		rw = 1;
		Din = 32'hF00;
		Addr = 8'h2C;
		#5
		display;

		rw = 0;
		Din = 32'hF00;
		Addr = 8'h2C;
		#5
		display;

		rw = 1;
		Din = 32'hF00;
		Addr = 8'h2C;
		#13
		display;

		rw = 0;
		Din = 32'hF00;
		Addr = 8'h2C;
		#5
		display;



		#270
		$finish;
		end
	
	task display;
		$display("reset = %0h, clk = %0h, valid = %0h, rw = %0h, Din = %0h, Addr = %0h, Dout = %0h", reset, clk, Valid, rw, Din, Addr, Dout);
	endtask

endmodule
