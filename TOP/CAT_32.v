module CAT_32(input [7:0] A,
              input [7:0] B,
              input [7:0] C,
              input [3:0] D,
              input [3:0] E,
              output reg [31:0] out
             ); 

  always @(*)
    begin
        out = {E, D, C, B, A};
    end
  
endmodule
