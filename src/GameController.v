// ECE 6370
// Author: Javier Garcia, 1266111
// Game Controller

// This modules controls most of the other modules based on the state of the game. When
// a player logs in, the module allows the player to choose the level when setting 
// loadPls high. If the level is increased after 6 is displayed, the player enters the
// top score viewing mode, at which point startPls cycles between showing the top score
// and the top scorer's ID. Another loadPls returns the player to level select. Setting
// startPls high during level select starts the game, and the module signals the LED timer
// to begin counting down. During the game, the module passes the index values for the
// Word Scrambler module to flip the indeces of letters, and tells it when to retrieve and
// scramble new words. When the game is over, only the score is displayed, and startPls must
// be set high to return to level select.

module GameController(pwdPls, logOn, pIDin, isGuestIn, startPls, loadPls, indIn1, indIn2, isCorrect, 
	timeOut, controlSig, logOut, pIDout, isGuestOut, scoreOnes, scoreTens, lettNum, modeDisp, scramPls, 
	indOut1, indOut2, flipPls, timerEn, timerReconfig, clk, rst);
	input pwdPls, logOn, isGuestIn, startPls, loadPls, isCorrect, timeOut, clk, rst;
	input [2:0] pIDin, indIn1, indIn2;
	output logOut, isGuestOut, scramPls, flipPls, timerEn, timerReconfig;
	reg logOut, isGuestOut, scramPls, flipPls, timerEn, timerReconfig, flag;
	output [1:0] lettNum;
	reg [1:0] lettNum, mode;
	output [2:0] controlSig, pIDout, indOut1, indOut2;
	reg [2:0] controlSig, pIDout, indOut1, indOut2;
	output [3:0] modeDisp, scoreOnes, scoreTens;
	reg [3:0] modeDisp, scoreOnes, scoreTens;
	reg [3:0] State;
	parameter INIT = 0, SETUP = 1, GAME = 2, GAMEOVER = 3, LOGOUT = 4, TOPSCORE = 5;

	always @(posedge clk) begin
		if (rst == 1'b0)
			State <= LOGOUT;
		else begin
			case(State)
				INIT: begin
					controlSig <= 0;
					logOut <= 1'b0;
					scramPls <= 1'b0;
					flipPls <= 1'b0;
					timerEn <= 1'b0;
					timerReconfig <= 1'b1;
					mode <= 0;
					scoreOnes <= 0;
					scoreTens <= 0;
					if (logOn == 1'b1) begin
						State <= SETUP;
					end
				end
				SETUP: begin
					timerReconfig <= 1'b0;
					modeDisp <= mode+4;
					controlSig <= 1;
					if (pwdPls == 1'b1) begin
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
						lettNum <= mode;
						timerEn <= 1'b1;
						State <= GAME;
					end
				end
				GAME: begin
					controlSig <= 2;
					scramPls <= startPls;
					flipPls <= loadPls;
					indOut1 <= indIn1;
					indOut2 <= indIn2;
					lettNum <= mode;
					if (isCorrect == 1'b1) begin
						if (scoreOnes==9) begin
							scoreOnes <= 0;
							scoreTens <= scoreTens+1;
						end
						else							
							scoreOnes <= scoreOnes + 1;
					end
					else if (pwdPls == 1'b1)
						State <= INIT;
					else if (timeOut == 1'b1) 
						State <= GAMEOVER;
				end
				GAMEOVER: begin
					controlSig <= 3;
					pIDout <= pIDin;
					isGuestOut <= isGuestIn;
					if (startPls == 1'b1)
						State <= INIT;
				end
				LOGOUT: begin
					logOut <= 1'b1;
					State <= INIT;
				end
				TOPSCORE: begin
					if (startPls == 1'b1)
						flag <= flag+1;
					else if (loadPls == 1'b1)
						State <= INIT;
					else begin
						if (flag==1'b0)
							controlSig <= 4;					
						else
							controlSig <= 5;
					end
				end
				default: begin
					State <= INIT;
				end
			endcase
		end
	end
	
endmodule
	
