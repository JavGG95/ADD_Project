module GameController(pwdPls, logOn, pIDin, gIDin, startPls, loadPls, indIn1, indIn2, isCorrect, timeOut, logOut, pIDout, gIDout, score, lettNum, scramPls, indOut1, indOut2, flipPls, timerEn, clk, rst);
	input pwdPls, logOn, startPls, loadPls, isCorrect, timeOut, clk, rst;
	input [2:0] pIDin, gIDin, indIn1, indIn2;
	output logOut, scramPls, flipPls, timerEn;
	reg logOut, scramPls, timerEn;
	output [2:0] pIDout, gIDout, lettNum, indOut1, indOut2;
	reg [2:0] pIDout, gIDout, lettNum, indOut1, indOut2, mode;
	output [6:0] score;
	reg [6:0] score;
	reg [3:0] State;
	parameter INIT = 0, SETUP = 1, GETWORD = 2, SWAP = 3, CORRECT = 4, GAMEOVER = 5, LOGOUT = 6;

	always @(posedge clk) begin
		if (rst == 1'b0)
			State <= INIT;
		else begin
			case(State)
				INIT: begin
					logOut <= 1'b0;
					scramPls <= 1'b0;
					flipPls <= 1'b0;
					timerEn <= 1'b0;
					mode <= 4;
					if (logOn == 1'b1) begin
						State <= SETUP;
					end
				end
				SETUP: begin
					lettNum <= mode;
					if (pwdPls == 1'b1) begin
						logOut <= 1'b1;
						State <= LOGOUT;
					end
					else if (loadPls == 1'b1) begin
						if (mode == 6)
							mode <= 4;
						else
							mode <= mode+1;	
					end
					else if (startPls == 1'b1)
						score <= 0;
						timerEn <= 1'b1;
						State <= GETWORD;
				end
				GETWORD: begin
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
					flipPls <= 1'b0
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
					State <= GETWORD
				end
				GAMEOVER: begin
					pIDout <= pIDin;
					gIDout <= gIDin;
					timerEn <= 1'b0;
					mode <= 4;					
					State <= SETUP
				end
				LOGOUT: begin
					logOut <= 1'b0;
					State <= INIT;
				end
				default: 
					State <= INIT;
			endcase
		end
	end
	
endmodule
	