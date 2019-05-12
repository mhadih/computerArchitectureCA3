`timescale 1ns/1ns
module PC(input [4:0] pc,input clk,rst,output reg [4:0] w);
  always @(posedge clk , posedge rst) begin
    if(rst) w <= 10'b0;
    else  w <= pc;
  end
endmodule