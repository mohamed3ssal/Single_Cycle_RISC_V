`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module control_unit(
input [6:0] op,
input [2:0] funct3,
input funct7_5,
input zero,
output  pc_src,
output  [1:0] result_src,
output  mem_write,
output  [2:0]alu_control,
output  alu_src,
output  [1:0]imm_src,
output  reg_write
);
wire jump, branch;
wire[1:0]alu_op ;
//instantiation
main_encoder d1(
.op(op),
.branch(branch),
.jump(jump),
.result_src(result_src),
.mem_write(mem_write),
.alu_src(alu_src),
.imm_src(imm_src),
.reg_write(reg_write),
.alu_op(alu_op)
);

alu_decoder d2(
.in0(funct3),
.in1(funct7_5),
.in2(alu_op),
.in3(op[5]),
.out(alu_control)
);
assign pc_src = (jump) | (zero & branch) ; 

endmodule

//////////////////////main encoder
module main_encoder(
input [6:0] op,
output reg branch,
output reg jump, 
output reg [1:0] result_src, 
output reg mem_write,
output reg alu_src,
output reg [1:0] imm_src,
output reg reg_write,
output reg [1:0] alu_op
);
always @(*)
 begin
  casex(op)
  7'b0000011: //lw
  begin
   branch=0;
   jump=0;
   result_src=2'b01;
   mem_write=0;
   alu_src=1;
   imm_src=2'b00;
   reg_write=1;
   alu_op=2'b00;
   
  end
  
    7'b0100011: //sw
  begin
   branch=0;
  jump=0;
  result_src=2'bxx;
  mem_write=1;
  alu_src=1;
  imm_src=2'b01;
  reg_write=0;
  alu_op=2'b00;
   
  end
  
    7'b0110011: //R_type
  begin
   branch=0;
  jump=0;
  result_src=2'b00;
  mem_write=0;
  alu_src=0;
  imm_src=2'bxx;
  reg_write=1;
  alu_op=2'b10;
   
  end
  
    7'b1100011: //beq
  begin
   branch=1;
  jump=0;
  result_src=2'bxx;
  mem_write=0;
  alu_src=0;
  imm_src=2'b10;
  reg_write=0;
  alu_op=2'b01;
   
  end
  
    7'b0010011: //I_type
  begin
   branch=0;
  jump=0;
  result_src=2'b00;
  mem_write=0;
  alu_src=1;
  imm_src=2'b00;
  reg_write=1;
  alu_op=2'b10;

   
  end
  
    7'b1101111: //jal
  begin
   branch=0;
  jump=1;
  result_src=2'b10;
  mem_write=0;
  alu_src=1'bx;
  imm_src=2'b11;
  reg_write=1;
  alu_op=2'bxx;
  end
  
  default :
   begin
   branch = 1'bx ;
   jump = 1'bx ;
   result_src = 2'bxx ;
   mem_write = 1'bx ;
   alu_src = 1'bx ;
   imm_src = 2'bxx ;
   reg_write = 1'bx ;
   alu_op = 2'bxx ;
   end
  
  
  
  endcase
 end
endmodule

////////////////////////////////ALU decoder
module alu_decoder(
input [2:0] in0, //funct3
input in1, //funct7
input [1:0] in2,//alu op
input in3, //op[5]
output reg [2:0] out //alu control
); 
always @(*)
 begin
  casex(in2)
   2'b00 : out = 2'b000 ; //adding for lw,sw 
   2'b01 : out = 2'b001 ; //subtructing for beq,bne
   2'b10 : //R,I-type instructions
 begin
  casex(in0)
   3'b000 :
       begin
        if({in3,in1} == 3'b11)
         begin
          out = 3'b001 ; // sub
         end
        else
       begin
        out = 3'b000 ; // add
       end
      end
   3'b010: out= 3'b101; //set less than   
   3'b110 : out = 3'b011 ;//or
   3'b111 : out = 3'b010 ;//and 
   default : out = 3'bxx ;
   endcase
   end
   default : out = 3'bxx ;
  endcase
 end
endmodule