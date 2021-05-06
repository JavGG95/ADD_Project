module ButtonShaper(Button_In, Button_Out, Clk, Rst);
	input Button_In, Clk, Rst;
	output Button_Out;
	reg Button_Out;
	reg [1:0] State, StateNext;
	parameter INIT = 0, PULSE = 1, WAIT = 2;

	always @(State, Button_In) begin
		case(State)
			INIT: begin
				Button_Out = 1'b0;
				if(Button_In == 1'b0)
					StateNext = PULSE;
				else
					StateNext = INIT;
			end
			PULSE: begin
				Button_Out = 1'b1;
				StateNext = WAIT;
			end
			WAIT: begin
				Button_Out = 1'b0;
				if(Button_In == 1'b1)
					StateNext = INIT;
				else
					StateNext = WAIT;
			end
			default: begin
				Button_Out = 1'b0;
				StateNext = INIT;
			end
		endcase
	end

	always @(posedge Clk) begin
		if(Rst == 1'b0)
			State <= INIT;
		else
			State <= StateNext;
	end

endmodule
