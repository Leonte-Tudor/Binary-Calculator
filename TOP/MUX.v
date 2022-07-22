module MUX #(parameter WIDTH = 8)
    (input [WIDTH-1:0] in_1,
    input [WIDTH-1:0] in_2,
    input sel,
    output reg [WIDTH-1:0] out);

    always @(*) begin

        case (sel)
            1'b0: out = in_1;
            1'b1: out = in_2;
            default: out = {WIDTH{1'bx}};
        endcase

    end

endmodule

