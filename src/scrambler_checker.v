module scrambler_checker (ready, i1, i2, i3, i4, i5, i6, done, o1, o2, o3, o4, o5, o6, 
	clk, rst);
	input ready, clk, rst;
	input [2:0] i1, i2, i3, i4, i5, i6;
	output done;
	output [2:0] o1, o2, o3, o4, o5, o6;
	reg done;
	reg [2:0] o1, o2, o3, o4, o5, o6;
	parameter Init = 2'b00, scramble = 2'b01, Done = 2'b10; 
	reg [1:0] state;
	
	
	always @ (posedge clk)
	begin
		if (rst == 1'b0) begin
			done <= 1'b0;
			state <= Init;
		end
		else begin 
 			case (state)
			Init: begin
				done <= 1'b0;
				if (ready == 1'b1) begin
					state <= scramble;
				end
			end
			scramble: begin
				done <= 1'b0;
				state <= Done;
			end
			Done: begin
				done <= 1'b1;
				o1 <= i1;
				o2 <= i2;
				o3 <= i3;
				o4 <= i4;
				o5 <= i5;
				o6 <= i6;
				state <= Init;
			end
			default: begin
				done <= 1'b0;
				state <= Init;
			end
			endcase
		end
	end
endmodule









				
	
