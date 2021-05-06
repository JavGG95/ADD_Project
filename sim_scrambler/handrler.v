module handler (start, mode, addr_input, rom_addr, rom_data, change, done, isCorrect, index1, index2,
	index3, index4, index5, index6, en, clk, rst);
	input start, change, done, clk, rst;
	input [1:0] mode;
	input [47:0] rom_data;
	input [5:0] addr_input;
	input [2:0] index1, index2, index3, index4, index5, index6;
	output [5:0] ROM_addr;
	output isCorrect, en;
	reg [5:0] ROM_addr;
	reg isCorrect, en;
	reg [6:0] display [2:0];
	reg [1:0] count;
	parameter Init = 4'b0000, Waiting = TODO, Fetch_ROM = 4'b0001, Delay_CYC1 = 4'b0010,
		Delay_CYC2 = 4'b0011, ROM_Catch = 4'b0100, PreDisplay = TODO, Display = TODO, 
		Check = 4'b0110, 
		Verify = 4'b0111, Waiting = 4'b1000, Reset = 4'b1001, 
		Reset_delay1 = 4'b1010, Reset_delay2 = 4'b1011, RAM_Catch = 4'b1100, 
		Check_reset = 4'b1101; 
	reg [3:0] state;
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
				if (start == 1'b0) begin
					state <= Waiting;
				end
			end
			Waiting: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				if (done == 1'b1)
					state <= Fetch_ROM;
			end
			Fetch_ROM: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				if (mode == 2'b00)
					ROM_addr <= addr_input;
				else if (mode == 2'b01)
					ROM_addr <= addr_input + 6'b010000;
				else 
					ROM_addr <= addr_input + 6'b100000;
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
				state <= display;
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
			Display: begin
				en <= 1'b0;
				isCorrect <= 1'b0;
				if (change == 1'b1)
					state <= Scramble;
			end
















