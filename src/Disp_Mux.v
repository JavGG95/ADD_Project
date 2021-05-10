// ECE 6370
// Author: Javier Garcia, 1266111
// Disp_Mux

// This multiplexer changes what is displayed based on the value of controlSig. When 
// controlSig is 0, the player is logged out and only dashes are shown. controlSig 
// equal to 1 means the player is in level select and the number of letters per word
// is shown in the top right display. During the game, controlSig is 2 and the letters
// are displayed. When the game is over, controlSig is 3 and the player's score is 
// shown in the middle two displays. Finally, controlSig being 4 or 5 means the current
// top scorer's ID and score are shown in the middle displays, respectively.

module Disp_Mux(controlSig, modeDisp, Scram0, Scram1, Scram2, Scram3, Scram4, Scram5, Score0, Score1, 
	Score2, Score3, Score4, Score5, Disp0, Disp1, Disp2, Disp3, Disp4, Disp5, clk, rst);
	input clk, rst;
	input [2:0] controlSig;
	input [7:0] modeDisp;
	input [7:0] Scram0, Scram1, Scram2, Scram3, Scram4, Scram5;
	input [7:0] Score0, Score1, Score2, Score3, Score4, Score5;
	output [7:0] Disp0, Disp1, Disp2, Disp3, Disp4, Disp5;
	reg [7:0] Disp0, Disp1, Disp2, Disp3, Disp4, Disp5;
	parameter DASH = 7'b0111111;

	always @(posedge clk) begin
		if (rst==1'b1) begin
			case (controlSig)
				4'b001: begin
					Disp0 <= modeDisp; Disp1 <= DASH; Disp2 <= DASH;
					Disp3 <= DASH; Disp4 <= DASH; Disp5 <= DASH;
				end
				4'b010: begin
					Disp0 <= Scram0; Disp1 <= Scram1; Disp2 <= Scram2;
					Disp3 <= Scram3; Disp4 <= Scram4; Disp5 <= Scram5;
				end
				4'b011: begin
					Disp0 <= DASH; Disp1 <= DASH; Disp2 <= Score0;
					Disp3 <= Score1; Disp4 <= DASH; Disp5 <= DASH;
				end
				4'b100: begin
					Disp0 <= DASH; Disp1 <= Score2; Disp2 <= Score3;
					Disp3 <= Score4; Disp4 <= Score5; Disp5 <= DASH;
				end
				4'b101: begin
					Disp0 <= DASH; Disp1 <= DASH; Disp2 <= Score0;
					Disp3 <= Score1; Disp4 <= DASH; Disp5 <= DASH;
				end
				default: begin
					Disp0 <= DASH; Disp1 <= DASH; Disp2 <= DASH;
					Disp3 <= DASH; Disp4 <= DASH; Disp5 <= DASH;
				end
			endcase
		end
	end

endmodule 