`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module register_file(
  input clk,        
  input [4:0] in0,   //a1          
  input [4:0] in1,   //a2          
  input [4:0] in2,   //a3          
  input [31:0] in3, //wd3           
  input in4,        //we3          
  output  [31:0] out0,  //rd1     
  output  [31:0] out1   //rd2     
);

reg [31:0] registers [31:0];  

always @(posedge clk )
 begin

    if (in4) 
        registers[in2] <= in3;
 end


assign  out0 = (in0 != 0) ? registers[in0] : 0;
assign  out1 = (in1 != 0) ? registers[in1] : 0;


//register data
initial
 begin
  registers[0]= 32'h00000000;
  registers[1]= 32'h00000001;
  registers[2]= 32'h00000002;
  registers[3]= 32'h00000003;
  registers[4]= 32'h00000004;
  registers[5]= 32'h00000006;
  registers[6]= 32'h00000013;
  registers[7]= 32'h00000007;
  registers[8]= 32'h000000010;
  registers[9]= 32'h00002004;
  registers[10]= 32'h00000111;
  registers[11]= 32'h00000011;
  registers[12]= 32'h00000012;
  registers[13]= 32'h00000013;
  registers[14]= 32'h00000014;
  registers[15]= 32'h00000015;
  registers[16]= 32'h00000016;
  registers[17]= 32'h00000017;
  registers[18]= 32'h00000018;
  registers[19]= 32'h00000019;
  registers[20]= 32'h00000020;
  registers[21]= 32'h00000021;
  registers[22]= 32'h00000022;
  registers[23]= 32'h00000023;
  registers[24]= 32'h00000024;
  registers[25]= 32'h00000025;
  registers[26]= 32'h00000026;
  registers[27]= 32'h00000027;
  registers[28]= 32'h00000028;
  registers[29]= 32'h00000029;
  registers[30]= 32'h00000030;
  registers[31]= 32'h00000031;
 end
endmodule