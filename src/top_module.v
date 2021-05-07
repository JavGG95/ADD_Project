module top_module (start, change, password, LEDs, PI1, PI2, Pass_digit, Disp1, Disp2, 
	Disp3, Disp4, Disp5, Disp6, rst, clk);

	input start, change, password, rst, clk;
	input [2:0] PI1, PI2;
	input [3:0] Pass_digit;
	output [9:0] LEDs;
	output [6:0]Disp1, Disp2, Disp3, Disp4, Disp5, Disp6;

	wire log_out_ctrl, log_in_ctrl, isGuest_ctrl, matchID, pass_Out, isCorrect,
	timeOut, Mux_Ctrl, logOut, isGuestOut, scramPls, flipPls, timerEn, timerReconfig,
	en;
	wire [1:0] lettNum;
	wire [2:0] intID_ctrl, controlSig, pIDout, indOut1, indOut2;
	wire [3:0] modeDisp;
	wire [4:0] intIDout;
	wire [6:0] score, Display1, Display2, Display3, Display4, Display5, Display6,
	topIDOne, topIDTwo, topIDThree, topIDFour, topScoreOnes, topScoreTens, 
	modeDisp_out;
	wire [15:0] playerID;
	

	
	Authentication Authentication1(clk, rst, Pass_digit, pass_Out, log_out_ctrl, 
	log_in_ctrl, isGuest_ctrl, intID_ctrl, matchID);
	ButtonShaper PassShaper(password, pass_Out, clk, rst);
	ButtonShaper StartShaper(start, start_Out, clk, rst);
	ButtonShaper ChangeShaper(change, change_Out, clk, rst);
	GameController GameController1(pass_Out, 1'b1, 1'b1, 1'b0,
	start_Out, change_Out, PI1, PI2, isCorrect, timeOut, controlSig, Mux_Ctrl, logOut,
	pIDout, isGuestOut, score, lettNum, modeDisp, scramPls, indOut1, indOut2, flipPls, 
	timerEn, timerReconfig, clk, rst);
	score_top score_top1(controlSig, isGuestOut, pIDout, score, topIDOne, topIDTwo, 
	topIDThree, topIDFour, topScoreOnes, topScoreTens, clk, rst);
	LED_Timer LED_Timer1(timerReconfig, timerEn, LEDs, timeOut, clk, rst);
	handler_top(start_Out, change_Out, indOut1, indOut2, lettNum, Display1, 
	Display2, Display3, Display4, Display5, Display6, en, isCorrect, clk, rst);
	dec_7seg dec_7seg1(modeDisp, modeDisp_out);
	Multiplexer(controlSig, modeDisp_out, Display1, Display2, Display3, Display4, 
	Display5, Display6, 
	topScoreOnes, topScoreTens, topIDFour, topIDThree, topIDTwo, topIDOne, 
	Disp1, Disp2, Disp3, Disp4, Disp5, Disp6, clk, rst);

endmodule
	






