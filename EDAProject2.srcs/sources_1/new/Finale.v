`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/16 17:02:49
// Design Name: 
// Module Name: Finale
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


module Finale
(
    input wire wClock,
    input wire wReset,
    input wire[3:0] wKey,
    output reg rNuit,
    output wire[3:0] wTimeL,
    output wire[3:0] wTimeH,
    output wire[3:0] wMoneyL,
    output wire[3:0] wMoneyH
);

    reg [1:0] rNow;
    reg [3:0] rValidInput, rLast;
    reg [20:0] rCDIdle, rCDRun;
    reg [1:0] rCntInputs;
    reg [6:0] rMoneySum;    
    reg [6:0] rMoneyMod, rTimeMod;

    //Key Pressed Flags
    parameter pFunction = 15; 
    parameter pDefinintion = 13; 
    parameter pEliminiation = 14;
    parameter pInvalid = 10;

    //States Flags
    parameter pInit = 0;
    parameter pSet = 1;
    parameter pRun = 2;

    //Time Flags
    parameter pOneSec = 500;
    parameter pTenSec = 5000;

    initial
    begin
        rNow = pInit;
        rValidInput = pInvalid;
        rLast = pInvalid;
        rCDIdle = 0;
        rCDRun = 0;
        rCntInputs = 0;
        rMoneySum = 0;
        rMoneyMod = 0;
        rTimeMod = 0;
    end

    //State Equations
    always@ (posedge wClock or posedge wReset)
    begin
        if(wReset)
        begin
            rNow <= pInit;
            rValidInput <= pInvalid;
            rCntInputs <= 0;
            rCDIdle <= 0; 
            rCDRun <= 0;
            rMoneySum <= 0;
        end
        else
		//This process makes one push one input
		begin
			if(rLast == wKey) 
			begin
				rValidInput <= pInvalid;
			end
			else
			begin
				rValidInput <= wKey;
				rLast <= wKey;
			end
			case(rNow)
			pInit:
			begin
			    rCntInputs <= 0;
                rCDIdle <= 0; 
                rCDRun <= 0;
                rMoneySum <= 0;
				if(rValidInput == pFunction)           //Wake up to Idle
				begin 
					rNow <= pSet; 
				end
				else
				begin 
					rNow <= pInit;                      //Continue Sleep
				end
			end
			pSet:
			begin
				if(rValidInput == pEliminiation)        //Erase All Inputs and Idle
				begin 
					rCntInputs <= 0; 
					rCDIdle <= 0; 
					rMoneySum <= 0;
					rCDRun <= 0;
					rNow <= pSet; 
				end
				else if(rValidInput == pDefinintion)      //Run The set time
				begin 
					rCDRun <= rTimeMod * pOneSec; 
					rNow <= pRun; 
				end
				else if(rValidInput >= 0 && rValidInput <= 9)     //Input a number
				begin
					if(rValidInput > 0 || rCntInputs > 0)       //Prevent Null 0 Inputs
					begin
						if(rCntInputs <= 1)
						begin
							rCntInputs <= rCntInputs + 1;
							rMoneySum <= 10 * wMoneyL + rValidInput;
							rNow <= pSet;
						end
						else
						begin 
							rCntInputs <= 2;                //Hold the inputs until Eliminiation arrives
						end
					end
					else
					begin
						rNow <= pSet;
					end
				end
				else if( rCntInputs == 0 )
				begin
					if(rCDIdle == pTenSec)       //10s Idle to pInit
					begin 
						rCDIdle <= 0; 
						rNow <= pInit; 
					end
					else 
					begin  
						rCDIdle <= rCDIdle + 1; 
						rNow <= pSet; 
					end
				end
			end
			pRun:
			begin
				if(rCDRun == 0)              //CountDown OK
				begin
				    rCntInputs <= 0;
					rNow <= pSet;
				end
				else 
				begin 
					rCDRun <= rCDRun - 1; 
					rNow<= pRun;
				end
			end
			endcase
		end
    end

    //Outputs Equations
    always@ (*)
    begin
    if(wReset)
    begin
        rTimeMod <= 0;
        rMoneyMod <= 0;
    end
    else
    case(rNow)
    pInit:
    begin
        rNuit <= 1'b1;
    end
    pSet:
    begin
        if(rCntInputs == 0)
        begin
            rNuit <= 1'b0;
            rMoneyMod <= 0;
            rTimeMod <= 0;
        end
        else
        begin
            rNuit <= 1'b0;
            //Modify Money Valid and Time Valid
            if(rMoneySum > 20) rMoneyMod <= 20;
            else rMoneyMod <= rMoneySum;
            rTimeMod <= 2 * rMoneyMod;
        end
    end
    
    pRun:
    begin
        rNuit <= 1'b0;
        //Update Time remaining 
        rTimeMod <= rCDRun / pOneSec;
    end
    endcase
	end

	assign wMoneyH = rMoneyMod / 10; 
	assign wMoneyL = rMoneyMod % 10; 
	assign wTimeH = rTimeMod / 10;
	assign wTimeL = rTimeMod % 10;

endmodule
