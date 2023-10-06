`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module sign_extend #(parameter n=32)(
input  [n-1:7] in,
input  [1:0] op,
output reg [n-1:0] out
);
always@(*)
begin
 case(op)
  2'b00 : out = { {20{in[31]}} , in[31:20] } ; //I-type instruction
  2'b01 : out = { {20{in[31]}} , in[31:25] , in[11:7] } ; //S-type instruction
  2'b10 : out = { {20{in[31]}} , in[7] , in[31:25] , in[11:8] , 1'b0} ; //B-type instruction
  2'b11 : out = { {12{in[31]}} , in[19:12] , in[20] , in[30:21] , 1'b0} ; //J-type instruction
 default : out = 32'h00000000 ;
 endcase
end
endmodule
