// ECE 6370
// Author: Avish Gandhi, 9989
// ID_Checking Module
//
// INPUTS
// clk: internal 50 MHz clock on FPGA Hardware
// rst: reset physical push-button on FPGA Hardware (inverse logic), 
// 	reset all values back to default
// pwdigit: 4-bit user-input from toggle switches to type in the password
// pwenter: a push-button coming from the button-shaper as a single cycle pulse
// 	    to enter the typed in password value
//          afterwords logged in: used to Start the game. 
// log_out: Passthrough from log_in_ctrl, GameController, PW and ID Modules all log out.
// q_UID_ROM: 16-bit (4-digit) User ID grabbed from UID ROM.
//
// OUTPUTS
// matchID: if ID is matching, high flag sent from ID to PW Module.
// isGuest: flag sent from ID Module to PW Module, indicating if using guest ID/PW.
// intID: 3-bit integer sent from ID Module to PW Module showing which User is playing.
// addr_UID_ROM: 5-bit address sent to UID ROM to fetch for ID
//
// REG
// attempt: counts number of attempts the user has attempted to type in a correct ID
// 
// HOW TO UNLOCK
// The user needs to type in a 4-bit Digit followed by the push-button, 4 times.
// If correct, will enable the Password module.

module ID_Checking(clk, rst, pwdigit, pwenter, log_out, 
                        matchID, isGuest, intID,
                        q_UID_ROM, addr_UID_ROM);

   input  clk, rst, pwenter, log_out;
   input [3:0] pwdigit;

   output matchID, isGuest;
   reg matchID, isGuest;

   output [2:0] intID;
   reg [2:0] intID;

   input [15:0] q_UID_ROM;
   reg [15:0] data_UID_ROM, UID;
   
   output [4:0] addr_UID_ROM;
   reg [4:0] addr_UID_ROM;

   parameter INIT = 0, FIRST = 1, SECOND = 2, THIRD = 3, FOURTH = 4, 
             ROM_FETCHWD = 5, ROM_CYCLE1 = 6, ROM_CYCLE2 = 7, ROM_CATCH = 8,
             COMPARE = 9, CHECKSTATUS = 10, CHECKGUEST = 11;
				 
   reg [3:0] State;
   reg [1:0] attempt;

always@(posedge clk) begin
   if (rst==1'b0)
      begin
         matchID <=1'b0;
         intID <= 2'b00;
         addr_UID_ROM<=5'b00000;
         data_UID_ROM<=16'b0000_0000_0000_0000;
         UID <= 16'b0000_0000_0000_0000;
         attempt <= 2'b00;         
         isGuest <= 1'b0;
      end
   else
      begin
         case (State)
            INIT: begin
                matchID<= 1'b0;
                intID<= 2'b0;
                addr_UID_ROM<=5'b00000;
                data_UID_ROM<=16'b0;
                UID <= 16'b0;
                attempt<= 0;
                isGuest <=0;
	        State <= FIRST;
            end
            FIRST: begin
               if (pwenter==1'b1) begin 
                  UID[15:12] <= pwdigit;
                  State<=SECOND;
               end
               else State<=FIRST;
            end
            SECOND: begin
               if (pwenter==1'b1) begin 
                  UID[11:8] <= pwdigit;
                  State<=THIRD;
               end
               else State<=SECOND;
            end
            THIRD: begin
               if (pwenter==1'b1) begin 
                  UID[7:4] <= pwdigit;
                  State<=FOURTH;
               end
               else State<=THIRD;
            end
            FOURTH: begin
               if (pwenter==1'b1) begin 
                  UID[3:0] <= pwdigit;
                  State<=ROM_FETCHWD;
               end
               else State<=FOURTH;
            end
            ROM_FETCHWD: begin
               addr_UID_ROM <= {3'b000, intID};
               State<=ROM_CYCLE1;
            end
            ROM_CYCLE1: begin
               State<=ROM_CYCLE2;
            end
            ROM_CYCLE2: begin
               State<=ROM_CATCH;
            end
            ROM_CATCH: begin
               data_UID_ROM <= q_UID_ROM;
               State<=COMPARE;
            end
            COMPARE: begin
               if(UID == data_UID_ROM) State <= CHECKGUEST;
               else State <= CHECKSTATUS;
            end
            CHECKSTATUS: begin
              if (attempt == 2'b10) State <= INIT;
              else if (data_UID_ROM == 16'b1111_1111_1111_1111) begin
                  intID <= 0;
                  attempt <= attempt + 1'b1;
                  addr_UID_ROM<={3'b000,2'b00};
                  State <= FIRST;
               end
               else begin
                   intID <= intID + 1'b1;            
                   State <= ROM_FETCHWD;
               end
            end
            CHECKGUEST: begin
               matchID<=1'b1;
               if (intID==1'b0) isGuest<=1'b1;
               else isGuest<=0;
               if (log_out == 1'b1) State <= INIT;
               else State <= CHECKGUEST;
            end
	    default: begin
               State <= INIT;
            end
         endcase
      end
   end
endmodule