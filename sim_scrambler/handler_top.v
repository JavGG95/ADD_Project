module handler_top(start, change, PI1, PI2, mode, Display1, Display2, Display3, Display4, 
	Display5, Display6, isCorrect, clk, rst);

	input start, change, clk, rst;
	input [2:0] PI1, PI2;
	input [1:0] mode;
	output isCorrect;
	output [6:0] Display1, Display2, Display3, Display4, Display5, Display6;

	wire [3:0] addr_input;
	wire RNG_en, scrambler_done, en;
	wire [2:0] index1, index2, index3, index4, index5, index6;
	wire [5:0] ROM_addr;
	wire [47:0] rom_data;
	wire [6:0] Disp1, Disp2, Disp3, Disp4, Disp5, Disp6;


	RNG RNG1(start, addr_input, RNG_en, clk, rst);
	scrambler_top scrambler_top1(start, mode, index1, index2, index3, index4, index5, index6, 
	scrambler_done, rst, clk);
	handler handler1(start, change, mode, addr_input, ROM_addr, rom_data, PI1, PI2, scrambler_done,
	isCorrect, index1, index2, index3, index4, index5, index6, Disp1, Disp2, Disp3, Disp4, 
	Disp5, Disp6, en, clk, rst);
	WORDROM WORDROM1(ROM_addr, clk, rom_data);
	LoadRegister LoadRegister1(Disp1, Display1, clk, rst, en);
	LoadRegister LoadRegister2(Disp2, Display2, clk, rst, en);
	LoadRegister LoadRegister3(Disp3, Display3, clk, rst, en);
	LoadRegister LoadRegister4(Disp4, Display4, clk, rst, en);
	LoadRegister LoadRegister5(Disp5, Display5, clk, rst, en);
	LoadRegister LoadRegister6(Disp6, Display6, clk, rst, en);

endmodule
