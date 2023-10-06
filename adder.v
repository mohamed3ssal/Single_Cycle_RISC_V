`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module adder #(parameter n=32)(
input [n-1:0] in0, in1,

output  [n-1:0] out
);
assign out = in0 + in1 ;
endmodule
