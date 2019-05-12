`timescale 1ns/1ns
module memory(input [9:0] adr,input [15:0] data,input memwen,clk,output [15:0] resMem);
  reg [8:0] m [0:31];
  integer i;
  
  initial begin
    for (i=0; i<=1023;i=i+1) 
      m[i] = 16'b0;

    m[10] = 1;
    m[11] = 2;
    m[12] = 3;
    m[13] = 4;
    m[14] = 5;
    m[15] = 6;
    m[16] = 7;
    m[17] = 8;
    m[18] = 9;
    m[19] = 10;
  end

  always @(posedge clk) begin
    if(memwen) begin
      m[adr] <= data;
    end
  end
  assign resMem = m[adr];
endmodule