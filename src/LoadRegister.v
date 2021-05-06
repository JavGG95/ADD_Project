module LoadRegister (D_in, D_out, clk, rst, Load);
	input [6:0] D_in;
	output [6:0] D_out;
	input clk, rst, Load;
	reg [6:0] D_out;
	
	always @ (posedge clk)
	begin
		if (rst == 1'b0)
			begin
				D_out <= 4'b0000000;
			end
		else
			begin
				if (Load == 1'b1)
					begin
						D_out <= D_in;
					end
			end
	end

endmodule 
