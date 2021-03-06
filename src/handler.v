module handler (start, change, mode, addr_input, ROM_addr, rom_data, PI1, PI2, done_scrambler,
	isCorrect, index1, index2, index3, index4, index5, index6, Disp1, Disp2, Disp3, Disp4, Disp5, 
	Disp6, en, clk, rst);
	input start, change, done_scrambler, clk, rst;
	input [1:0] mode;
	input [47:0] rom_data;
	input [3:0] addr_input;
	input [2:0] index1, index2, index3, index4, index5, index6, PI1, PI2;
	output [5:0] ROM_addr;
	output isCorrect, en;
	output [6:0] Disp1, Disp2, Disp3, Disp4, Disp5, Disp6;
	reg [6:0] Disp1, Disp2, Disp3, Disp4, Disp5, Disp6;
	reg [5:0] ROM_addr;
	reg isCorrect, en;
	reg [6:0] display [6:0];
	reg [2:0] temp;
	reg [1:0] count;
	parameter Init = 5'b00000,/* Waiting = 5'b00001,*/ Fetch_ROM = 5'b00010, Delay_CYC1 = 5'b00011,
		Delay_CYC2 = 5'b00100, ROM_Catch = 5'b00101, PreDisplay = 5'b00110, Display = 5'b00111, 
		WaitForScramble = 5'b01000, WaitScramble = 5'b01001, Scrambler = 5'b01010,
		ScrambledDisplay = 5'b01011, WaitForPlayer = 5'b01100, ChangeIndice = 5'b01101,
		ChangedDisplay = 5'b01110, check = 5'b01111; 
	reg [4:0] state;
	reg [47:0] ROM_digit;
	always @ (posedge clk)
	begin
		if (rst == 1'b0) begin
			state <= Init;
			count <= 2'b00;
			en <= 1'b0;
			isCorrect <= 1'b0;
		end
		else begin 
 			case (state)
			Init: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				if (start == 1'b1) begin
					state <= Fetch_ROM;
				end
			end
			/*Waiting: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				if (done_RNG == 1'b1)
					state <= Fetch_ROM;
			end*/
			Fetch_ROM: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				if (mode == 2'b00)
					ROM_addr <= {2'b00, addr_input};
				else if (mode == 2'b01)
					ROM_addr <= {2'b01, addr_input};
				else 
					ROM_addr <= {2'b10, addr_input};
				state <= Delay_CYC1;
			end
			Delay_CYC1: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				if (mode == 2'b00)
					ROM_addr <= addr_input;
				else if (mode == 2'b01)
					ROM_addr <= addr_input + 6'b010000;
				else 
					ROM_addr <= addr_input + 6'b100000;
				state <= Delay_CYC2;
			end
			Delay_CYC2: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				if (mode == 2'b00)
					ROM_addr <= addr_input;
				else if (mode == 2'b01)
					ROM_addr <= addr_input + 6'b010000;
				else 
					ROM_addr <= addr_input + 6'b100000;
				state <= ROM_Catch;
			end			
			ROM_Catch: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				if (mode == 2'b00)
					ROM_addr <= addr_input;
				else if (mode == 2'b01)
					ROM_addr <= addr_input + 6'b010000;
				else 
					ROM_addr <= addr_input + 6'b100000;
				ROM_digit <= rom_data;
				state <= Display;
			end
			PreDisplay: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				display[0] <= ROM_digit[6:0];
				display[1] <= ROM_digit[14:8];
				display[2] <= ROM_digit[22:16];
				display[3] <= ROM_digit[30:24];
				display[4] <= ROM_digit[38:32];
				display[5] <= ROM_digit[46:40];
				state <= Display;
			end
			Display: begin
				en <= 1'b1;
				isCorrect <= 1'b0;
				display[0] <= ROM_digit[6:0];
				display[1] <= ROM_digit[14:8];
				display[2] <= ROM_digit[22:16];
				display[3] <= ROM_digit[30:24];
				display[4] <= ROM_digit[38:32];
				display[5] <= ROM_digit[46:40];
				state <= WaitForScramble;
			end
			WaitForScramble: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				if (start == 1'b1)
					state <= WaitScramble;
			end
			WaitScramble: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				if (done_scrambler == 1'b1)
					state <= Scrambler;
			end
			Scrambler: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				display[index1] <= ROM_digit[6:0];
				display[index2] <= ROM_digit[14:8];
				display[index3] <= ROM_digit[22:16];
				display[index4] <= ROM_digit[30:24];
				display[index5] <= ROM_digit[38:32];
				display[index6] <= ROM_digit[46:40];
				state <= ScrambledDisplay;
			end
			ScrambledDisplay: begin
				en <= 1'b1;
				isCorrect <= 1'b0;/*
				display[index1] <= ROM_digit[6:0];
				display[index2] <= ROM_digit[14:8];
				display[index3] <= ROM_digit[22:16];
				display[index4] <= ROM_digit[30:24];
				display[index5] <= ROM_digit[38:32];
				display[index6] <= ROM_digit[46:40];*/
				state <= WaitForPlayer;
			end
			WaitForPlayer: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				if (change == 1'b1) begin
					state <= ChangeIndice;
				end
			end
			ChangeIndice: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				if (mode == 2'b00) begin
					if (PI1 < 3'b100 & PI2 < 3'b100) begin
						display[PI1] <= display[PI2];
						display[PI2] <= display[PI1];
					end
				end
				if (mode == 2'b01) begin
					if (PI1 < 3'b101 & PI2 < 3'b101) begin
						display[PI1] <= display[PI2];
						display[PI2] <= display[PI1];
					end
				end
				if (mode == 2'b10) begin
					if (PI1 < 3'b110 & PI2 < 3'b110) begin
						display[PI1] <= display[PI2];
						display[PI2] <= display[PI1];
					end
				end
				state <= ChangedDisplay;
			end
			ChangedDisplay: begin
				en <= 1'b1;
				isCorrect <= 1'b0;
				state <= check;
			end
			check: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				if (    display[0] == ROM_digit[6:0] & 
					display[1] == ROM_digit[14:8] & 
					display[2] == ROM_digit[22:16] &
					display[3] == ROM_digit[30:24] & 
					display[4] == ROM_digit[38:32] & 
					display[5] == ROM_digit[46:40] ) begin
					isCorrect <= 1'b1;
					state <= Init;
				end
				else begin  
					isCorrect <= 1'b0;
					state <= WaitForPlayer;
				end
			end
			default: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				state <= Init;
			end
			endcase
		end
		Disp1 <= display[0];
		Disp2 <= display[1];
		Disp3 <= display[2];
		Disp4 <= display[3];
		Disp5 <= display[4];
		Disp6 <= display[5];
	end
endmodule
				
	












