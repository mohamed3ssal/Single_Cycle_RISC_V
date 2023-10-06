`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module data_memory #(parameter n=32)(
input clk, in0 /*we*/,
input [n-1:0] in1, in2, //a,wd
output reg [n-1:0]  out  //rd
);


reg [n-1:0] data [0:(2**n)-1];

//read
//assign out = (in0 == 1'b0)? data[in1[31:0]] : 32'h00000000;


//write
always @(posedge clk)
 begin
  if(in0)
   data[in1[31:2]] <= in2;

 end
 


  

//this is a special case for our primary program
 always @(*)
    begin
     case(in1)
   32'h2000:  out= 32'h10;
   endcase
   end
endmodule
