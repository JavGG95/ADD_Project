module scrambler (index, mode, index1, index2, index3, index4, index5, index6, 
	rst, clk);
	input rst, clk;
	input [2:0] index;
	input [1:0] mode;
	output [2:0] index1, index2, index3, index4, index5, index6;
	reg [2:0] index1, index2, index3, index4, index5, index6;
	

	
	always @ (posedge clk) begin
		if (rst == 1'b0) 
		begin
			index1 <= 3'b000;
			index2 <= 3'b001;
			index3 <= 3'b010;
			index4 <= 3'b011;
			index5 <= 3'b100;
			index6 <= 3'b101;

		end
		if (mode == 2'b00) 
		begin
			case (index)
				3'b000: begin
					index1 <= 3'b001;
					index2 <= 3'b000;
					index3 <= 3'b011;
					index4 <= 3'b010;
					index5 <= 3'b100;
					index6 <= 3'b101;
				end
				3'b001: begin
					index1 <= 3'b011;
					index2 <= 3'b010;
					index3 <= 3'b001;
					index4 <= 3'b000;
					index5 <= 3'b100;
					index6 <= 3'b101;
				end
				3'b010: begin
					index1 <= 3'b011;
					index2 <= 3'b010;
					index3 <= 3'b001;
					index4 <= 3'b000;
					index5 <= 3'b100;
					index6 <= 3'b101;
				end
				3'b011: begin
					index1 <= 3'b000;
					index2 <= 3'b010;
					index3 <= 3'b011;
					index4 <= 3'b001;
					index5 <= 3'b100;
					index6 <= 3'b101;
				end
				default: begin 
					index1 <= 3'b000;
					index2 <= 3'b001;
					index3 <= 3'b010;
					index4 <= 3'b011;
					index5 <= 3'b100;
					index6 <= 3'b101;
				end
			endcase
		end
		if (mode == 2'b01) 
		begin
			case (index)
				3'b000: begin
					index1 <= 3'b001;
					index2 <= 3'b011;
					index3 <= 3'b100;
					index4 <= 3'b010;
					index5 <= 3'b000;
					index6 <= 3'b101;
				end
				3'b001: begin
					index1 <= 3'b010;
					index2 <= 3'b000;
					index3 <= 3'b011;
					index4 <= 3'b100;
					index5 <= 3'b001;
					index6 <= 3'b101;
				end
				3'b010: begin
					index1 <= 3'b000;
					index2 <= 3'b100;
					index3 <= 3'b010;
					index4 <= 3'b011;
					index5 <= 3'b001;
					index6 <= 3'b101;
				end
				3'b011: begin
					index1 <= 3'b011;
					index2 <= 3'b010;
					index3 <= 3'b000;
					index4 <= 3'b100;
					index5 <= 3'b001;
					index6 <= 3'b101;
				end
				3'b100: begin
					index1 <= 3'b100;
					index2 <= 3'b001;
					index3 <= 3'b010;
					index4 <= 3'b000;
					index5 <= 3'b011;
					index6 <= 3'b101;
				end
				default: begin 
					index1 <= 3'b000;
					index2 <= 3'b001;
					index3 <= 3'b010;
					index4 <= 3'b011;
					index5 <= 3'b100;
					index6 <= 3'b101;
				end
			endcase
		end
		if (mode == 2'b10) 
		begin
			case (index)
				3'b000: begin
					index1 <= 3'b001;
					index2 <= 3'b011;
					index3 <= 3'b100;
					index4 <= 3'b101;
					index5 <= 3'b010;
					index6 <= 3'b000;
				end
				3'b001: begin
					index1 <= 3'b010;
					index2 <= 3'b100;
					index3 <= 3'b000;
					index4 <= 3'b101;
					index5 <= 3'b001;
					index6 <= 3'b011;
				end
				3'b010: begin
					index1 <= 3'b011;
					index2 <= 3'b001;
					index3 <= 3'b010;
					index4 <= 3'b100;
					index5 <= 3'b000;
					index6 <= 3'b101;
				end
				3'b011: begin
					index1 <= 3'b000;
					index2 <= 3'b011;
					index3 <= 3'b100;
					index4 <= 3'b001;
					index5 <= 3'b101;
					index6 <= 3'b010;
				end
				3'b100: begin
					index1 <= 3'b100;
					index2 <= 3'b000;
					index3 <= 3'b101;
					index4 <= 3'b011;
					index5 <= 3'b010;
					index6 <= 3'b001;
				end
				3'b101: begin
					index1 <= 3'b101;
					index2 <= 3'b010;
					index3 <= 3'b000;
					index4 <= 3'b011;
					index5 <= 3'b100;
					index6 <= 3'b001;
				end
				default: begin 
					index1 <= 3'b000;
					index2 <= 3'b001;
					index3 <= 3'b010;
					index4 <= 3'b011;
					index5 <= 3'b100;
					index6 <= 3'b101;
				end
			endcase
			
		end
	end
endmodule
		




















				
