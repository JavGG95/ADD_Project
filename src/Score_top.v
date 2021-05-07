module score_top (controlSig, isGuest, intIDin, score, topIDOne_out, topIDTwo_out, 
	topIDThree_out, topIDFour_out, topScoreOnes_out, topScoreTens_out, clk, rst);

	input isGuest, clk, rst;
	input [2:0] controlSig, intIDin;
	input [7:0] score;
	output [6:0] topIDOne_out, topIDTwo_out, topIDThree_out, topIDFour_out, 
	topScoreOnes_out, topScoreTens_out;
	wire scoreRAM_RW;
	wire [4:0] scoreRAM_Addr;
	wire [15:0] scoreRAM_Dout, scoreRAM_Din;

	Scoring Scoring1(controlSig, isGuest, intIDin, score, playerID, scoreRAM_Dout, 
	intIDout, scoreRAM_RW, scoreRAM_Din, scoreRAM_Addr, topIDOne, topIDTwo, 
	topIDThree, topIDFour, topScoreOnes, topScoreTens, clk, rst);
	Score_RAM Score_RAM1(scoreRAM_Addr, clk, scoreRAM_Din, scoreRAM_RW, scoreRAM_Dout);
	dec_7seg dec_7seg1(topScoreOnes, topScoreOnes_out);
	dec_7seg dec_7seg2(topScoreTens, topScoreTens_out);
	dec_7seg dec_7seg3(topIDFour, topIDFour_out);
	dec_7seg dec_7seg4(topIDThree, topIDThree_out);
	dec_7seg dec_7seg5(topIDTwo, topIDTwo_out);
	dec_7seg dec_7seg6(topIDOne, topIDOne_out);



endmodule