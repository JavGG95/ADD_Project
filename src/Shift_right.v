module Shift_right(Reconfigure, Shift_right, LED, LED_timeout, clk, rst);

 

  input Shift_right, Reconfigure;
  input clk, rst;
  output [9:0] LED;
  output LED_timeout;

  reg [9:0] Register;
  reg Data_shift_right = 1'b0;
  reg LED_timeout;


 always @ (posedge clk) begin
   if (rst == 1'b0) 
    begin
       Register <= 10'b1111111111;
       LED_timeout <= 1'b0;
    end
   else 
    begin 
     if (Reconfigure== 1'b1)
       begin
       Register <= 10'b1111111111;
       LED_timeout <= 1'b0;
       end
     else 
       begin
        if (Shift_right== 1'b1) 
         begin
            if ( Register == 10'b0000000000)
             begin
               LED_timeout <= 1'b1;      
             end
            else
             begin
               Register[9] <= Data_shift_right; Register[8] <= Register[9]; Register[7] <= Register[8]; Register[6] <= Register[7]; Register[5] <= Register[6];
               Register[4] <= Register[5]; Register[3] <= Register[4]; Register[2] <= Register[3]; Register[1] <= Register[2]; Register[0] <= Register[1]; 
             end
          end
         else 
          begin
           LED_timeout <= 1'b0;
          end
       end
   end
 end

 assign LED = Register;

endmodule
