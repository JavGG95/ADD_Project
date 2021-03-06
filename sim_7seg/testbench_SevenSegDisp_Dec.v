`timescale 1 ns/100 ps
module testbench_SevenSegDisp_Dec( );
	reg [3:0] Data_in_s;
	wire [6:0] Data_out_s;

	SevenSegDisp_Dec DUT_SevenSegDisp_Dec(Data_in_s, Data_out_s);

	initial 
	begin
		Data_in_s = 4'b0000;

		// Test all 16 possible cases for the 7 segment display
		#10 Data_in_s = 4'b0000;
		#10 Data_in_s = 4'b0001;
		#10 Data_in_s = 4'b0010;
		#10 Data_in_s = 4'b0011;
		#10 Data_in_s = 4'b0100;
		#10 Data_in_s = 4'b0101;
		#10 Data_in_s = 4'b0110;
		#10 Data_in_s = 4'b0111;
		#10 Data_in_s = 4'b1000;
		#10 Data_in_s = 4'b1001;
		#10 Data_in_s = 4'b1010;
		#10 Data_in_s = 4'b1011;
		#10 Data_in_s = 4'b1100;
		#10 Data_in_s = 4'b1101;
		#10 Data_in_s = 4'b1110;
		#10 Data_in_s = 4'b1111;
	end
	
endmodule

