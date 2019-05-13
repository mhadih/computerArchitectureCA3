`timescale 1ns/1ns
module DataPath(input clk,rst,
                    pcWrite, pcWriteCond, pcSrc, IorD, memRead, memWrite, IRWrite, MtoS,
                    ldA, ldB, srcA, srcB, push, pop, tos,
                    input [1:0] ALUOp,
                output[2:0] opcode
                // output[4:0] addrs
                );

wire[4:0] PCin,pcOut,memAddrs;
wire[7:0] IR, resMem, pcExt, Ain, Bin, resALU, resALUReg,readData,dataIn,MDR,resStk,resA,resB;
wire ldPC, zero;
assign opcode = IR[7:5];
assign ldPC = (zero&pcWriteCond)|pcWrite;

Register #(5) pc(.in(PCin), .clk(clk), .rst(rst), .load(ldPC), .out(pcOut));

MUX #(5) IorDMux(.in0(pcOut), .in1(IR[4:0]), .sel(IorD), .out(memAddrs));

Memory memory(.adr(memAddrs),.memRead(memRead), .memwen(memWrite), .data(resA), .clk(clk), .resMem(readData));

Register #(8) IRReg(.in(readData), .clk(clk), .rst(rst), .load(IRWrite), .out(IR));

Register #(8) MDRReg(.in(readData), .clk(clk), .rst(rst), .load(1'b1), .out(MDR));

MUX #(8) stackIn(.in0(resALUReg), .in1(MDR), .sel(MtoS), .out(dataIn));

Stack stack(.dataIn(dataIn), .push(push), .pop(pop), .tos(tos),.clk(clk),.resStk(resStk));

Register #(8) A(.in(resStk), .clk(clk), .rst(rst), .load(ldA), .out(resA));

Register #(8) B(.in(resStk), .clk(clk), .rst(rst), .load(ldB), .out(resB));

// Register #(8) Z(.in(resStk), .clk(clk), .rst(rst), .load(1'b1), .out(zero));
assign zero = (resStk == 8'b0) ? 1 : 0;

zeroExtend zeroExtend(.pc(pcOut), .out(pcExt));

MUX #(8) AMUX(.in0(resA), .in1(pcExt), .sel(srcA), .out(Ain));

MUX #(8) BMUX(.in0(resB), .in1(8'b1), .sel(srcB), .out(Bin));

ALU #(8) ALU(.ri(Ain), .rj(Bin), .func(ALUOp), .out(resALU));

Register #(8) ALUReg(.in(resALU), .clk(clk), .rst(rst), .load(1'b1), .out(resALUReg));

MUX #(5) PCMUX(.in0(resALU[4:0]), .in1(IR[4:0]), .sel(pcSrc), .out(PCin));

endmodule