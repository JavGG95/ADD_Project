module score_top (controlSig, isGuest, intIDin, scoreOnes, scoreTens, topIDOne_out, topIDTwo_out, 
	topIDThree_out, topIDFour_out, topScoreOnes_out, topScoreTens_out, clk, rst);

	input isGuest, clk, rst;
	input [2:0] controlSig, intIDin;
	input [3:0] scoreOnes, scoreTens;
	output [6:0] topIDOne_out, topIDTwo_out, topIDThree_out, topIDFour_out, 
	topScoreOnes_out, topScoreTens_out;
	wire scoreRAM_RW;
	wire [3:0] topIDOne, topIDTwo, topIDThree, topIDFour, scoreOnesOut, scoreTensOut;
	wire [4:0] intIDout;
	wire [15:0] topID;

	Scoring Scoring1(controlSig, isGuest, intIDin, scoreOnes, scoreTens, topID, intIDout, topIDOne, topIDTwo, 
					topIDThree, topIDFour, scoreOnesOut, scoreTensOut, clk, rst);
	UID_ROM Score_ROM(intIDout, clk, topID);
	dec_7seg dec_7seg1(scoreOnesOut, topScoreOnes_out);
	dec_7seg dec_7seg2(scoreTensOut, topScoreTens_out);
	dec_7seg dec_7seg3(topIDFour, topIDFour_out);
	dec_7seg dec_7seg4(topIDThree, topIDThree_out);
	dec_7seg dec_7seg5(topIDTwo, topIDTwo_out);
	dec_7seg dec_7seg6(topIDOne, topIDOne_out);



endmodule