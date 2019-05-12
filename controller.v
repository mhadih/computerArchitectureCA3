`timescale 1ns/1ns
module controller(input clk,rst
                ,input [2:0] op
                ,output reg ldA,ldB,push,pop,tos,IRWrite,memWrite,memRead,pcWriteCond,pcWrite,pcSrc,IorD,srcA,srcB,MtoS
                ,output reg [1:0] ALUop);
    reg [4:0] ps,ns;
    always @(posedge clk, posedge rst) begin
        if(rst) ps <= 0;
        else ps <= ns;
    end
    always @(ps) begin
        case (ps)
            0 : ns <= 1;  
            1 : ns <= (op==7)?2:(op==6)?3:(op==4)?4:6;
            2 : ns <= 0;
            3 : ns <= 0;
            4 : ns <= 5;
            5 : ns <= 0;
            6 : ns <= 7;
            7 : ns <= (op==5)?8:(op==3)?13:9;
            8 : ns <= 0;
            9 : ns <= 10;
            10 : ns <= 11;
            11 : ns <= 12;
            12 : ns <= 0;
            13 : ns <= 12;
        endcase
    end
    always @(ps) begin
        {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS, ALUop}= 17'b00001000000000000;
        case (ps)
            0 : {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS, ALUop}= 17'b00000101010011000;
            1 : {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS, ALUop}= 17'b00001000000000000;
            2 : {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS, ALUop}= 17'b00000000011000000;
            3 : {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS, ALUop}= 17'b00000000101000000;
            4 : {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS, ALUop}= 17'b00000001000100000;
            5 : {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS, ALUop}= 17'b00100000000000100;
            6 : {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS, ALUop}= 17'b00010000000000000;
            7 : {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS, ALUop}= 17'b10000000000000000;
            8 : {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS, ALUop}= 17'b00000010000100000;
            9 : {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS, ALUop}= 17'b00010000000000000;
            10 : {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS, ALUop}= 17'b01000000000000000;
            11 : begin
                    {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS}= 15'b000000000000000 ;
                    ALUop = op[1:0];
                end
            12 : {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS, ALUop}= 17'b00100000000000000;
            13 : {ldA,ldB,push,pop, tos,IRWrite,memWrite,memRead, pcWriteCond,pcWrite,pcSrc,IorD, srcA,srcB,MtoS, ALUop}= 17'b00000000000000011;
        endcase
    end







endmodule 