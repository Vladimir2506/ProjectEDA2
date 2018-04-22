`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/17 00:33:58
// Design Name: 
// Module Name: Main
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


module Main
(
    input wire wClockAll,
    input wire wResetAll,
    input wire[3:0] wRows,
    output wire[3:0] wCols,
    output wire[3:0] wEnables,
    output wire[7:0] wDatas
);

    parameter pDivInput = 400000;
    parameter pDivFinale = 100000;
    parameter pDivDisplay = 200000;
    parameter pSpaceholder = 4'b1111;
    
    wire wClockInput, wClockFinale, wClockDisplay;
    wire[3:0] wInput, wMH, wML, wTH, wTL, wEN;
    wire wShut;
    
    assign wEnables = wShut ? pSpaceholder : wEN;
    
    TimeDiv DivInput
    (
        .wClockSrc(wClockAll),
        .wTimes(pDivInput),
        .rClockDst(wClockInput)
    );

    TimeDiv DivDisplay
    (
        .wClockSrc(wClockAll),
        .wTimes(pDivDisplay),
        .rClockDst(wClockDisplay)
    );

    TimeDiv DivFinale
    (
        .wClockSrc(wClockAll),
        .wTimes(pDivFinale),
        .rClockDst(wClockFinale)
    );

    InputProc KeyBoardInputProcess
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
        .wA(wMH),
        .wB(wML),
        .wC(wTH),
        .wD(wTL),
        .rEnable(wEN),
        .wData(wDatas)
    );

    Finale FinalLogic
    (
        .wClock(wClockFinale),
        .wReset(wResetAll),
        .wKey(wInput),
        .wMoneyH(wMH),
        .wMoneyL(wML),
        .wTimeH(wTH),
        .wTimeL(wTL),
        .rNuit(wShut)
    );
   
endmodule
