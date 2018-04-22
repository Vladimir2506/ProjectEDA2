`timescale 1us / 1us
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/17 19:41:41
// Design Name: 
// Module Name: InputProcTestBench
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


module InputProcTestBench();

    reg rClock;
    reg[3:0] rRows;
    wire[3:0] wCols;
    wire[3:0] wVal;
    
    supply0 VSS;
    InputProc TestInput
    (
        .wClock(rClock),
        .wReset(VSS),
        .wRow(rRows),
        .rCol(wCols),
        .rVal(wVal)
    );

    initial
    begin
        rClock = 1'b0;
        rRows = 4'b1111;
        //Long Push 1.5ms~201.5ms
        #1500 rRows = 4'b1110;          
        #200000 rRows = 4'b1111;        
        //Tremble Push 206.5ms~216.0ms
        #5000 rRows = 4'b0111;          
        repeat(10)
        begin
            #500 rRows = 4'b1111;
            #500 rRows = 4'b0111;
        end
        rRows = 4'b1111;
        //Normal Push '6' Expected 319.0ms~ Until wCols == 1110
        #100000 rRows = 4'b1101;
        wait(wCols == 4'b1110);   //From the beginning of the scan
        rRows = 4'b1111;          //Keep scanning on
        wait(wCols == 4'b1011);   //Wait until the correct column
        rRows = 4'b1101;         //Form the correct code
        //Hold for 100ms
        #100000  rRows = 4'b1111; 
    end

    always 
        #1000 rClock <= ~rClock;

endmodule
