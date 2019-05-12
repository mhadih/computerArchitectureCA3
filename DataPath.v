`timescale 1ns/1ns
module DataPath(input clk,rst,
                    pcWrite, pcWriteCond, pcSrc, IorD, memRead, memWrite, IRWrite, MtoS
                    ldA, ldB, srcA, srcB, ALUOp, push, pop, tos
                    input [1:0] ALUOp,
                output[2:0] opcode,
                output[4:0] addrs);

wire[4:0] PCin,pcOut,memAddrs;
wire[7:0] resMem, pcExt, Ain, Bin, resALU, resALUReg;
wire ldPC;

assign ldPC = (zero&pcWriteCond)|pcWrsite;

Register pc(.in(PCin), .clk(clk), .rst(rst), .load(ldPC), .pcOut(pcOut));

MUX #(5) PcMux(.in0(resPC), in1(IR[4:0]), .sel(IorD), .out(memAddr));

Memory memory(.adr(MemRead), .memwen(memWrite), .data(resA), .clk(clk), resMem(readData));

Register IRReg(.in(readData), .clk(clk), .rst(rst), .load(IRWrite), .out(IR));

Register MDRReg(.in(readData), .clk(clk), .rst(rst), .load(1'b1), .out(MDR));

MUX #(8) stackIn(.in0(resALUReg), .in1(MDR), .sel(MtoS), .out(dataIn));

Stack stack(.dataIn(dataIn), .push(push), .pop(pop), tos(tos));

Register A(.in(resStk), .clk(clk), .rst(rst), .load(ldA), .out(resA));

Register B(.in(resStk), .clk(clk), .rst(rst), .load(ldB), .out(resB));

Register Z(.in(resStk), .clk(clk), .rst(rst), .load(1'b1), .out(zero));

zeroExtend zeroExtend(.pc(pcOut), .out(pcExt));

MUX #(8) AMUX(.in0(resA), .in1(pcExt), .sel(srcA), .out(Ain));

MUX #(8) BMUX(.in0(resB), .in1(8'b1), .sel(srcB), .out(Bin));

ALU ALU(.ri(Ain), .rj(Bin), .func(ALUOp), .out(resALU));

Register ALUReg(.in(resALU), .clk(clk), .rst(rst), .load(1'b1), .out(resALUReg));

MUX PCMUX(.in0(resALU[4:0]), .in1(IR[4:0]), .sel(pcSrc), .out(PCin));

endmodule