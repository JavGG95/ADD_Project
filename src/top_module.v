module top_module (start, change, password, LEDs, PI1, PI2, Pass_digit, Disp1, Disp2, 
	Disp3, Disp4, Disp5, Disp6, rst, clk);

	input start, change, password, rst, clk;
	input [2:0] PI1, PI2;
	input [3:0] Pass_digit;
	output [9:0] LEDs;
	output [6:0]Disp1, Disp2, Disp3, Disp4, Disp5, Disp6;

	wire log_out_ctrl, log_in_ctrl, isGuest_ctrl, pass_Out, isCorrect,
	timeOut, isGuestOut, scramPls, flipPls, timerEn, timerReconfig, en;
	wire [1:0] lettNum;
	wire [2:0] intID_ctrl, controlSig, pIDout, indOut1, indOut2;
	wire [3:0] modeDisp, scoreOnes, scoreTens;
	wire [4:0] intIDout;
	wire [6:0] score, Display1, Display2, Display3, Display4, Display5, Display6,
	topIDOne, topIDTwo, topIDThree, topIDFour, scoreOnesOut, scoreTensOut, modeDisp_out;
	wire [9:0] authSig, timerSig;
	wire [15:0] playerID;
	

	
	Authentication Authentication1(clk, rst, Pass_digit, pass_Out, log_out_ctrl, 
	log_in_ctrl, isGuest_ctrl, intID_ctrl, authSig);
	
	ButtonShaper PassShaper(password, pass_Out, clk, rst);
	ButtonShaper StartShaper(start, start_Out, clk, rst);
	ButtonShaper ChangeShaper(change, change_Out, clk, rst);
	
	GameController GameController1(pass_Out, log_in_ctrl, intID_ctrl, isGuest_ctrl, start_Out, 
	change_Out, PI1, PI2, isCorrect, timeOut, controlSig, log_out_ctrl, pIDout, isGuestOut, scoreOnes, 
	scoreTens, lettNum, modeDisp, scramPls, indOut1, indOut2, flipPls, timerEn, timerReconfig, clk, rst);
	
	score_top score_top1(controlSig, isGuestOut, pIDout, scoreOnes, 
	scoreTens, topIDOne, topIDTwo, topIDThree, topIDFour, scoreOnesOut, scoreTensOut, clk, rst);
	
	LED_Timer LED_Timer1(timerReconfig, timerEn, timerSig, timeOut, clk, rst);
	
	handler_top handler_top1(start_Out, change_Out, indOut1, indOut2, lettNum, Display1, 
	Display2, Display3, Display4, Display5, Display6, en, isCorrect, clk, rst);
	dec_7seg dec_7seg1(modeDisp, modeDisp_out);
	
	LED_Mux Multiplexer1(controlSig, authSig, timerSig, LEDs);
	Disp_Mux Multiplexer2(controlSig, modeDisp_out, Display1, Display2, Display3, Display4, 
	Display5, Display6, scoreOnesOut, scoreTensOut, topIDOne, topIDTwo, topIDThree, topIDFour, 
	Disp1, Disp2, Disp3, Disp4, Disp5, Disp6, clk, rst);

endmodule
	






