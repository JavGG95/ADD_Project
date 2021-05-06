`timescale 1 ns/ 100 ps
module Testbench_handler ();

	reg start, change, clk, rst;
	reg [2:0] PI1, PI2;
	reg [1:0] mode;
	wire isCorrect;
	wire [6:0] Display1, Display2, Display3, Display4, Display5, Display6;

	always
		begin
			clk = 1'b0;
			#10;
			clk = 1'b1;
			#10;
		end

	handler_top handler_top1(start, change, PI1, PI2, mode, Display1, Display2, Display3, Display4, 
	Display5, Display6, isCorrect, clk, rst);

	initial 
		begin
			rst = 1'b1;
			start = 1'b0;
			change = 1'b0;
			mode = 2'b00;
			PI1 = 3'b000;
			PI1 = 3'b000;

			@(posedge clk);
			@(posedge clk);
			#5 rst = 1'b0;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			#5 rst = 1'b1;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			start = 1'b1;
			@(posedge clk);
			start = 1'b0;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			start = 1'b1;
			@(posedge clk);
			start = 1'b0;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			PI1 = 3'b000;
			PI2 = 3'b001;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			change = 1'b1;
			@(posedge clk);
			change = 1'b0;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			PI1 = 3'b010;
			PI2 = 3'b011;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			change = 1'b1;
			@(posedge clk);
			change = 1'b0;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);

	end
endmodule
