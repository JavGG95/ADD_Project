module scrambler_done (ready, index, mode, index1, index2, index3, index4, index5, index6, done, rst, clk);
	input ready, rst, clk;
	output done;
	input [2:0] index;
	input [1:0] mode;
	output [2:0] index1, index2, index3, index4, index5, index6;
	wire [2:0] i1, i2, i3, i4, i5, i6;
	
	scrambler scrambler1 (index, mode, i1, i2, i3, i4, i5, i6, rst, clk);
	scrambler_checker scrambler_checker1(ready, i1, i2, i3, i4, i5, i6, done, index1, index2, index3,
		index4, index5, index6, clk, rst);
	
endmodule
