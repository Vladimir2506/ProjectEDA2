`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/16 15:47:40
// Design Name: 
// Module Name: TimeDiv
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


module TimeDiv
(
    input wire wClockSrc,
    input wire[31:0] wTimes,
    output reg rClockDst
);
    reg[31:0] rCounter;
    
    initial
    begin
        rCounter = 0;
        rClockDst = 0;
    end
    
    always @(posedge wClockSrc)
    begin
        if(rCounter == wTimes - 1)
        begin
            rClockDst <= ~rClockDst;
            rCounter <= 0;
        end
        else
        begin
            rCounter <= rCounter + 1'b1;
        end
    end
    
endmodule
