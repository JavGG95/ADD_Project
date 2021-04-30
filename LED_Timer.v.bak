module LED_Timer(Reconfigure, En, LED, LED_timeout, clk, rst);


input clk, rst, Reconfigure, En;
output [9:0] LED;
output LED_timeout;


wire  Ten_s_timeout, One_s_timeout;


   One_sec_Timer One_sec_Timer_1(En, One_s_timeout, clk, rst);
   Counting_to_10 Counting_to_10_1(One_s_timeout, Ten_s_timeout, clk, rst);
   Shift_right Shift_right_1(Reconfigure, Ten_s_timeout, LED, LED_timeout, clk, rst);
 

endmodule

