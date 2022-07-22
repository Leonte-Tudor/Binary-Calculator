module testbench_M_ALU;
  
  reg [7:0] A;
  reg [7:0] B;
  
  reg [3:0] SEL_TMP;
  
  
  wire [7:0] ALU_OUT_TMP;
  wire [3:0] FLAG_TMP;
  
  M_ALU DUT(.ALU_OUT_TMP(ALU_OUT_TMP),
             .FLAG_TMP(FLAG_TMP),
             .A(A),
             .B(B),
             .SEL_TMP(SEL_TMP)
            );
  
  
  initial begin
     // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    
    // sum w/o carry
    
    #1
    
    SEL_TMP = 4'h0;
    A= 8'b0010_1011;
    B= 8'b0000_0100;
    
    #1
    
    display;
    
    // sum w/ carry
    
    SEL_TMP = 4'h0;
    A= 8'b1010_1011;
    B= 8'b1000_0100;
    
    #1
    
    display;
    
    
    // sub w/o underflow
    
    SEL_TMP = 4'h1;
    A= 8'b0010_1011;
    B= 8'b0000_0100;
    
    #1
    
    display;
    
    // sub w/ underflow
    
    SEL_TMP = 4'h1;
    B = 8'b0010_1011;
    A = 8'b0000_0100;
    
    #1
    
    display;

    // multiplication w/o overflow
    
    SEL_TMP = 4'h2;
    A = 8'b0010_1011;
    B = 8'b0000_0100;
    
    #1
    
    display;
    
    // multiplication w/ overflow
    
    SEL_TMP = 4'h2;
    A = 8'b1010_1011;
    B = 8'b1000_0100;
    
    #1
    
    display;
    
    // division w/o underflow
    
    SEL_TMP = 4'h3;
    A = 8'b0010_1011;
    B = 8'b0000_0100;
    
    #1
    
    display;
    
    // division w/ underflow
    
    SEL_TMP = 4'h3;
    B = 8'b0010_1011;
    A = 8'b0000_0100;
    
    #1
    
    display;
    
    // left shifting w/o ZeroFlag
    
    SEL_TMP = 4'h4;
    A= 8'b0010_1011;
    B= 8'b0000_0100;
    
    #1
    
    display;
    
    // left shifting w/ ZeroFlag
    
    SEL_TMP = 4'h4;
    A= 8'b0010_1011;
    B= 8'b0000_0011;
    
    #1
    
    display;
    
    // right shifting w/o ZeroFlag
    
    SEL_TMP = 4'h5;
    A= 8'b0010_1011;
    B= 8'b0000_0100;
    
    #1
    
    display;
    
    // right shifting w/ ZeroFlag
    
    SEL_TMP = 4'h5;
    A= 8'b0010_1011;
    B= 8'b1000_0100;
    
    #1
    
    display;
    
    // AND
    
    SEL_TMP = 4'h6;
    A= 8'b0010_1011;
    B= 8'b0000_0110;
    
    #1
    
    display;
    
    // OR
    
    SEL_TMP = 4'h7;
    A= 8'b0010_1011;
    B= 8'b0000_0100;
    
    #1
    
    display;
    
    // XOR
    
    SEL_TMP = 4'h8;
    A= 8'b0010_1011;
    B= 8'b0000_0100;
    
    #1
    
    display;
    
    // NXOR
    
    SEL_TMP = 4'h9;
    A= 8'b0010_1011;
    B= 8'b0000_0100;
    
    #1
    
    display;
    
    // NAND
    
    SEL_TMP = 4'hA;
    A= 8'b0010_1011;
    B= 8'b0000_0100;
    
    #1
    
    display;
    
    // NOR
    
    SEL_TMP = 4'hB;
    A= 8'b0010_1011;
    B= 8'b0000_0100;
    
    #1
    
    display;
    
    
    // DEFAULT
    
    SEL_TMP = 4'hC;
    A= 8'b0010_1011;
    B= 8'b0000_0100;
    
    #1
    
    display;
   
  end
  
  task display;
    $display("A:%b, B:%b, SEL_TMP:%h, ALU_OUT_TMP:%b, FLAG_TMP:%b",
             A, B, SEL_TMP, ALU_OUT_TMP, FLAG_TMP);
  endtask
  
endmodule
