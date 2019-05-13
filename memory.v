`timescale 1ns/1ns
module Memory(input [4:0] adr,input [7:0] data,input memwen,memRead,clk,output [7:0] resMem);
  reg [8:0] m [0:31];
  integer i;
  
  initial begin
    for (i=0; i<=31;i=i+1) 
      m[i] = 8'b0;

		m[0] = 8'b10011101;	// push 8 in St
		m[1] = 8'b10011101;	// push 8 in St
		m[2] = 8'b00000000;	// add 8 + 8 and stoers 16 in St
		m[3] = 8'b11000111;	// jump to instruction 7
		m[7] = 8'b11101100;	// does not jumpz to 12 
		m[8] = 8'b10011110;	// push 16 on St
		m[9] = 8'b00100000;	// sub 16 - 16 and store 0 on St
		m[10] = 8'b11101111;	// jumpz 15
		m[15] = 8'b10011100;	// push 10101010 on St
		m[16] = 8'b10011011;	// push 01100110 on St
		m[17] = 8'b01000000;	// and 10101010 & 01100110 and store 01000100 on St
		m[18] = 8'b01100000;	// not 01000100 and store 10111011 on St
		m[19] = 8'b10111111;	// pop 10111011 from st and store it on m[31]
		m[20] = 8'b10111110;	// pop 0 from st and store it on m[30]

    m[27] = 8'b01100110;
		m[28] = 8'b10101010;
		m[29] = 8'b00001000;
		m[30] = 8'b00010000;

  end

  always @(posedge clk) begin
    if(memwen) begin
      m[adr] <= data;
    end
  end
    assign resMem = (memRead) ? m[adr]:8'bz;
  // assign resMem = m[adr];
endmodule