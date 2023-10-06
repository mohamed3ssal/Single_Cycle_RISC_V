`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module pc #(parameter  n= 32)(
 input clk,
 input reset,
 input[n-1 : 0] in,
 output reg[n-1 : 0] out 
 
  );
  
always @(posedge clk  )
 begin           
    if(reset)                                  
        out <= 32'h00000000;
    else               
        out <= in;

end


endmodule