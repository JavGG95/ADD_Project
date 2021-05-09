module LED_Mux(controlSig, authSig, timerSig, LEDs);
	input [2:0] controlSig;
	input [9:0] authSig, timerSig;
	output [9:0] LEDs;
	reg [9:0] LEDs;

	always @(controlSig) begin
		if (controlSig==2 || controlSig ==3)
			LEDs <= timerSig;
		else
			LEDs <= authSig;
	end

endmodule