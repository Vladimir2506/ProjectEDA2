`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/17 01:47:14
// Design Name: 
// Module Name: TimeDivTestBench
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


module TimeDivTestBench();
    reg rClockSrc = 0;
    parameter pFlip = 2;
    wire wDst;
    
    TimeDiv TimeTest
    (
        .wClockSrc(rClockSrc),
        .wTimes(pFlip),
        .rClockDst(wDst)
    );
    
    always
    # 5 rClockSrc <= ~rClockSrc;
endmodule
