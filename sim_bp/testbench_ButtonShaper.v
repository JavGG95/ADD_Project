`timescale 1 ns/100 ps

module testbench_ButtonShaper( );
	reg Button_In, Clk, Rst;
	wire Button_Out;

	always begin
		Clk = 1'b0;
		#10 Clk = 1'b1;
		#10;
	end

	ButtonShaper DUT_ButtonShaper1(Button_In, Button_Out, Clk, Rst);

	initial begin
		Rst = 1'b1;
		Button_In = 1'b1;
		
		@(posedge Clk); @(posedge Clk);
		#5 Rst = 1'b0;
		@(posedge Clk); @(posedge Clk);
		#5 Rst = 1'b1;
		@(posedge Clk); @(posedge Clk);
		//Test one button press
		#5 Button_In = 1'b0;
		@(posedge Clk); @(posedge Clk);
		@(posedge Clk);	@(posedge Clk);
		@(posedge Clk);	@(posedge Clk);
		@(posedge Clk);	@(posedge Clk);
		@(posedge Clk);	@(posedge Clk);
		#5 Button_In = 1'b1;
		@(posedge Clk);	@(posedge Clk);
		//Test that the reset signal prevents a pulse even when the button is pressed
		#5 Rst = 1'b0;
		@(posedge Clk);	@(posedge Clk);
		#5 Button_In = 1'b0;
		@(posedge Clk);	@(posedge Clk);
		@(posedge Clk);	@(posedge Clk);
		#5 Button_In = 1'b1;
		@(posedge Clk);	@(posedge Clk);
		#5 Rst = 1'b1;
		@(posedge Clk);	@(posedge Clk);
		@(posedge Clk);	@(posedge Clk);
		//Test two button presses with a slight wait between them
		#5 Button_In = 1'b0;
		@(posedge Clk); @(posedge Clk);
		@(posedge Clk);	@(posedge Clk);
		@(posedge Clk);	@(posedge Clk);
		@(posedge Clk);	@(posedge Clk);
		#5 Button_In = 1'b1;
		@(posedge Clk); @(posedge Clk);
		@(posedge Clk);	@(posedge Clk);
		#5 Button_In = 1'b0;
		@(posedge Clk); @(posedge Clk);
		@(posedge Clk);	@(posedge Clk);
		@(posedge Clk);	@(posedge Clk);
		@(posedge Clk);	@(posedge Clk);
	end

endmodule

		