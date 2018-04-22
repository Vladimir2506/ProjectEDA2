`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/19 11:38:46
// Design Name: 
// Module Name: DynamicDisplayTop
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


module DynamicDisplay
(
    input wire wClock,
    input wire [3:0]wA,
    input wire [3:0]wB,
    input wire [3:0]wC,
    input wire [3:0]wD,
    output reg [3:0]rEnable,
    output wire [7:0]wData
);
    reg [1:0] rLedSelect;
    wire [7:0] wNumeroA, wNumeroB, wNumeroC, wNumeroD;
    
    initial
    begin
        rLedSelect = 2'b00;
    end
    
    assign wData = rLedSelect[0] ? 
            (rLedSelect[1] ? wNumeroD : wNumeroB) :
            (rLedSelect[1] ? wNumeroC : wNumeroA);
    
    DisplayDecoder ledA
    (
        .wBinary(wA),
        .rNumeros(wNumeroA)
    );
    DisplayDecoder ledB
    (
        .wBinary(wB),
        .rNumeros(wNumeroB)
    );
    DisplayDecoder ledC
    (
        .wBinary(wC),
        .rNumeros(wNumeroC)
    );
    DisplayDecoder ledD
    (
        .wBinary(wD),
        .rNumeros(wNumeroD)
    );
    
    always @(posedge wClock)
    begin
        rLedSelect = (rLedSelect + 1'b1) % 3'b100;      //Switch between leds to make a scan
    end
    
    always @(rLedSelect)
    begin
        case(rLedSelect)
            2'b00 :                  //Perfom A
            begin
                rEnable = 4'b0111;
            end
            2'b01 :                  //Perfom B
            begin
                rEnable = 4'b1011;
            end
            2'b10 :                  //Perfom C
            begin
                rEnable = 4'b1101;
            end
            2'b11 :                 //Perfom D
            begin
                rEnable = 4'b1110;
            end
        endcase
    end
endmodule
