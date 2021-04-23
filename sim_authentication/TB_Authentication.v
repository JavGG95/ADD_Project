// ECE 6370
// Author: Avish Gandhi, 9989
// TB_Authentication Module
//
// This is the testbench for the TB_Authentication
// including 2 ROMs for the FPGA: User ID and Password
//
// REG (simulating inputs)
// clk: 50MHz internal FPGA clock.
// rst: reset push-button on FPGA board
// pwdigit: 4-bit integer user inputs via toggle switches as ID or PW.
// pwenter: push-button when user is finished typing in ID or PW.
// log_out_ctrl: input from GameController sending pulse when to log out.
// 
// WIRE
// log_in_ctrl: output sent to GameController showing when User is logged in.
// isGuest_ctrl: passthrough output sent to GameController showing if it is a guest ID/PW
// intID_ctrl: passthrough output sent to GameController showing which User is playing.
`timescale 1ns/100ps
module TB_Authentication();

   reg  clk, rst, pwenter, log_out_ctrl;
   reg [3:0] pwdigit;
   reg [15:0] i;

   wire log_in_ctrl, isGuest_ctrl;
   wire [2:0] intID_ctrl;

   always 
      begin
         clk = 1'b0;
         #10;
         clk = 1'b1;
         #10;
      end

     Authentication   SignIn(clk, rst, pwdigit, pwenter,
                             log_out_ctrl, log_in_ctrl, isGuest_ctrl, intID_ctrl);

 //  ROM_PWD            MyROM(addr_ROM, clk, q_ROM);
//   ROM_Authentication MyPW_LOGIN(clk, rst, pwdigit, pwenter, 
//                                 logged_in, logged_out, q_ROM, addr_ROM);   

initial
      begin
        // No buttons being pressed right now
	rst        = 1'b1;
	pwenter    = 1'b0;	
        pwdigit    = 4'b0000;
        log_out_ctrl = 1'b0;
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
// reset button pressed and then unpressed
	#5 rst = 1'b0; 
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
	#5 rst = 1'b1; 
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
// Time to enter User ID: First attempt -- Failed
        // entering first value
        #5 pwdigit = 4'b1001;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering second value
        #5 pwdigit = 4'b1000;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering third value
        #5 pwdigit = 4'b0111;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering fourth value
        #5 pwdigit = 4'b0110;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
// Trying again to enter User ID, attempt #2: Success
        // entering first value
        for (i=0; i<16'b0000_0000_0100_0000; i=i+1)
                @(posedge clk);
        #5 pwdigit = 4'b1001;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering second value
        #5 pwdigit = 4'b1001;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering third value
        #5 pwdigit = 4'b1000;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering fourth value
        #5 pwdigit = 4'b1001;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
// Trying to enter Password, attempt #1: Failed
        // entering first value
        for (i=0; i<16'b0000_0000_0100_0000; i=i+1)
                @(posedge clk);
        #5 pwdigit = 4'b1010;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering second value
        #5 pwdigit = 4'b1011;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering third value
        #5 pwdigit = 4'b1100;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering fourth value
        #5 pwdigit = 4'b1101;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering fifth value
        #5 pwdigit = 4'b1110;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering sixth value
        #5 pwdigit = 4'b1111;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
// Trying to enter Password again, attempt #2: Success
        // entering first value
        for (i=0; i<16'b0000_0000_0100_0000; i=i+1)
                @(posedge clk);
        #5 pwdigit = 4'b0000;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering second value
        #5 pwdigit = 4'b0001;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering third value
        #5 pwdigit = 4'b0010;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering fourth value
        #5 pwdigit = 4'b1001;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering fifth value
        #5 pwdigit = 4'b1001;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        // entering sixth value
        #5 pwdigit = 4'b0011;
	@(posedge clk);
        #5 pwenter = 1'b1;	
	@(posedge clk);
        #5 pwenter = 1'b0;	
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
// Logging Out from Game Controller
	for (i=0; i<16'b0000_0000_0100_0000; i=i+1)
                @(posedge clk);
        #5 log_out_ctrl = 1'b1;
        for (i=0; i<16'b0000_0000_0000_1001; i=i+1)
                @(posedge clk);
        #5 log_out_ctrl = 1'b0;
        for (i=0; i<16'b0000_0000_0000_1110; i=i+1)
                @(posedge clk);
        end
endmodule
