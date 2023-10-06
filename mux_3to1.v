`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module mux_3to1 #(parameter n=32)(
input [n-1:0] in0, in1, in2,
input [1:0] sel,
output reg [n-1:0] out
);
always @(*)
 begin
  casex(sel)
   2'b00: out=in0;
   2'b01: out=in1;
   2'b10: out=in2;
   2'b11: out=32'bx;
   default: out= 32'bx;
  endcase
 end
endmodule

