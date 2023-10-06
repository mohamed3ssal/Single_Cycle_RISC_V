`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module instruction_memory (
 input [31:0] in, //a
 output reg [31:0]out  //rd
);
 reg[31:0] data[0:(2**32)-1];
 //this programmin does : lw > sw > or > eq
   always @(*)
    begin
     case(in)
   32'h0:  out= 32'hFFC4A303;
   32'h4:  out= 32'h0064A423;
   32'h8:  out= 32'h0062E233;
   32'hc:  out= 32'hFE420AE3;
   32'h16:  out= 32'h00100193;

     endcase

    end


	//assign out = data[ in[31:0] ];
endmodule