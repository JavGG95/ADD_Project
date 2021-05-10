// ECE 6370
// Author: Javier Garcia, 1266111
// Scoring module

// This module displays the player's score when a game is over, and checks it against
// the current top score. If it is higher, the top score is updated and the player's 
// internal ID is saved. When the top score is requested, the module uses the saved
// internal ID to retrieve the top scorer's ID from the UID_ROM, and outputs it along 
// with the current top score. 

module Scoring(controlSig, isGuest, intIDin, scoreOnes, scoreTens, topID, intIDout, topIDOne, topIDTwo, 
					topIDThree, topIDFour, scoreOnesOut, scoreTensOut, clk, rst);
	input isGuest, clk, rst;
	input [2:0] controlSig, intIDin;
	input [3:0] scoreOnes, scoreTens;
	input [15:0] topID;
	output [3:0] topIDOne, topIDTwo, topIDThree, topIDFour, scoreOnesOut, scoreTensOut;
	reg [3:0] topIDOne, topIDTwo, topIDThree, topIDFour, scoreOnesOut, scoreTensOut;
	output [4:0] intIDout;
	reg [4:0] intIDout;
	reg checked, retrieved;
	reg [2:0] Cycle, topIntID;
	reg [7:0] score, topScore;
	reg [2:0] State, nextState;
	parameter INIT = 0, CHECK = 1, RETRIEVE = 2, SEND = 3, WAIT = 4;

	always @(posedge clk) begin
		if (rst==1'b0) begin
			topScore <= 0;
			topIntID <= 0;
			State <= INIT;
		end	
		else begin
			case (State)
				INIT: begin
					if (controlSig<3) begin
						checked <= 1'b0;
						retrieved <= 1'b0;
					end
					else if (controlSig>3 && retrieved==1'b0)
						State <= RETRIEVE;
					else begin
						scoreOnesOut <= scoreOnes;
						scoreTensOut <= scoreTens;
						score <= {scoreTens, scoreOnes};
						if (isGuest==1'b0 && checked==1'b0)
							State <= CHECK;
					end
				end
				CHECK: begin
					if (score >= topScore) begin
						topScore <= score;
						topIntID <= intIDin;
					end
					checked <= 1'b1;
					State <= INIT;
				end
				RETRIEVE: begin
					intIDout <= topIntID;
					Cycle <= 0;
					State <= WAIT;
					nextState <= SEND;		
				end
				SEND: begin
					if (topIntID==1'b0) begin
						topIDOne <= 0;
						topIDTwo <= 0;
						topIDThree <= 0;
						topIDFour <= 0;
					end
					else begin
						topIDOne <= topID[3:0];
						topIDTwo <= topID[7:4];
						topIDThree <= topID[11:8];
						topIDFour <= topID[15:12];
					end
					scoreOnesOut <= topScore[3:0];
					scoreTensOut <= topScore[7:4];
					retrieved <= 1'b1;
					State <= INIT;
				end
				WAIT: begin
					if (Cycle > 3)
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