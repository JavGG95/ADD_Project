`timescale 1 ns/100 ps;

module testbench_Scoring ();
	reg isGuest, clk, rst;
	reg [2:0] controlSig, intIDin;
	reg [3:0] scoreOnes, scoreTens;
	reg scoreRAM_RW;
	wire [3:0] topIDOne, topIDTwo, topIDThree, topIDFour, scoreOnesOut, scoreTensOut;
	wire [4:0] intIDout;
	wire [15:0] topID;

	always begin
		clk = 1'b0;
		#10;
		clk = 1'b1;
		#10;
	end

	Scoring Scoring1(controlSig, isGuest, intIDin, scoreOnes, scoreTens, topID, intIDout, topIDOne, topIDTwo, 
		 	topIDThree, topIDFour, scoreOnesOut, scoreTensOut, clk, rst);
	UID_ROM Score_ROM (intIDout, clk, topID);

	initial begin

	end

endmodule
