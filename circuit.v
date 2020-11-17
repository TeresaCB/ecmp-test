`timescale 1ns / 1ps
`include "iob_lib.vh"

module circuit
  (
   `INPUT(rst,1),
   `INPUT(clk,1),
   `INPUT(en,1),
   `INPUT(x,32),
   `OUTPUT(y,32)
   );

   `SIGNAL(cnt, 7) //7-bit counter as iterator
   `SIGNAL(y_int, 32) //internal y
   `SIGNAL(y_int_n_1, 32) //y(n-1)
   `SIGNAL2OUT(y, y_int)//connect internal y to output
   
   //y shift register 
   `REG_ARE(clk, rst, 1'b0, en&(cnt!=99), y_int_n_1, y_int)

   //iteration counter
   `COUNTER_ARE(clk, rst, cnt!=99, cnt)

   //compute next why
   `COMB begin 
  
   	if(x[31]==1'b1) begin
   		y_int = y_int_n_1 - x;
   	end
 	else begin
   		y_int = y_int_n_1 + x;
   	end
     
   end
   
   
endmodule
