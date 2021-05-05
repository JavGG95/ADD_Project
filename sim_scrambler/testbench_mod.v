`timescale 1 ns/ 100 ps
module testbench_mod ();
	reg clk, rst;
	reg [3:0] random;
	reg [1:0] mode;
	wire [2:0] index;
	always
		begin
			clk = 1'b0;
			#10;
			clk = 1'b1;
			#10;
		end

	mod mod_DUT(random, mode, index, rst, clk);
	
	initial 
		begin
			rst = 1'b1;
			@(posedge clk);
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
			@(posedge clk);	
			random = 4'b1111;
			mode = 2'b00;
			@(posedge clk);
			@(posedge clk);		
			@(posedge clk);
			@(posedge clk);	
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);		
			random = 4'b1110;
			mode = 2'b01;	
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
			random = 4'b1111;
			mode = 2'b10;	
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
					