module mod_checker (en, index_in, index_out, done, rst, clk);
	input rst, clk, en;
	input [2:0] index_in;
	output [2:0] index_out;
	reg [2:0] index_out;
	output done;
	reg done;
	parameter Init = 3'b000, wait1 = 3'b001, wait2 = 3'b010, wait3 = 3'b011, Done = 3'b100; 
	reg [2:0] state;
	
	
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
				if (en == 1'b1) begin
					state <= wait1;
				end
			end
			wait1: begin
				done <= 1'b0;
				state <= wait2;
			end
			wait2: begin
				done <= 1'b0;
				state <= wait3;
			end
			wait3: begin
				done <= 1'b0;
				state <= Done;
			end
			Done: begin
				done <= 1'b1;
				index_out <= index_in;
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










	
