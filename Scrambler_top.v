module scrambler_top (RNG_gen, mode, index1, index2, index3, index4, index5, index6, done, rst, clk);
	input RNG_gen, rst, clk;
	input [1:0] mode;
	output done;
	output [2:0] index1, index2, index3, index4, index5, index6;
	wire  ready, en;
	wire [2:0] index;
	wire [3:0] count;
	
	RNG RNG (RNG_gen, count, en, clk, rst);
	mod_top mod_top1 (en, count, mode, index, ready, rst, clk);
	scrambler_done scrambler_done1 (ready, index, mode, index1, index2, index3, 
		index4, index5, index6, done, rst, clk);
endmodule
	
	
