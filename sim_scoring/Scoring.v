module Scoring(controlSig, isGuest, intIDin, score, playerID, scoreRAM_Dout, intIDout, scoreRAM_RW, scoreRAM_Din, scoreRAM_Addr, 
		topIDOne, topIDTwo, topIDThree, topIDFour, topScoreOnes, topScoreTens, clk, rst);
	input isGuest, clk, rst;
	input [2:0] controlSig, intIDin;
	input [7:0] score;
	input [15:0] playerID, scoreRAM_Dout;
	output scoreRAM_RW;
	reg scoreRAM_RW;
	output [3:0] topIDOne, topIDTwo, topIDThree, topIDFour, topScoreOnes, topScoreTens;
	reg [3:0] topIDOne, topIDTwo, topIDThree, topIDFour, topScoreOnes, topScoreTens;
	output [4:0] intIDout, scoreRAM_Addr;
	reg [4:0] intIDout, scoreRAM_Addr, Global, Cycle, Count;
	output [15:0] scoreRAM_Din;
	reg [15:0] scoreRAM_Din;
	reg [2:0] State, nextState;
	parameter INIT = 0, FETCH = 1, CHECK = 2, UPDATE = 3, RETRIEVE = 4, SEND = 5, WAIT = 6;

	always @(posedge clk) begin
		if (rst==1'b0)
			State <= INIT; 
		else begin
			case (State)
				INIT: begin
					if (controlSig==3) begin
						topScoreOnes <= score%10;
						topScoreTens <= score/10;
						if (isGuest==1'b0) begin
							Global <= 0;
							State <= FETCH;
						end
					end
					else if (controlSig==4) begin
						State <= RETRIEVE;
					end										
				end
				FETCH: begin
					scoreRAM_RW <= 1'b0;
					Cycle <= 0;
					State <= WAIT;
					nextState <= CHECK;
					if (Global==1'b0)
						scoreRAM_Addr <= intIDin+1;
					else if (Global==1'b1) begin
						Count <= 0;
						intIDout <= intIDin;
						scoreRAM_Addr <= 1;
					end
					else
						State <= INIT;
				end
				CHECK: begin
					if (scoreRAM_Dout > score)
						State <= UPDATE;
					else begin
						State <= FETCH;
						Global <= Global+1;
					end
				end
				UPDATE: begin
					scoreRAM_RW <= 1'b1;
					scoreRAM_Din <= score;
					Cycle <= 0;
					State <= WAIT;
					nextState <= FETCH;
					if (Global==1'b1) begin
						if (Count==1'b1) begin
							scoreRAM_Addr <= 0;
							scoreRAM_Din <= playerID;
						end
						else begin
							Count <= Count+1;
							nextState <= UPDATE;	
						end				
					end
					else
						Global <= Global+1;
				end
				RETRIEVE: begin
					scoreRAM_RW <= 1'b0;
					scoreRAM_Addr <= 0;
					Cycle <= 0;
					State <= WAIT;
					nextState <= SEND;		
				end
				SEND: begin
					if (scoreRAM_Addr==0) begin
						topIDOne <= scoreRAM_Dout[3:0];
						topIDTwo <= scoreRAM_Dout[7:4];
						topIDThree <= scoreRAM_Dout[11:8];
						topIDFour <= scoreRAM_Dout[15:12];
						scoreRAM_Addr <= 1;
						Cycle <= 0;
						State <= WAIT;	
					end
					else begin
						topScoreOnes <= scoreRAM_Dout%10;
						topScoreTens <= scoreRAM_Dout/10;
						State <= INIT;
					end						
				end
				WAIT: begin
					if (Cycle > 2)
						State <= nextState;
					else
						Cycle <= Cycle+1;
				end
				default: begin
					State <= INIT;
				end
			endcase
		end
	end		

endmodule