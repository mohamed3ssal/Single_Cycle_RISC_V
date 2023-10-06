`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module ALU #(parameter n=32)(
input [n-1:0] in0, in1,
input [2:0] sel,
output reg [n-1:0] out,
output  out_zero 
);


always @(*)

 begin
  
  casex(sel)
   3'b000: out = in0 + in1 ;
   3'b001: out = in0 - in1 ;
   3'b010: out = in0 & in1 ;
   3'b011: out = in0 | in1 ;


   default: out = 32'bx;
  
    
  endcase
 end
 assign out_zero= (out == 32'h0)? 1 : 0 ;
endmodule
