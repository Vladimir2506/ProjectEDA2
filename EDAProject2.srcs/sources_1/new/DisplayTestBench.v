`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/05 10:03:34
// Design Name: 
// Module Name: DynDispTestBench
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


module DisplayTestBench();
    reg[3:0] rT0, rT1, rT2, rT3;
    reg rCLK = 1'b0;
    wire[3:0] wEn;
    wire[7:0] wOut;
    parameter halfT = 50;
    
    DynamicDisplay ddTest
    (
        .wClock(rCLK),
        .wA(rT0),
        .wB(rT1),
        .wC(rT2),
        .wD(rT3),
        .rEnable(wEn),
        .wData(wOut)
    );
    initial
    begin
        rT0 = 4'b1001;
        rT1 = 4'b1100;
        rT2 = 4'b0011;
        rT3 = 4'b0001;
    end
    
    always
    begin 
        #halfT rCLK <= ~rCLK; 
    end
    
endmodule
