`timescale 1ns/1ns

module ALU(ri, rj, func, out);
  parameter n;
  input [n-1:0] ri,rj;
  input [1:0] func;
  output [n-1:0] out;
  output zero;
  assign out = (func == 3'b00)? ri + rj:
            (func == 3'b01)? ri - rj:
            (func == 3'b10)? ri & rj:
            (func == 3'b11)? ~ri:
                3'bz;

endmodule

