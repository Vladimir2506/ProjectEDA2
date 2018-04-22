`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/17 15:47:01
// Design Name: 
// Module Name: KeyBoardDemo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module KeyBoardDemo
(
    input wire wClockAll,
    input wire wResetAll,
    input wire[3:0] wRows,
    output wire[3:0] wCols,
    output wire[3:0] wEnables,
    output wire[7:0] wDatas
);

    reg[3:0] rA, rB, rC;
    wire[3:0] wInput;
    wire wClockInput, wClockDisplay;
    parameter pDivInput = 500000;
    parameter pDivDisplay = 200000;
    
    initial
    begin
        rA = 4'b0001;
        rB = 4'b0010;
        rC = 4'b0011;
    end
    
    TimeDiv DivInput
    (
        wClockAll,
        pDivInput,
        wClockInput
    );

    TimeDiv DivDisplay
    (
        wClockAll,
        pDivDisplay,
        wClockDisplay
    );
    
    InputProc InputTest
    (
        .wClock(wClockInput),
        .wReset(wResetAll),
        .wRow(wRows),
        .rCol(wCols),
        .rVal(wInput)
    );

    DynamicDisplay DisplayController
    (
        .wClock(wClockDisplay),
        .wA(rA),
        .wB(rB),
        .wC(rC),
        .wD(wInput),
        .rEnable(wEnables),
        .wData(wDatas)
    );
endmodule
