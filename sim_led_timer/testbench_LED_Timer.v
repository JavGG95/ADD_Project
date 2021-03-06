module testbench_LED_Timer( );

   reg clk, rst;
   reg En, Reconfigure;
   wire LED_timeout;
   wire [9:0] LED;

   always 
     begin
     clk= 1'b0;
     #10;
     clk= 1'b1;
     #10;
     end

LED_Timer DUT_LED_Timer(Reconfigure, En, LED, LED_timeout, clk, rst);

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