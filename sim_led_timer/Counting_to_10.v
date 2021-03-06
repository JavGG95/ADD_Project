module Counting_to_10 (Cnt_to_10, Ten_Timeout, clk, rst);

   input Cnt_to_10, rst, clk;
   reg [3:0] Count;

   output Ten_Timeout;
   reg Ten_Timeout;


   always @ (posedge clk) begin
      if (rst == 1'b0) begin
         Count <= 4'b0000;
         Ten_Timeout <= 1'b0;
      end
      else 
        begin
          if (Cnt_to_10 == 1'b1)
            begin
          //  if (Count == 4'b0001) //this is for testing purposes
              if (Count == 4'b1001) 
               begin
               Ten_Timeout <= 1'b1;
               Count <= 4'b0000;
               end
              else
               begin
                Count <= Count + 4'b0001;
               end
             end
          else
            begin
             Ten_Timeout<= 1'b0;
            end
        end
   end
endmodule

   