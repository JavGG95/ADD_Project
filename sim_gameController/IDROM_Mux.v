module IDROM_Mux(Mux_Ctrl, Auth_Sig, Score_Sig, Address);
	input Mux_Ctrl;
	input [4:0] Auth_Sig, Score_Sig;
	output [4:0] Address;
	reg [4:0] Address;

	always @(Mux_Ctrl) begin
		if (Mux_Ctrl==1'b1)
			Address <= Score_Sig;
		else
			Address <= Auth_Sig;
	end

endmodule
