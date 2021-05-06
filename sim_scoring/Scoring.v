module Scoring(timeOut, scoreReq, isGuest, intIDin, score, playerID, scoreRAM_Dout, intIDout, scoreRAM_RW, scoreRAM_Din, scoreRAM_Addr, topID, topScore, clk, rst);
	input timeOut, scoreReq, isGuest, clk, rst;
	input [2:0] intIDin;
	input [7:0] score;
	input [15:0] playerID, scoreRAM_Dout;
	output scoreRAM_RW;
	reg scoreRAM_RW;
	output [4:0] intIDout, scoreRAM_Addr;
	reg [4:0] intIDout, scoreRAM_Addr, Global, Cycle, Count;
	output [15:0] scoreRAM_Din, topID;
	reg [15:0] scoreRAM_Din, topID;
	output [7:0] topScore;
	reg [7:0] topScore;
	reg [2:0] State, nextState;
	parameter INIT = 0, GAMEOVER = 1, FETCH = 2, CHECK = 3, UPDATE = 4, RETRIEVE = 5, SEND = 6, WAIT = 7;

	always @(posedge clk) begin
		if (rst==1'b0)
			State <= INIT; 
		else begin
			case (State)
				INIT: begin
					if (timeOut==1'b1)
						State <= GAMEOVER;
				end
				GAMEOVER: begin
					scoreRAM_RW <= 1'b0;
					if (isGuest==1'b0) begin
						Global <= 0;
						State <= FETCH;
					end
					else if (scoreReq==1'b1)
						State <= RETRIEVE;
					else if (timeOut==1'b0)
						State <= INIT;					
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
						State <= RETRIEVE;
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
					scoreRAM_Addr <= 0;
					Cycle <= 0;
					nextState <= SEND;	
					if (scoreReq==1'b1)
						State <= WAIT;					
					else if (timeOut==1'b0)
						State <= INIT;		
				end
				SEND: begin
					if (scoreRAM_Addr==0) begin
						topID <= scoreRAM_Dout;
						scoreRAM_Addr <= 1;
						Cycle <= 0;
						State <= WAIT;	
					end
					else begin
						topScore <= scoreRAM_Dout;
						State <= RETRIEVE;
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