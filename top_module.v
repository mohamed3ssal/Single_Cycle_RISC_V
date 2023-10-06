`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module top_module(
input clk, reset
);
wire [31:0] pc_plus4;
wire [31:0] pc_target;
wire pc_src;
wire [31:0] pc_next;
wire [31:0] pc;
wire [31:0]instr;
wire [31:0] srca;
wire [31:0] srcb;
wire [31:0] write_data;
wire reg_write;
wire [31:0] result;
wire  alu_src;
wire [31:0] imm_ext;
wire [2:0] alu_control;
wire [31:0] alu_result;
wire zero;
wire mem_write;
wire[31:0] read_data;
wire [1:0] result_src;
wire [1:0] imm_src;
/////////////////
mux_2to1 d1(
.in0(pc_plus4),
.in1(pc_target),
.sel(pc_src),
.out(pc_next)
);
//////////////////
pc d2(
.clk(clk),
.reset(reset),
.in(pc_next),
.out(pc)
);
///////////////////
instruction_memory d3(
.in(pc),
.out(instr)
);
////////////////////
register_file d4(
.clk(clk),
.in0(instr[19:15]),
.in1(instr[24:20]),
.in2(instr[11:7]),
.in3(result),
.in4(reg_write),
.out0(srca),
.out1(write_data)
);
////////////////////
mux_2to1 d5(
.in0(write_data),
.in1(imm_ext),
.sel(alu_src),
.out(srcb)
);
/////////////////////
ALU d6(
.in0(srca),
.in1(srcb),
.sel(alu_control),
.out(alu_result),
.out_zero(zero)
);
///////////////////////
data_memory d7(
.clk(clk),
.in0(mem_write),
.in1(alu_result),
.in2(write_data),
.out(read_data)
);
////////////////////
mux_3to1 d8(
.in0(alu_result),
.in1(read_data),
.in2(pc_plus4),
.sel(result_src),
.out(result)
);
///////////////////
adder d9(
.in0(pc),
.in1(imm_ext),
.out(pc_target)
);
//////////////////
adder d10(
.in0(pc),
.in1(32'd4),
.out(pc_plus4)
);
///////////////
sign_extend d11(
.in(instr[31:7]),
.op(imm_src),
.out(imm_ext)
);
///////////////////
control_unit d12(
.op(instr[6:0]),
.funct3(instr[14:12]),
.funct7_5(instr[30]),
.zero(zero),
.pc_src(pc_src),
.result_src(result_src),
.mem_write(mem_write),
.alu_control(alu_control),
.alu_src(alu_src),
.imm_src(imm_src),
.reg_write(reg_write)
);
//////////////////////////

endmodule
