module DIV_FREQ(
	input [31:0] Din,
	input conf_div,
	input enable,
	input reset,
	input clk,
	output reg clk_out
);

	reg [31:0] t = 32'h1;
	reg [31:0] count = 32'h0;
	reg [31:0] pos_count = 32'h0;
	reg [31:0] neg_count = 32'h0;

	always @(posedge clk, posedge reset) begin

		if(reset) begin

			t <= 32'h1;
			clk_out <= clk;
			pos_count <= 32'h0;

		end

		else begin

			
			if(!enable) begin

				clk_out <= 0;

			  if(pos_count == t-1) 
				  pos_count <= 0;
			  else pos_count <= pos_count + 1;

				if(!conf_div) begin
					
					if(t == 1)
						clk_out <= clk;

					if(t == (t / 2 * 2)) begin

					//clk_out <= t * clk
					count <= count + 32'h1;
					if(count >= (t - 1))
						count <= 32'h0;
					clk_out <= (count < t / 2) ? 1'b1 : 1'b0;

					end

			end

				else
					t <= Din;
		end


			else begin

			  if(pos_count == Din-1) 
				  pos_count <= 0;
			  else pos_count <= pos_count + 1;

			  if(Din == 1)
				  clk_out <= clk;

					if(Din == (Din / 2 * 2)) begin

					//clk_out <= Din * clk;
					count <= count + 32'h1;
					if(count >= (Din - 1))
						count <= 32'h0;
					clk_out <= (count < Din / 2) ? 1'b1 : 1'b0;

					end

			end

		end

	end
			
	always @(negedge clk, posedge reset) begin

		if(reset) begin

			t <= 32'h1;
			clk_out <= clk;
			neg_count <= 32'h0;

		end

		else begin

			  if(Din == 1)
				  clk_out <= clk;

			  if(t == 1)
				  clk_out <= clk;

			if (!enable && neg_count == t - 1)
				neg_count <= 0;
			else if(!enable) neg_count <= neg_count + 1;

			if (enable && neg_count == Din - 1)
				neg_count <= 0;
			else if(enable) neg_count <= neg_count + 1;

			end
	end

	always @(pos_count, neg_count) begin

		if(!reset) begin

			if(!enable)
				if(t != t / 2 * 2)
					clk_out <= ((pos_count > (t >> 1)) | (neg_count > (t >> 1)));

			if(enable)
				if(Din != Din / 2 * 2)
					clk_out <= ((pos_count > (Din >> 1)) | (neg_count > (Din >> 1))); 

		end

	end




	//assign clk_out = ((t != t / 2 * 2)) ? ((!enable) ? ((pos_count > (t >> 1)) | (neg_count > (t >> 1))) : ((pos_count > (Din >> 1)) | (neg_count > (Din >> 1)))) : clk_out;

endmodule
