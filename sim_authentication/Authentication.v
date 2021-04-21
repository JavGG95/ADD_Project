// ECE 6370
// Author: Avish Gandhi, 9989
// Authentication Module (Top Level)

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
//
// REG
// State: The current state of the finite state machine.
// Sofarsogood: a flag that keeps checking to see if the user has typed in any
//		incorrect password values.
//
// HOW TO UNLOCK
// The user needs to type in password values to log into the system so they can play the game.
// After the system has been unlocked, the user will be logged in:
// the logged_in flag will be on and logged_out flag will be off
// player 1 and RNG inputs will transfer through to other modules allowing to play the game.
//
// Note: Currently, the password is set to 9989 in order to test my system.
// Status: SUCCESSFUL for both Wrong Passwords and Correct Passwords.
 
module Authentication(clk, rst, pwdigit, pwenter, log_out_ctrl, log_in_ctrl, isGuest_ctrl, intID_ctrl);

   input clk, rst, pwenter, log_out_ctrl;
   input [3:0] pwdigit; 

   output log_in_ctrl, isGuest_ctrl;
   output [2:0] intID_ctrl;

   wire log_out, matchID, isGuest;
   wire [2:0] intID;

   wire [4:0] addr_UID_ROM, addr_PW_ROM;
   wire [15:0] q_UID_ROM, q_PW_ROM;   

   ROM_UID  User_ROM(addr_UID_ROM, clk, q_UID_ROM);
   ROM_PWD  Password_ROM(addr_PW_ROM, clk, q_PW_ROM);

   ID_Checking   UserEnter(clk, rst, pwdigit, pwenter, log_out, 
                           matchID, isGuest, intID,
                           addr_ROM, q_ROM);

   PW_Checking   PasswordEnter(clk, rst, pwdigit, pwenter, matchID, isGuest, intID, log_out_ctrl,
                               log_out, isGuest_ctrl, intID_ctrl, log_in_ctrl, 
                               addr_ROM, q_ROM);

endmodule