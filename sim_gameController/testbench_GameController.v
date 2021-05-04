//`timescale 1 ns/100 ps
//
//module testbench_GameControl();
//	reg Log_Pls, P1_Pls, RNG_Pls, Log_In, Time_Out, Clk, Rst;
//	wire Log_Out, Pwd_Res, P1_Load, RNG_Load, Timer_En, Time_Reconfig;
//
//	always begin 
//		Clk = 1'b0;
//		#10 Clk = 1'b1;
//		#10;
//	end
//
//	GameControl DUT_GameControl1er(Log_Pls, P1_Pls, RNG_Pls, Log_In, Time_Out, Log_Out, Pwd_Res, P1_Load, RNG_Load, Timer_En, Time_Reconfig, Clk, Rst);
//
//	initial begin
//		Rst = 1'b1;
//		Log_Pls = 1'b0;
//		P1_Pls = 1'b0;
//		RNG_Pls = 1'b1;
//		Log_In = 1'b0; 
//		Time_Out = 1'b0;
//
//		@(posedge Clk);	@(posedge Clk);
//		#5 Rst = 1'b0;
//		@(posedge Clk); @(posedge Clk);
//		#5 Rst = 1'b1;
//		@(posedge Clk); @(posedge Clk);
//		// Load pulses ignored if not logged in
//		#5 P1_Pls = 1'b1; RNG_Pls = 1'b0;		
//		@(posedge Clk);
//		#5 P1_Pls = 1'b0; RNG_Pls = 1'b1;
//		@(posedge Clk); @(posedge Clk);
//		@(posedge Clk); @(posedge Clk);
//		// Input all four pwd digits correctly logs players in
//		Log_In = 1'b1; 
//		@(posedge Clk); @(posedge Clk);
//		@(posedge Clk); @(posedge Clk);
//		// Once logged in, the load pulses can be set
//		#5 Log_Pls = 1'b1;
//		@(posedge Clk);
//		#5 Log_Pls = 1'b0;
//		@(posedge Clk);	@(posedge Clk);
//		RNG_Pls = 1'b0;	
//		@(posedge Clk);	@(posedge Clk);		
//		@(posedge Clk);	@(posedge Clk);
//		RNG_Pls = 1'b1;	
//		@(posedge Clk); @(posedge Clk);
//		#5 P1_Pls = 1'b1;
//		@(posedge Clk);
//		#5 P1_Pls = 1'b0; RNG_Pls = 1'b1;
//		@(posedge Clk); @(posedge Clk);
//		@(posedge Clk); @(posedge Clk);
//		// The Time_Out signal ends the game
//		#5 Time_Out = 1'b1;
//		@(posedge Clk); @(posedge Clk);	
//		#5 Time_Out = 1'b0;
//		@(posedge Clk); @(posedge Clk);
//		#5 P1_Pls = 1'b1; RNG_Pls = 1'b0;	
//		@(posedge Clk);
//		#5 P1_Pls = 1'b0; RNG_Pls = 1'b1;	
//		@(posedge Clk); @(posedge Clk);
//		// Log_Pls restarts the game
//		#5 Log_Pls = 1'b1;
//		@(posedge Clk);
//		#5 Log_Pls = 1'b0;
//		@(posedge Clk); @(posedge Clk);	
//		#5 Log_Pls = 1'b1;
//		@(posedge Clk);
//		#5 Log_Pls = 1'b0;
//		@(posedge Clk); @(posedge Clk);
//		RNG_Pls = 1'b0;	
//		@(posedge Clk);	@(posedge Clk);		
//		RNG_Pls = 1'b1;	
//		@(posedge Clk); @(posedge Clk);
//		#5 P1_Pls = 1'b1;
//		@(posedge Clk);
//		#5 P1_Pls = 1'b0; RNG_Pls = 1'b1;
//		@(posedge Clk); @(posedge Clk);
//		@(posedge Clk); @(posedge Clk);
//		// P1_Pls after restarting game logs out
//		#5 Log_Pls = 1'b1;
//		@(posedge Clk);
//		#5 Log_Pls = 1'b0;
//		@(posedge Clk); @(posedge Clk);	
//		#5 P1_Pls = 1'b1;
//		@(posedge Clk);
//		#5 P1_Pls = 1'b0;
//		@(posedge Clk); @(posedge Clk);
//		@(posedge Clk); @(posedge Clk);	
//		// P1_Pls while RNG_Pls is low enters password changing mode
//		RNG_Pls = 1'b0;	
//		@(posedge Clk);	@(posedge Clk);		
//		#5 P1_Pls = 1'b1;
//		@(posedge Clk);
//		#5 P1_Pls = 1'b0; RNG_Pls = 1'b1;
//		@(posedge Clk); @(posedge Clk);
//		@(posedge Clk); @(posedge Clk);	
//	end
//
//endmodule