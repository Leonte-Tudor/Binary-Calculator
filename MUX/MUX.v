module MUX #(parameter WIDTH = 8)
	(input [WIDTH-1:0] in,
	input reset,
	output [WIDTH-1:0] out);

	always @(*) begin

		case (reset)
			1'b0: out = in;
			1'b1: out = (WIDTH-1)'b0;
			default: out = (WIDTH-1)'bx ;
		endcase

	end

endmodule

