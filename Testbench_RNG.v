`timescale 1 ns/ 100 ps
module Testbench_RNG ();
	reg RNG_gen, clk, rst;
	wire [3:0] count_out;
	wire en;
	always
		begin
			clk = 1'b0;
			#10;
			clk = 1'b1;
			#10;
		end

	RNG RNG1(RNG_gen, count_out, en, clk, rst);

	initial 
		begin
			rst = 1'b1;
			RNG_gen = 1'b0;

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
			#15 RNG_gen = 1'b1;
			@(posedge clk); 
			#10 RNG_gen = 1'b0;
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
			#15 RNG_gen = 1'b1;
			@(posedge clk);
			#10 RNG_gen = 1'b0;
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
			#15 RNG_gen = 1'b1;
			@(posedge clk); 
			#10 RNG_gen = 1'b0;
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
			
	end
endmodule 
