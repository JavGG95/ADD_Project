module Counting_to_100 (Cnt_to_100, Hundred_Timeout, clk, rst);

   input Cnt_to_100, rst, clk;
   reg [6:0] Count;

   output Hundred_Timeout;
   reg Hundred_Timeout;

   always @ (posedge clk) begin
      if (rst == 1'b0) begin
         Count <= 7'b0000000;
         Hundred_Timeout <= 1'b0;
      end
      else 
        begin
          if (Cnt_to_100 == 1'b1)
            begin
          //    if (Count == 7'b0000010) //this is for testing purposes
              if (Count == 7'b1100011) 
                begin
                 Hundred_Timeout <= 1'b1;
                 Count <= 7'b0000000;
                end
              else
               begin
             Count <= Count+ 7'b0000001;
               end
             end
           else
            begin
             Hundred_Timeout<= 1'b0;
            end
       end
   end
endmodule

   