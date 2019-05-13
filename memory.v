`timescale 1ns/1ns
module Memory(input [4:0] adr,input [7:0] data,input memwen,memRead,clk,output [7:0] resMem);
  reg [8:0] m [0:31];
  integer i;
  
  initial begin
    for (i=0; i<=31;i=i+1) 
      m[i] = 8'b0;

    m[0] = 8'b10011001;
		m[1] = 8'b10011010;
		m[2] = 8'b10011011;
		m[3] = 8'b10011100;
		m[4] = 8'b10011101;
		m[5] = 8'b00000000;
		m[6] = 8'b00000000;
		m[7] = 8'b00000000;
		m[8] = 8'b00000000;
		m[9] = 8'b10111110;

		m[25] = 8'b00001001;
		m[26] = 8'b00000111;
		m[27] = 8'b00000101;
		m[28] = 8'b00000011;
		m[29] = 8'b00000001;

  end

  always @(posedge clk) begin
    if(memwen) begin
      m[adr] <= data;
    end
  end
    assign resMem = (memRead) ? m[adr]:8'bz;
  // assign resMem = m[adr];
endmodule