module MEMORY #(parameter WIDTH = 8)
    (input [31:0] Din,
    input [7:0] Addr,
    input rw,
    input Valid,
    input reset,
    input clk,
    output reg [31:0] Dout);

    integer pos;

    reg [31:0] Mem [0:(8'b1<<WIDTH)-1];

    always @(posedge clk, posedge reset) begin

        if(reset) begin

            for(pos = 0; pos < (8'b1<<WIDTH); pos = pos+1)
                Mem[pos] <= 32'h0;
            
            Dout <= 32'h0;

        end else begin

            if(Valid) begin
                if(rw) begin
                    Mem[Addr] <= Din;
                    Dout <= {32{1'bz}};
                end
                else
                    Dout <= Mem[Addr];
            end
            else
                    Dout <= {32{1'bz}};
        end

    end

endmodule
