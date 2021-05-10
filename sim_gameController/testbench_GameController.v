`timescale 1 ns/100 ps

module testbench_GameControl();
	reg pwdPls, logOn, isGuestIn, startPls, loadPls, isCorrect, timeOut, clk, rst;
	reg [2:0] pIDin, indIn1, indIn2;
	wire logOut, isGuestOut, scramPls, flipPls, timerEn, timerReconfig;
	wire [1:0] lettNum;
	wire [2:0] controlSig, pIDout, indOut1, indOut2;
	wire [3:0] modeDisp, scoreOnes, scoreTens;

	always begin 
		clk = 1'b0;
		#10 clk = 1'b1;
		#10;
	end

	GameController DUT_GameControl1er1(pwdPls, logOn, pIDin, isGuestIn, startPls, loadPls, indIn1, indIn2, isCorrect, timeOut, controlSig, logOut, 
		pIDout, isGuestOut, scoreOnes, scoreTens, lettNum, modeDisp, scramPls, indOut1, indOut2, flipPls, timerEn, timerReconfig, clk, rst);

	initial begin
		pwdPls = 1'b0; logOn = 1'b0;
		startPls = 1'b0; loadPls = 1'b0;
		pIDin = 1; isGuestIn = 1'b0;
		isCorrect = 1'b0; timeOut = 1'b0;
		
		@(posedge clk);	@(posedge clk);
		#5 rst = 1'b0;
		@(posedge clk); @(posedge clk);
		#5 rst = 1'b1;
		@(posedge clk); @(posedge clk);
		@(posedge clk); @(posedge clk);
		#5 indIn1 = 1; indIn2 = 2;
		startPls = 1'b1; loadPls = 1'b1;
		@(posedge clk);
		#5 startPls = 1'b0; loadPls = 1'b0;
		@(posedge clk); @(posedge clk);
		@(posedge clk); @(posedge clk);
		@(posedge clk); @(posedge clk);
		#5 indIn1 = 0; indIn2 = 0;
		#5 logOn = 1'b1;
		@(posedge clk); @(posedge clk);
		#5 loadPls = 1'b1; @(posedge clk);
		#5 loadPls = 1'b0; @(posedge clk);
		#5 loadPls = 1'b1; @(posedge clk);
		#5 loadPls = 1'b0; @(posedge clk);
		@(posedge clk); @(posedge clk);
		#5 startPls = 1'b1; @(posedge clk);
		#5 startPls = 1'b0;
		@(posedge clk); @(posedge clk);
		@(posedge clk); @(posedge clk);
		#5 indIn1 = 1; indIn2 = 2;
		startPls = 1'b1; loadPls = 1'b1;
		@(posedge clk);
		#5 startPls = 1'b0; loadPls = 1'b0;
		@(posedge clk); @(posedge clk);
		@(posedge clk); @(posedge clk);
		#5 indIn1 = 0; indIn2 = 0;
		@(posedge clk); @(posedge clk);
		#5 isCorrect = 1'b1; @(posedge clk);
		#5 isCorrect = 1'b0; @(posedge clk);
		#5 isCorrect = 1'b1; @(posedge clk);
		#5 isCorrect = 1'b0; @(posedge clk);
		#5 isCorrect = 1'b1; @(posedge clk);
		#5 isCorrect = 1'b0; @(posedge clk);
		#5 isCorrect = 1'b1; @(posedge clk);
		#5 isCorrect = 1'b0; @(posedge clk);
		@(posedge clk); @(posedge clk);
		#5 timeOut = 1'b1;
		@(posedge clk); @(posedge clk);
		@(posedge clk); @(posedge clk);
		#5 startPls = 1'b1; @(posedge clk);
		#5 startPls = 1'b0; @(posedge clk);
		@(posedge clk); @(posedge clk);	
		#5 timeOut = 1'b0;
		#5 loadPls = 1'b1; @(posedge clk);
		#5 loadPls = 1'b0; @(posedge clk);
		#5 loadPls = 1'b1; @(posedge clk);
		#5 loadPls = 1'b0; @(posedge clk);
		#5 loadPls = 1'b1; @(posedge clk);
		#5 loadPls = 1'b0; @(posedge clk);
		@(posedge clk); @(posedge clk);
		#5 startPls = 1'b1; @(posedge clk);
		#5 startPls = 1'b0; @(posedge clk);
		#5 startPls = 1'b1; @(posedge clk);
		#5 startPls = 1'b0; @(posedge clk);
		@(posedge clk); @(posedge clk);
		#5 loadPls = 1'b1; @(posedge clk);
		#5 loadPls = 1'b0; @(posedge clk);
		@(posedge clk); @(posedge clk);
		@(posedge clk); @(posedge clk);
		@(posedge clk); @(posedge clk);
		@(posedge clk); @(posedge clk);
		#5 pwdPls = 1'b1; @(posedge clk);
		#5 pwdPls = 1'b0; @(posedge clk);
		@(posedge clk); @(posedge clk);
		@(posedge clk); @(posedge clk);
	end

endmodule