module M_ALU(

	input [7:0] A,
	input [7:0] B,
	input [3:0] SEL_TMP,
	output reg [7:0] ALU_OUT_TMP,
	output reg [3:0] FLAG_TMP

);

reg zf = 1'b0;
reg cf = 1'b0;
reg of = 1'b0;
reg uf = 1'b0;
reg [7:0] neg;

always @(*) begin

zf = 1'b0;
cf = 1'b0;
of = 1'b0;
uf = 1'b0;

	case(SEL_TMP)

		4'h0:

			{cf, ALU_OUT_TMP} = A + B;
		
		4'h1: begin

			if(A < B)
				uf = 1;

			neg = ~B + 1;

			ALU_OUT_TMP = A + neg;

			end

		4'h2: begin

			if(A > 8'hF && B > 8'hF)
				of = 1;

			ALU_OUT_TMP = A * B;

		end

		4'h3: begin

			if(A < B)
				uf = 1;

			ALU_OUT_TMP = A / B;

		end

		4'h4: begin

			{cf, ALU_OUT_TMP} = A << B;

		end

		4'h5: begin

			{ALU_OUT_TMP, cf} = A >> B;

		end

		4'h6:

			ALU_OUT_TMP = A & B;

		4'h7:

			ALU_OUT_TMP = A | B;

		4'h8:

			ALU_OUT_TMP = A ^ B;

		4'h9:

			ALU_OUT_TMP = A ~^ B;

		4'hA:

			ALU_OUT_TMP = A ~& B;

		4'hB:

			ALU_OUT_TMP = A ~| B;

		default: begin

			ALU_OUT_TMP = 8'h00;
			FLAG_TMP = 4'h0;

		end

	endcase

	if(ALU_OUT_TMP == 0 && SEL_TMP <= 4'hB)

		zf = 1;

	FLAG_TMP = {uf, of, cf, zf};


end


endmodule
