`timescale 1us / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/24 20:47:56
// Design Name: 
// Module Name: FinaleTestBench
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


module FinaleTestBench();
    
    reg rClock;
    reg[3:0] rKey;
    wire wShut;
    wire[3:0] wA, wB, wC, wD;
    supply0 VSS;
    
    Finale FinalTest
    (
        .wClock(rClock),
        .wReset(VSS),
        .wKey(rKey),
        .rNuit(wShut),
        .wMoneyH(wA),
        .wMoneyL(wB),
        .wTimeH(wC),
        .wTimeL(wD)
    );
    
    initial
    begin
        rClock = 0;
        rKey = 10;
        #10000 
        rKey = 7;
        #5000
        rKey = 15;
        #5000
        rKey = 2;
        #5000
        rKey = 3;
        #5000
        rKey = 14;
        #5000
        rKey = 1;
        #5000
        rKey = 5;
        #5000
        rKey = 13;
        #5000
        rKey = 10;
    end
   
    always #100 rClock <= ~rClock;
endmodule
