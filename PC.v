`timescale 1ns/1ns
module PC(input [4:0] pc,input clk, rst, load, output reg [4:0] pcOut);
  always @(posedge clk , posedge rst) begin
    if(rst) pcOut <= 10'b0;
    else if ()pcOut <= pc;
  end
endmodule