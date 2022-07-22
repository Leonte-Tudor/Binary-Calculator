// D flip-flop
module DFF (clk, reset,
  d, q);
  input      clk;
  input      reset;
  input      d;
  output reg q;


  always @(posedge clk or posedge reset)
  begin
    if (reset) begin
      // Asynchronous reset when reset goes high
      q <= 1'b0;
    end else begin
      // Assign D to Q on positive clock edge
      q <= d;
    end
  end
endmodule
