module One_sec_Timer(En, One_sec_timeout, clk, rst);


input clk, rst, En;
output One_sec_timeout;

wire One_milisec_cnt, Hundred_ms_T_O;



    One_ms_Timer One_ms_Timer_1(En, One_milisec_cnt, clk, rst);
    Counting_to_100 Counting_to_100_1(One_milisec_cnt, Hundred_ms_T_O, clk, rst);
    Counting_to_10 Counting_to_10_1(Hundred_ms_T_O, One_sec_timeout, clk, rst);
    
endmodule

