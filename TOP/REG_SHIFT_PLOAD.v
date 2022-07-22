module REG_SHIFT_PLOAD(
    input [31:0] Din,
    input p_load,
    input start_tx,
    input reset,
    input clk,
    input clk_tx,
    output reg tx_done,
    output reg tx_busy,
    output reg Dout
);

    integer pos = 0;
    reg [31:0] buffer;
    reg r_v;

    always @(posedge clk, posedge reset) begin

        if(reset) begin

            buffer <= 32'h0;
            pos <= 1'b0;
            tx_busy <= 1'b0;
            tx_done <= 1'b0;
            Dout <= 1'bz;

        end

        else begin

            if(p_load && !start_tx && clk) begin

                r_v <= 1'b1;

                for(pos = 0; pos < 32; pos = pos + 1)
                    if(Din [pos] == 1'bz || Din [pos] == 1'bx)
                        r_v <= 1'b0;

                if(r_v)
                buffer <= Din;

            pos <= 0;

            end


        end


    end


    always @(posedge clk_tx, posedge reset) begin

        if(reset) begin

            buffer <= 32'h0;
            pos <= 1'b0;
            tx_busy <= 1'b0;
            tx_done <= 1'b0;

        end

        else begin

            if(!p_load && r_v && pos <= 32) begin

                if(pos < 31) begin
                    tx_busy <= 1'b1;
                    Dout <= buffer [pos];
                end

                if(pos == 31) begin
                    tx_done <= 1'b1;
                end

                if(pos == 32) begin
                    tx_done <= 1'b0;
                    tx_busy <= 1'b0;
                    Dout <= 1'bz;
                end

                pos <= pos + 1;

            end


        end

    end

endmodule

