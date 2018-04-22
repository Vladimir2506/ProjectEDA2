`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/19 10:23:01
// Design Name: 
// Module Name: DisplayTop
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


module DisplayDecoder
(
    input wire [3:0]wBinary,
    output reg [7:0]rNumeros
);
    always @(wBinary)
    begin
        case(wBinary)
            4'b0000 : rNumeros <= 8'b00000011;
            4'b0001 : rNumeros <= 8'b10011111;
            4'b0010 : rNumeros <= 8'b00100101;
            4'b0011 : rNumeros <= 8'b00001101;
            4'b0100 : rNumeros <= 8'b10011001;
            4'b0101 : rNumeros <= 8'b01001001;
            4'b0110 : rNumeros <= 8'b01000001;
            4'b0111 : rNumeros <= 8'b00011111;
            4'b1000 : rNumeros <= 8'b00000001;
            4'b1001 : rNumeros <= 8'b00001001;         
            default : rNumeros <= 8'b11111111;
        endcase
    end
endmodule
