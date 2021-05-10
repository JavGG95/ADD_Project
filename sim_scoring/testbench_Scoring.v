`timescale 1 ns/100 ps;

module testbench_Scoring ();
	reg clk, rst;
	//reg isGuest, clk, rst;
	//reg [2:0] controlSig, intIDin;
	//reg [3:0] scoreOnes, scoreTens;
	reg scoreRAM_RW;
	//wire [3:0] topIDOne, topIDTwo, topIDThree, topIDFour, topScoreOnes, topScoreTens;
	reg [4:0] scoreRAM_Addr;
	reg [15:0] scoreRAM_Din;
	wire [15:0] scoreRAM_Dout;

	always begin
		clk = 1'b0;
		#10;
		clk = 1'b1;
		#10;
	end

	//Scoring Scoring1(controlSig, isGuest, intIDin, scoreOnes, scoreTens, scoreRAM_Dout, scoreRAM_RW, scoreRAM_Din, scoreRAM_Addr, 
		//topIDOne, topIDTwo, topIDThree, topIDFour, topScoreOnes, topScoreTens, clk, rst);
	UID_ROM Score_ROM (Addr, clk, Dout);

	initial begin
		#5 Addr = 5'b00000; //First Pwd digit
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk);
		#5 Addr = 5'b00001; //Second Pwd digit
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		#5 Addr = 5'b00010; //Third Pwd digit
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		#5 Addr = 5'b00011; //Fourth Pwd digit
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		#5 Addr = 5'b00100; //Extra testing cases
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		#5 Addr = 5'b00101;
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 

		scoreRAM_RW = 0;

		#5 scoreRAM_Addr = 5'b00000; //First Pwd digit
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk);
		#5 scoreRAM_Addr = 5'b00001; //Second Pwd digit
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		#5 scoreRAM_Addr = 5'b00010; //Third Pwd digit
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		#5 scoreRAM_Addr = 5'b00011; //Fourth Pwd digit
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		#5 scoreRAM_Addr = 5'b00100; //Extra testing cases
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		#5 scoreRAM_Addr = 5'b00101;
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
		@(posedge clk); @(posedge clk); 
	end

endmodule
