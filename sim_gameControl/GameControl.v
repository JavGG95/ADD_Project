module GameControl(Log_Pls, P1_Pls, RNG_Pls, Log_In, Time_Out, Log_Out, Pwd_Res, P1_Load, RNG_Load, Timer_En, Time_Reconfig, Clk, Rst);
	input Log_Pls, P1_Pls, RNG_Pls, Log_In, Time_Out, Clk, Rst;
	output Log_Out, Pwd_Res, P1_Load, RNG_Load, Timer_En, Time_Reconfig;
	reg Log_Out, Pwd_Res, P1_Load, RNG_Load, Timer_En, Time_Reconfig;
	reg [3:0] State;
	parameter INIT = 0, SETUP = 1, RNGING = 2, NEWRNG = 3, PTURN = 4, VERIFY = 5, GAMEOVER = 6, LOGOUT = 7;

	always @(posedge Clk) begin
		if (Rst == 1'b0)
			State <= INIT;
		else begin
			case(State)
				INIT: begin
					Log_Out <= 1'b0;
					Pwd_Res <= 1'b0;
					P1_Load <= 1'b0;
					RNG_Load <= 1'b1;
					Timer_En <= 1'b0;
					Time_Reconfig <= 1'b0;
					if (Log_In == 1'b1) begin
						Time_Reconfig <= 1'b1;
						State <= SETUP;
					end
				end
				SETUP: begin
					P1_Load <= 1'b0;	
					Timer_En <= 1'b0;
					Time_Reconfig <= 1'b0;
					if (P1_Pls == 1'b1) begin
						Log_Out <= 1'b1;
						if (RNG_Pls == 1'b0)
							Pwd_Res <= 1'b1;
						State <= LOGOUT;		
					end
					else if (Log_Pls == 1'b1) begin
						Timer_En <= 1'b1;
						State <= RNGING;
					end
				end
				RNGING: begin
					if (Log_Pls == 1'b1) begin
						Time_Reconfig <= 1'b1;
						State <= SETUP;	
					end
					else if (Time_Out == 1'b1)
						State <= GAMEOVER;	
					else if (RNG_Pls == 1'b0) begin
						RNG_Load <= RNG_Pls;
						State <= NEWRNG;			
					end
				end
				NEWRNG: begin	
					if (RNG_Pls == 1'b1) begin
						RNG_Load <= RNG_Pls;	
						State <= PTURN;	
					end			
					else if (Time_Out == 1'b1)
						State <= GAMEOVER;	
				end
				PTURN: begin
					P1_Load <= P1_Pls;
					if (Log_Pls == 1'b1) begin
						Time_Reconfig <= 1'b1;
						State <= SETUP;	
					end
					else if (Time_Out == 1'b1)
						State <= GAMEOVER;		
					else if (P1_Pls == 1'b1) begin
						State <= VERIFY;
					end
				end
				VERIFY: begin
					P1_Load <= 1'b0;	
					State <= RNGING;
				end
				GAMEOVER: begin
					P1_Load <= 1'b0;	
					if (Log_Pls == 1'b1) begin
						Time_Reconfig <= 1'b1;
						State <= SETUP;	
					end				
				end
				LOGOUT: begin
					State <= INIT;
				end
				default: begin
					State <= INIT;
				end
			endcase
		end
	end
	
endmodule
	