// ECE 6370
// Author: Avish Gandhi, 9989
// PW_Checking Module
//
// INPUTS
// clk: internal 50 MHz clock on FPGA Hardware
// rst: reset physical push-button on FPGA Hardware (inverse logic), 
// 	reset all values back to default
// pwdigit: 4-bit user-input from toggle switches to type in the password
// pwenter: a push-button coming from the button-shaper as a single cycle pulse
// 	    to enter the typed in password value
//          afterwords logged in: used to Start the game. 
// matchID: if ID is matching, high flag sent from ID to PW Module.
// isGuest: flag sent from ID Module to PW Module, indicating if using guest ID/PW.
// intID: 3-bit integer sent from ID Module to PW Module showing which User is playing.
// log_out_ctrl: 
// q_PW_ROM: 24-bit (6-digit) Password value grabbed from PW ROM.
//
// OUTPUTS
// log_out: Passthrough from log_in_ctrl, GameController, PW and ID Modules all log out.
// log_in_ctrl: output sent to GameController showing when User is logged in.
// isGuest_ctrl: passthrough output sent to GameController showing if it is a guest ID/PW
// intID_ctrl: 3-bit integer passthrough output sent to GameController showing which User is playing.
// addr_PW_ROM: 5-bit address sent to PW ROM to fetch for PW
//
// REG
// attempt: 2-bit counter, number of attempts the user has attempted to type in a correct ID
// count: 2-bit counter, used exclusively after being sent a flag to log out.
//        waits 4 cycles before going back to INIT state.
// 
// HOW TO UNLOCK
// The user needs to type in a 4-bit Digit followed by the push-button, 6 times.
// If correct, will enable the log_in_ctrl signal high to enable the GameController.

module PW_Checking(clk, rst, pwdigit, pwenter, matchID, isGuest, intID, log_out_ctrl,
                   log_out, isGuest_ctrl, intID_ctrl, log_in_ctrl, 
                   q_PW_ROM, addr_PW_ROM, status);
   
   input  clk, rst, pwenter, matchID, isGuest, log_out_ctrl;
   input [2:0] intID;
   input [3:0] pwdigit;

   output log_out, isGuest_ctrl, log_in_ctrl;
   reg log_out, isGuest_ctrl, log_in_ctrl;

   output [2:0] intID_ctrl;
   reg [2:0] intID_ctrl;

   input [23:0] q_PW_ROM;
   reg [23:0] data_PW_ROM, PW;

   output [4:0] addr_PW_ROM;
   reg [4:0] addr_PW_ROM;
	
	output [9:0] status;
	reg [9:0] status;

   parameter INIT = 0, FIRST = 1, SECOND = 2, THIRD = 3, FOURTH = 4, FIFTH = 5, SIXTH = 6,
             ROM_FETCHWD = 7, ROM_CYCLE1 = 8, ROM_CYCLE2 = 9, ROM_CATCH = 10,
             COMPARE = 11, PASSED = 12, WAIT_LOGOUT = 13;			 

   reg [3:0] State;
   reg [1:0] attempt, count;

always@(posedge clk) begin
   if (rst==1'b0) begin
         State <= INIT;
   end
   else
      begin
         case (State)
            INIT: begin
               if(matchID == 1'b1) begin
						State <= FIRST;
						status <= 10'b1000000000;
					end
               else begin
                  addr_PW_ROM<=5'b00000;
                  data_PW_ROM<=24'b0000_0000_0000_0000_0000_0000;
                  PW<= 24'b0000_0000_0000_0000_0000_0000;
                  attempt<= 1'b0;
                  count<=2'b00;
                  log_out<=1'b0;
                  log_in_ctrl<=1'b0;
                  isGuest_ctrl<=1'b0;
                  intID_ctrl<= 2'b00;
						status <= 10'b0000000000;
               end
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
               addr_PW_ROM <= {2'b00, intID};
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
               else if(attempt == 2'b10) State <= WAIT_LOGOUT;
               else begin
                  attempt <= attempt + 1'b1;
                  State <= FIRST;
               end
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
					  status <= 10'b1100000000;
                 State <= PASSED;
              end
             end
             WAIT_LOGOUT: begin
                if (count == 2'b11) State <= INIT;
                else begin 
                    log_out<=1;
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

