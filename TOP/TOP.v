/*
'include "./CONTROL_RW_FLOW.v"
'include "./DEC_INPUT.v"
'include "./dff.v"
'include "./DIV_FREQ.v"
'include "./M_ALU.v"
'include "./MEMORY.v"
'include "./MUX.v"
'include "./REG_SHIFT_PLOAD.v"
*/

module TOP;

    reg [7:0] in_a;
    reg [7:0] in_b;
    reg [3:0] sel;
    reg input_key;
    reg valid_cmd;
    reg rw;
    reg [7:0] addr;
    reg conf_div;
    reg [31:0] Din;
    reg reset;
    wire reset_tmp;
    reg clk;
    wire calc_active;
    wire calc_mode;
    wire busy;
    wire Dout_valid;
    wire Dout;
    wire clk_tx;

    assign reset_tmp = (~calc_active) & reset;
    assign rw_tmp = (calc_active) & rw;

    wire [7:0] m1_out;
    wire [7:0] m2_out;
    wire [3:0] m3_out;
    MUX m1(in_a, 8'b0, reset_tmp, m1_out);
    MUX m2(in_b, 8'b0, reset_tmp, m2_out);
    MUX #(.WIDTH (4)) m3 (sel, 4'b0, reset_tmp, m3_out);

    wire [7:0] alu_out_tmp;
    wire [3:0] flag_tmp;
    M_ALU m_alu (m1_out, m2_out, m3_out, alu_out_tmp, flag_tmp);

    wire [31:0] data_tmp;
    CAT_32 buffer(m1_out, m2_out, alu_out_tmp, flag_tmp, m3_out,data_tmp);

    DEC_INPUT_KEY dec_input_key(input_key, valid_cmd,reset, clk, calc_active, calc_mode);

    wire tx_done;
    wire ctrl_ac_mem;
    wire ctrl_rw_mem;
    wire p_load;
    wire tx_dat;
    CONTROL_RW_FLOW control_rw_flow(valid_cmd, rw_tmp, calc_active, calc_mode, tx_done, reset, clk, ctrl_ac_mem, ctrl_rw_mem, p_load, tx_dat, busy);

    wire [31:0] D_OUT;
    MEMORY memory(data_tmp, addr, ctrl_rw_mem, ctrl_ac_mem, reset_tmp, clk, D_OUT);

    wire [31:0] m4_out;
    MUX #(.WIDTH(32)) m4 (data_tmp, D_OUT, calc_mode, m4_out);

    DIV_FREQ div_freq(Din, conf_div, tx_dat, reset_tmp, clk, clk_tx);

    REG_SHIFT_PLOAD reg_shift_pload (m4_out, p_load, tx_dat, reset_tmp, clk, clk_tx, tx_done, Dout_valid, Dout);


    initial begin

        $dumpvars(0,TOP);
        $dumpfile("my.vcd");

        clk = 0;
        forever
        #5 clk = ~clk;


    end

    initial begin

        /*
        reset = 1;
        Din = 2;
        conf_div = 1'b1;
        valid_cmd = 1'b1;
        input_key = 1'b0;
        rw = 1'b1;
        #15

        reset = 0;
        valid_cmd = 1'b1;
        #14

        input_key = 1'b1;
        #10
        input_key = 1'b0;
        #10
        input_key = 1'b1;
        #10
        input_key = 1'b0;
        #10
        //input_key = 1'b1;
        #10
        input_key = 1'b0;
        conf_div = 1'b0;
        #10

        in_a = 8'hFF;
        in_b = 8'h1;
        sel = 4'h0;
        #700
        
        in_a = 8'h1F;
        in_b = 8'h1F;
        sel = 4'h2;
        #15
        */
        
        reset = 1;
        Din = 1;
        conf_div = 1'b1;
        valid_cmd = 1'b1;
        input_key = 1'b0;
        rw = 1'b1;
        #15

        reset = 0;
        valid_cmd = 1'b1;
        #14

        input_key = 1'b1;
        #10
        input_key = 1'b0;
        #10
        input_key = 1'b1;
        #10
        input_key = 1'b0;
        #10
        input_key = 1'b1;
        #10
        input_key = 1'b0;
        conf_div = 1'b0;
        #10

        addr = 8'h0;
        in_a = 8'h7;
        in_b = 8'h8;
        sel = 4'h1;
        #15
        
        addr = 8'h1;
        in_a = 8'h1F;
        in_b = 8'h1F;
        sel = 4'h2;
        #15

        rw = 1'b0;
        addr = 8'h0;
        #735

        addr = 8'h1;
        #340
        





        #2000
        $finish;

    end

endmodule
