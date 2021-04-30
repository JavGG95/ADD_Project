module testbench_Shift_right( );

  reg Reconfigure, Shift_right;
  reg clk, rst;
  wire LED_timeout;
  wire [9:0] LED;


 always 
     begin
     clk= 1'b0;
     #10;
     clk= 1'b1;
     #10;
     end
 
Shift_right DUT_Shift_right( Reconfigure, Shift_right, LED, LED_timeout, clk, rst);

    initial
    begin
    #10 rst = 1'b1;
     @(posedge clk); @(posedge clk); @(posedge clk);
    #10 rst = 1'b0; 
     @(posedge clk); @(posedge clk); @(posedge clk);
    #10 rst = 1'b1;
     @(posedge clk); @(posedge clk); @(posedge clk);
    #10 Shift_right= 1'b0;
     @(posedge clk);  
    #10 Shift_right= 1'b1;
     @(posedge clk);
    #10 Shift_right= 1'b0;
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
    #10 Shift_right= 1'b1;
     @(posedge clk);
    #10 Shift_right= 1'b0;
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
    #10 Shift_right= 1'b1;
     @(posedge clk);
    #10 Shift_right= 1'b0;
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
    #10 Shift_right= 1'b1;
     @(posedge clk);
    #10 Shift_right= 1'b0;
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
    #10 Shift_right= 1'b1;
     @(posedge clk);
    #10 Shift_right= 1'b0;
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
    #10 Shift_right= 1'b1;
     @(posedge clk);
    #10 Shift_right= 1'b0;
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     #10 Reconfigure= 1'b0;
     @(posedge clk); 
     #10 Reconfigure= 1'b1;
     @(posedge clk);
     #10 Reconfigure= 1'b0;
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     @(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk); @(posedge clk);@(posedge clk); @(posedge clk);
     #10 Shift_right= 1'b0;
     @(posedge clk);  
    #10 Shift_right= 1'b1;
     @(posedge clk);
    #10 Shift_right= 1'b0;
     end
endmodule