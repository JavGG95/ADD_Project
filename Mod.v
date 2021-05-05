module mod(random, mode, index, rst, clk);
	input clk, rst;
	input [1:0] mode;
	input [3:0] random;
	output [2:0] index;
	reg [2:0] index;
	reg [3:0] random_number;
	
	always @ (random) begin
		random_number <= random;
	end
	always @ (posedge clk) begin
	if (rst == 1'b0) begin
		index <= 3'b000;
	end
	else if (mode == 2'b00) begin
		if (random_number > 4'b0011) begin
			random_number <= random_number - 4;
		end
	end
	if (mode == 2'b01) begin
		if (random_number > 4'b0100) begin
			random_number <= random_number - 5;
		end
	end
	if (mode == 2'b10) begin
		if (random_number > 4'b0101) begin
				random_number <= random_number - 6;
		end
	end
	index <= random_number[2:0];
	end
	
endmodule
