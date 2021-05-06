module One_ms_Timer(Enable, One_ms_timeout, clk, rst);

input Enable, clk, rst;
output One_ms_timeout;
reg One_ms_timeout;
reg [15:0] Interal_cnt;

 always @ (posedge clk) begin
 
   if (rst == 1'b0) begin
    One_ms_timeout <= 1'b0;
    Interal_cnt<= 16'b0000000000000000;
    end
   else begin

     if (Enable == 1'b1)
      begin
         // if (Interal_cnt== 16'b0000_0000_0000_0011) //this is for testing purposes
            if (Interal_cnt== 16'b1100_0011_0100_1111)
                   begin
            One_ms_timeout <= 1'b1; 
            Interal_cnt<= 16'b0000000000000000;
            end
          else
            begin
           Interal_cnt <= Interal_cnt + 16'b0000000000000001;
           One_ms_timeout <= 1'b0; 
            end
      end
       else
          begin
           One_ms_timeout <= 1'b0; 
          end
    end
  end

endmodule  

