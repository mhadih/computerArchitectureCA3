`timescale 1ns/1ns
module Register(input[7:0] in, input clk, rst, load, output reg[7:0] out);
    always @(posedge clk,posedge rst)
        if (rst) out <= 8'b0;
        else if (load) out <= in
    end
endmodule