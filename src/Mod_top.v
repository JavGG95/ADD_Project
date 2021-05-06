module mod_top (en, random, mode, index_out, done, rst, clk);
	input rst, clk, en;
	output done;
	input [1:0] mode;
	input [3:0] random;
	output [2:0] index_out;
	wire [2:0] index;
	
	mod mod1(en, random, mode, index, rst, clk);
	mod_checker mod_checker1(en, index, index_out, done, rst, clk);
	
endmodule
