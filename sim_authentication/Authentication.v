// ECE 6370
// Author: Avish Gandhi, 9989
// Authentication Module (Top Level)

// INPUTS
// clk: internal 50 MHz clock on FPGA Hardware
// rst: reset physical push-button on FPGA Hardware (inverse logic), 
// 	reset all values back to default
// pwdigit: 4-bit user-input from toggle switches to type in the User ID/Password
// pwenter: a push-button coming from the button-shaper as a single cycle pulse
// 	    to enter the typed in ID/PW value
// log_out_ctrl: input from GameController sending pulse to PW Module when to log out.

// OUTPUTS
// log_in_ctrl: output sent to GameController showing when User is logged in.
// isGuest_ctrl: passthrough output sent to GameController showing if it is a guest ID/PW
// intID_ctrl: 3-bit integer passthrough output sent to GameController showing which User is playing.
//
// WIRE
// log_out: Passthrough from log_in_ctrl, GameController, PW and ID Modules all log out.
// matchID: if ID is matching, high flag sent from ID to PW Module.
// isGuest: flag sent from ID Module to PW Module, indicating if using guest ID/PW.
// intID: 3-bit integer sent from ID Module to PW Module showing which User is playing.
// addr_UID_ROM/addr_PW_ROM: 5-bit address sent to UID/PW ROM to fetch for ID/PW
// q_UID_ROM/q_PW_ROM: 16-bit/24-bit Integer grabbed from UID/PW ROM.
//
// HOW TO UNLOCK
// The user needs to type in 4-digit username followed by a 6-digit password to log into the system.
// a push-button must be pressed after each digit has been configured via toggle switches.
 
module Authentication(clk, rst, pwdigit, pwenter, log_out_ctrl, log_in_ctrl, isGuest_ctrl, intID_ctrl, matchID);

   input clk, rst, pwenter, log_out_ctrl;
   input [3:0] pwdigit; 

   output matchID;
   output log_in_ctrl, isGuest_ctrl;
   output [2:0] intID_ctrl;

   wire log_out, matchID, isGuest;
   wire [2:0] intID;

   wire [4:0] addr_UID_ROM, addr_PW_ROM;
   wire [15:0] q_UID_ROM;
   wire [23:0] q_PW_ROM;   

   UID_ROM  User_ROM(addr_UID_ROM, clk, q_UID_ROM);
   PW_ROM  Password_ROM(addr_PW_ROM, clk, q_PW_ROM);

   ID_Checking   UserEnter(clk, rst, pwdigit, pwenter, log_out, 
                           matchID, isGuest, intID,
                           q_UID_ROM, addr_UID_ROM);

   PW_Checking   PasswordEnter(clk, rst, pwdigit, pwenter, matchID, isGuest, intID, log_out_ctrl,
                               log_out, isGuest_ctrl, intID_ctrl, log_in_ctrl, 
                               q_PW_ROM, addr_PW_ROM);

endmodule