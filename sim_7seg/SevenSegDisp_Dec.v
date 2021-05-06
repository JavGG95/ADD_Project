module SevenSegDisp_Dec(Data_in,Data_out);
	input [3:0] Data_in;
	output [6:0] Data_out;
	reg [6:0] Data_out;

	always @(Data_in) 
	begin
		case(Data_in)
			4'b0001: begin Data_out = 7'b1111001; end
			4'b0010: begin Data_out = 7'b0100100; end
			4'b0011: begin Data_out = 7'b0110000; end
			4'b0100: begin Data_out = 7'b0011001; end
			4'b0101: begin Data_out = 7'b0010010; end
			4'b0110: begin Data_out = 7'b0000010; end
			4'b0111: begin Data_out = 7'b1111000; end
			4'b1000: begin Data_out = 7'b0000000; end
			4'b1001: begin Data_out = 7'b0010000; end
			4'b1010: begin Data_out = 7'b0001000; end
			4'b1011: begin Data_out = 7'b0000011; end
			4'b1100: begin Data_out = 7'b1000110; end
			4'b1101: begin Data_out = 7'b0100001; end
			4'b1110: begin Data_out = 7'b0000110; end
			4'b1111: begin Data_out = 7'b0001110; end
			default: begin Data_out = 7'b1000000; end
		endcase
	end

endmodule
