`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/16 15:55:49
// Design Name: 
// Module Name: InputProc
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


module InputProc
(
    input wire wClock,
    input wire wReset,
    input wire[3:0] wRow,
    output reg[3:0] rCol,
    output reg[3:0] rVal
);
    reg[3:0] rColVal, rRowVal;
    reg[2:0] rNow, rNext;
    reg rPush;

    parameter pIdle = 0;
    parameter pCol0 = 1;
    parameter pCol1 = 2;
    parameter pCol2 = 3;
    parameter pCol3 = 4;
    parameter pPush = 5;
    
    
    initial 
    begin
        rNow = pIdle;
        rNext = pIdle;
        rPush = 1'b0;
        rColVal = 4'b0000;
        rRowVal = 4'b0000;
    end
    
    //State Run
    always @(posedge wClock or posedge wReset)
    begin
        if(wReset)
        begin
            rNow <= pIdle;
        end
        else
        begin
            rNow <= rNext;
        end
    end
    
    //State Transform
    always @(rNow)
    begin
        case(rNow)
            pIdle: rNext <= (wRow == 4'b1111) ? pCol0 : pPush;
            pCol0: rNext <= (wRow == 4'b1111) ? pCol1 : pPush;
            pCol1: rNext <= (wRow == 4'b1111) ? pCol2 : pPush;
            pCol2: rNext <= (wRow == 4'b1111) ? pCol3 : pPush;
            pCol3: rNext <= (wRow == 4'b1111) ? pIdle : pPush;
            pPush: rNext <= (wRow == 4'b1111) ? pIdle : pPush;
        endcase
    end
    
    //Regs Run
    always @(posedge wClock or posedge wReset)
    begin
        if(wReset)
        begin
            rCol <= 4'b1111;
            rPush <= 1'b0;
        end
        else
        begin
        case(rNext)
            pIdle:
            begin
                rCol <= 4'b1111;
                rPush <= 1'b0;
            end
            pCol3: rCol <= 4'b0111;
            pCol2: rCol <= 4'b1011;
            pCol1: rCol <= 4'b1101;
            pCol0: rCol <= 4'b1110;
            pPush:
            begin
                rColVal <= rCol;
                rRowVal <= wRow;
                rPush <= 1'b1;
            end
        endcase
        end
    end
    
    //Proceed Value
    always @(posedge wClock or posedge wReset)
    begin
        if(wReset) rVal <= 4'b1010;
        else if(~rPush) rVal <= 4'b1010;
        else
            case({ rColVal,rRowVal }) 
                8'b11101110: rVal <= 4'b0001;
                8'b11101101: rVal <= 4'b0100;
                8'b11101011: rVal <= 4'b0111;
                8'b11100111: rVal <= 4'b0000;       
                8'b11011110: rVal <= 4'b0010;
                8'b11011101: rVal <= 4'b0101;
                8'b11011011: rVal <= 4'b1000;
                8'b11010111: rVal <= 4'b1111;           
                8'b10111110: rVal <= 4'b0011;
                8'b10111101: rVal <= 4'b0110;
                8'b10111011: rVal <= 4'b1001;
                8'b10110111: rVal <= 4'b1110;                                      
                8'b01111110: rVal <= 4'b1010;
                8'b01111101: rVal <= 4'b1011;
                8'b01111011: rVal <= 4'b1100;
                8'b01110111: rVal <= 4'b1101; 
            endcase
    end
endmodule
