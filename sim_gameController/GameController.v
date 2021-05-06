module GameController(pwdPls, logOn, pIDin, isGuestIn, startPls, loadPls, indIn1, indIn2, isCorrect, timeOut, controlSig, Mux_Ctrl, logOut, 
			pIDout, isGuestOut, score, lettNum, modeDisp, scramPls, indOut1, indOut2, flipPls, timerEn, timerReconfig, clk, rst);
	input pwdPls, logOn, isGuestIn, startPls, loadPls, isCorrect, timeOut, clk, rst;
	input [2:0] pIDin, indIn1, indIn2;
	output Mux_Ctrl, logOut, isGuestOut, scramPls, flipPls, timerEn, timerReconfig;
	reg Mux_Ctrl, logOut, isGuestOut, scramPls, flipPls, timerEn, timerReconfig, flag;
	output [1:0] lettNum;
	reg [1:0] lettNum, mode;
	output [2:0] controlSig, pIDout, indOut1, indOut2;
	reg [2:0] controlSig, pIDout, indOut1, indOut2;
	output [3:0] modeDisp;
	reg [3:0] modeDisp;
	output [6:0] score;
	reg [6:0] score;
	reg [3:0] State;
	parameter INIT = 0, SETUP = 1, GETWORD = 2, SWAP = 3, CORRECT = 4, GAMEOVER = 5, LOGOUT = 6, TOPSCORE = 7;

	always @(posedge clk) begin
		if (rst == 1'b0)
			State <= INIT;
		else begin
			case(State)
				INIT: begin
					Mux_Ctrl <= 1'b0;
					controlSig <= 0;
					logOut <= 1'b0;
					scramPls <= 1'b0;
					flipPls <= 1'b0;
					timerEn <= 1'b0;
					timerReconfig <= 1'b0;
					mode <= 0;
					if (logOn == 1'b1) begin
						Mux_Ctrl <= 1'b1;
						timerEn <= 1'b1;
						State <= SETUP;
					end
				end
				SETUP: begin
					score <= 0;
					lettNum <= mode;
					modeDisp <= mode+4;
					controlSig <= 1;
					if (pwdPls == 1'b1) begin
						logOut <= 1'b1;
						State <= LOGOUT;
					end
					else if (loadPls == 1'b1) begin
						if (mode == 2) begin
							flag = 0;
							State <= TOPSCORE;
						end
						mode <= mode+1;	
					end
					else if (startPls == 1'b1) begin
						controlSig <= 2;
						timerReconfig <= 1'b1;
						State <= GETWORD;
					end
				end
				GETWORD: begin
					timerReconfig <= 1'b0;
					if (startPls == 1'b1)
						State <= SETUP;
					else if (timeOut == 1'b1)
						State <= GAMEOVER;
					else if (pwdPls == 1'b1) begin
						scramPls <= 1'b1;
						State <= SWAP;
					end
				end	
				SWAP: begin
					flipPls <= 1'b0;
					scramPls <= 1'b0;	
					indOut1 <= indIn1;
					indOut2 <= indOut2;
					if (startPls == 1'b1)
						State <= SETUP;
					else if (timeOut == 1'b1)
						State <= GAMEOVER;
					else if (isCorrect == 1'b1)
						State <= CORRECT;
					else if (loadPls == 1'b1) begin
						flipPls <= 1'b1;
					end			
				end
				CORRECT: begin
					score <= score+1;
					State <= GETWORD;
				end
				GAMEOVER: begin
					controlSig <= 3;
					pIDout <= pIDin;
					isGuestOut <= isGuestIn;
					if (startPls == 1'b1) begin
						mode <= 0;
						State <= SETUP;
					end
				end
				LOGOUT: begin
					timerEn <= 1'b0;
					logOut <= 1'b0;
					State <= INIT;
				end
				TOPSCORE: begin
					if (startPls == 1'b1)
						flag <= flag+1;
					else if (loadPls == 1'b1) begin
						mode <= 0;
						State <= SETUP;
					end
					else begin
						if (flag==1'b0)
							controlSig <= 4;					
						else
							controlSig <= 5;
					end
				end
				default: 
					State <= INIT;
			endcase
		end
	end
	
endmodule
	
