`timescale 1ns/1ns
module CA3(input clk , rst );
    wire [2:0] opcode;
    wire ldA,ldB,push,pop,tos,IRWrite,memWrite,memRead,pcWriteCond,pcWrite,pcSrc,IorD,srcA,srcB,MtoS;
    wire [1:0] ALUOp;

    DataPath dataPath(.clk(clk),.rst(rst),.pcWrite(pcWrite),.pcWriteCond(pcWriteCond),.pcSrc(pcSrc),.IorD(IorD),.memRead(memRead),
                    .memWrite(memWrite),.IRWrite(IRWrite),.MtoS(MtoS),.ldA(ldA),.ldB(ldB),.srcA(srcA),.srcB(srcB),.push(push),.pop(pop),
                    .tos(tos),.ALUOp(ALUOp),.opcode(opcode));
    // module DataPath(input clk,rst,
    //                 pcWrite, pcWriteCond, pcSrc, IorD, memRead, memWrite, IRWrite, MtoS,
    //                 ldA, ldB, srcA, srcB, push, pop, tos,
    //                 input [1:0] ALUOp,
    //             output[2:0] opcode);
    Controller controller(.clk(clk),.rst(rst),.pcWrite(pcWrite),.pcWriteCond(pcWriteCond),.pcSrc(pcSrc),.IorD(IorD),.memRead(memRead),
                    .memWrite(memWrite),.IRWrite(IRWrite),.MtoS(MtoS),.ldA(ldA),.ldB(ldB),.srcA(srcA),.srcB(srcB),.push(push),.pop(pop),
                    .tos(tos),.ALUOp(ALUOp),.opcode(opcode));
    // module Controller(input clk,rst,
    //             input [2:0] opcode,
    //             output reg ldA,ldB,push,pop,tos,IRWrite,memWrite,memRead,pcWriteCond,pcWrite,pcSrc,IorD,srcA,srcB,MtoS,
    //             output reg [1:0] ALUOp);
endmodule 

    module TB();
    reg clk=0,rst;
    CA3 g(clk,rst);
    always #100 clk=~clk;
    initial begin
      rst = 1;
      #50 
      rst = 0;
      #20000
      $stop;
    end

endmodule