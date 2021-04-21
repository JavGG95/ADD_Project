// ECE 6370
// Author: Avish Gandhi, 9989
// ROM_Authentication Module
// INPUTS
// clk: internal 50 MHz clock on FPGA Hardware
// rst: reset physical push-button on FPGA Hardware (inverse logic), 
// 	reset all values back to default
// pwdigit: 4-bit user-input from toggle switches to type in the password
// pwenter: a push-button coming from the button-shaper as a single cycle pulse
// 	    to enter the typed in password value
//          afterwords logged in: used to Start the game. 
// load_p1_in: a push-button coming from the button-shaper as a single cycle pulse
//	       enters the types in value from player 1's set of switches.
// load_RNG_in: a push-button, without using a button-shaper,
// 		enters a random value based on how long user pushed the button
// timeout: A flag notifying this module when the timer for the game has run out.
// OUTPUTS
// logged_in/logged_out: Status if the user has been logged into the system.
// load_p1_out/load_RNG_out: allows the values to be passed through to other modules when 1.
// timer_reconfig: tells the timer to reset values back to default values
// 		   without having to reset the whole board
// timer_enable: tells the timer when to start counting.
// REG
// State: The current state of the finite state machine.
// Sofarsogood: a flag that keeps checking to see if the user has typed in any
//		incorrect password values.
// HOW TO UNLOCK
// The user needs to type in password values to log into the system so they can play the game.
// After the system has been unlocked, the user will be logged in:
// the logged_in flag will be on and logged_out flag will be off
// player 1 and RNG inputs will transfer through to other modules allowing to play the game.
// Note: Currently, the password is set to 9989 in order to test my system.
// Status: SUCCESSFUL for both Wrong Passwords and Correct Passwords.
module PW_Checking(clk, rst, pwdigit, pwenter, matchID, isGuest, intID, log_out_ctrl,
                   log_out, isGuest_ctrl, intID_ctrl, log_in_ctrl, 
                   q_PW_ROM, addr_PW_ROM);
   
   input  clk, rst, pwenter, matchID, isGuest, log_out_ctrl;
   input [2:0] intID;
   input [3:0] pwdigit;

   output log_out, isGuest_ctrl, log_in_ctrl;
   reg log_out, isGuest_ctrl, log_in_ctrl, attempt;

   output [2:0] intID_ctrl;
   reg [2:0] intID_ctrl, count;

   input [23:0] q_PW_ROM;
   reg [23:0] data_PW_ROM, PW;

   output [4:0] addr_PW_ROM;
   reg [4:0] addr_PW_ROM;

   parameter INIT = 0, FIRST = 1, SECOND = 2, THIRD = 3, FOURTH = 4, FIFTH = 5, SIXTH = 6,
             ROM_FETCHWD = 7, ROM_CYCLE1 = 8, ROM_CYCLE2 = 9, ROM_CATCH = 10,
             COMPARE = 11, PASSED = 12, WAIT_LOGOUT = 13;			 

   reg [3:0] State;

always@(posedge clk) begin
   if (rst==1'b0)
      begin
         addr_PW_ROM<=5'b00000;
         data_PW_ROM<=24'b0000_0000_0000_0000_0000_0000;
         PW<= 24'b0000_0000_0000_0000_0000_0000;
         attempt<= 1'b0;
         count<=2'b00;
         log_out<=1'b0;
         log_in_ctrl<=1'b0;
         isGuest_ctrl<=1'b0;
         intID_ctrl<= 2'b00;
      end
   else
      begin
         case (State)
            INIT: begin
            addr_PW_ROM<=5'b00000;
            data_PW_ROM<=24'b0000_0000_0000_0000_0000_0000;
            PW<= 24'b0000_0000_0000_0000_0000_0000;
            attempt<= 1'b0;
            count<=2'b00;
            log_out<=1'b0;
            log_in_ctrl<=1'b0;
            isGuest_ctrl<=1'b0;
            intID_ctrl<= 2'b00;
            end
            FIRST: begin
               if (pwenter==1'b1) begin 
                  PW[23:20] <= pwdigit;
                  State<=SECOND;
               end
               else State<=FIRST;
            end
            SECOND: begin
               if (pwenter==1'b1) begin 
                  PW[19:16] <= pwdigit;
                  State<=THIRD;
               end
               else State<=SECOND;
            end
            THIRD: begin
               if (pwenter==1'b1) begin 
                  PW[15:12] <= pwdigit;
                  State<=FOURTH;
               end
               else State<=THIRD;
            end
            FOURTH: begin
               if (pwenter==1'b1) begin 
                  PW[11:8] <= pwdigit;
                  State<=FIFTH;
               end
               else State<=FOURTH;
            end
            FIFTH: begin
               if (pwenter==1'b1) begin 
                  PW[7:4] <= pwdigit;
                  State<=SIXTH;
               end
               else State<=FIFTH;
            end
            SIXTH: begin
               if (pwenter==1'b1) begin 
                  PW[3:0] <= pwdigit;
                  State<=ROM_FETCHWD;
               end
               else State<=SIXTH;
            end
            ROM_FETCHWD: begin
               addr_PW_ROM <= {3'b000, intID};
               State<=ROM_CYCLE1;
            end
            ROM_CYCLE1: begin
               State<=ROM_CYCLE2;
            end
            ROM_CYCLE2: begin
               State<=ROM_CATCH;
            end
            ROM_CATCH: begin
               data_PW_ROM <= q_PW_ROM;
               State<=COMPARE;
            end
            COMPARE: begin
               if(PW == data_PW_ROM) State <= PASSED; 
               else if(attempt > 2'b10) State <= WAIT_LOGOUT;
               else State <= FIRST;
            end
            PASSED: begin
              if (log_out_ctrl == 1'b1) begin
                  log_out <= 1;
                  State <= WAIT_LOGOUT;
              end
              else begin
                 log_in_ctrl<=1;
                 intID_ctrl<=intID;
                 isGuest_ctrl<=isGuest;
                 State <= PASSED;
              end
             end
             WAIT_LOGOUT: begin
                if (count == 2'b11) State <= 2'b11;
                else begin 
                    log_out<=0;
                    log_in_ctrl<=0;
                    count <= count + 1'b1;
                    State <= WAIT_LOGOUT;           
                end
             end
	     default: begin
               State <= INIT;
             end
         endcase
      end
   end
endmodule
