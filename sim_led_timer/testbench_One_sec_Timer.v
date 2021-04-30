module testbench_One_sec_Timer( );

   reg clk, rst;
   reg En;
   wire One_sec_timeout;

   always 
     begin
     clk= 1'b0;
     #10;
     clk= 1'b1;
     #10;
     end
 
One_sec_Timer DUT_One_sec_Timer(En, One_sec_timeout, clk, rst);

   initial
    begin
    #10 rst = 1'b1;
     @(posedge clk); @(posedge clk); @(posedge clk);
    #10 rst = 1'b0; 
     @(posedge clk); @(posedge clk); @(posedge clk);
    #10 rst = 1'b1;
     @(posedge clk); @(posedge clk); @(posedge clk);
    #10 En= 1'b0;
     @(posedge clk);  
    #10 En= 1'b1;
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     #10 rst = 1'b0; 
     @(posedge clk); @(posedge clk);
     #10 rst = 1'b1;
     @(posedge clk); @(posedge clk); 
    #10 En= 1'b0;
     @(posedge clk); 
    #10 En= 1'b1;
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     end
     endmodule
