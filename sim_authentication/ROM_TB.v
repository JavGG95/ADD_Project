// ECE 6370
// Author: Avish Gandhi, 9989
// ROM_TB Module
//
// This is the testbench for the ROM (Read-Only Memory)
// for the FPGA
//
// REG
// clk: clk is a 50MHz internal FPGA clock.
// addr: input of 5-bit address to fetch value from
//
// WIRE
// q_ROM: 4-bit word output value from ROM

`timescale 1ns/100ps
module ROM_TB();

   reg clk, rst;

   reg [4:0] addr;

   wire [15:0] q_UID_ROM;
   wire [23:0] q_PW_ROM;

   always 
      begin
         clk = 1'b0;
         #10;
         clk = 1'b1;
         #10;
      end

   UID_ROM MyUID_ROM(addr, clk, q_UID_ROM);
   PW_ROM  MyPW_ROM(addr, clk, q_PW_ROM);

   initial
      begin
        // No buttons being pressed right now
         rst = 1'b1; 
         addr = 5'b00000;    
	 @(posedge clk); 
         @(posedge clk);
	 @(posedge clk);
	 @(posedge clk);  
  
// reset button pressed and then unpressed
         rst = 1'b0;
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         rst = 1'b1;
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);

// Fetching digits from ROM according to address.
         //access first digit
         addr = 5'b00000;
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);

         //access second digit
         addr = 5'b00001;
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);

         //access third digit
         addr = 5'b00010;
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);

         //access fourth digit
         addr = 5'b00011;
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);

         //access fifth digit
         addr = 5'b00100;
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);

         //access sixth digit
         addr = 5'b00101;
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);

         //access seventh digit
         addr = 5'b00110;
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);

         //access eigth digit
         addr = 5'b00111;
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);

         //access ninth digit
         addr = 5'b01000;
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);
         @(posedge clk);

      end
endmodule
