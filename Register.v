`timescale 1ns/1ns
module Register( in,  clk, rst, load, out);
    parameter n;
    input [n-1:0] in;
    input clk,rst,load;
    output reg [n-1:0] out;
    always @(posedge clk,posedge rst) begin
        if (rst) out <= (n)*1'b0;
        else if (load) out <= in;
    end
endmodule