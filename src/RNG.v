module RNG(RNG_gen, count_out, en, clk, rst);
	input RNG_gen, clk, rst;
	output [3:0] count_out;
	output en;
	reg en;
	reg [3:0] count_out;
	reg [3:0] LFSR;
  	wire feedback = LFSR[3] ^ (LFSR[2:0]==3'b000);
	
	always @ (posedge clk)
	begin
		if (rst == 1'b0)
		begin
			LFSR <= 4'b1111;
		end
		else
		begin
			en <= 1'b0;
			LFSR[0] <= feedback;
    			LFSR[1] <= LFSR[0] ^ feedback;
    			LFSR[2] <= LFSR[1];
    			LFSR[3] <= LFSR[2];
		end
		if (RNG_gen == 1'b0) begin
			count_out <= LFSR;
			en <= 1'b1;
		end
	end
endmodule

