`timescale 1ns/1ns
module Stack(input [7:0] dataIn,input clk,push,pop,tos, output reg[7:0] resStk);
  reg [7:0] stk[0:31];
  reg [4:0] topPntr;

  integer i;
  initial begin
    topPntr = 5'b0;
    for (i=0; i<=31;i=i+1) 
      stk[i] =8'b0;
  end

  always @(posedge clk) begin
    if (tos) 
      resStk <= stk[topPntr];
    else if (pop) begin
        topPntr = topPntr - 1;
        resStk <= stk[topPntr];
    end
    else if (push) begin
        resStk <= dataIn;
        topPntr = topPntr + 1;
    end
  end
endmodule