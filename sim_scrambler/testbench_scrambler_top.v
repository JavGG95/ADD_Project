`timescale 1 ns/ 100 ps
module testbench_scrambler_top ();
	reg RNG_gen, rst, clk;
	reg [1:0] mode;
	wire [2:0] index1, index2, index3, index4, index5, index6;
	wire done;
	always
		begin
			clk = 1'b0;
			#10;
			clk = 1'b1;
			#10;
		end
	scrambler_top scrambler_top1 (RNG_gen, mode, index1, index2, index3, index4, 
	index5, index6, done, rst, clk);
	
	initial 
		begin
			rst = 1'b1;
			mode = 2'b00;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);	
			rst = 1'b0;
			@(posedge clk);
			@(posedge clk);	
			@(posedge clk);
			@(posedge clk);		
			rst = 1'b1;
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
			mode = 2'b01; 
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
			mode = 2'b10;
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