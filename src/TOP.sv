`timescale 1ns/1ps
module TOP (
  input logic CLK,        //Clock
  input logic RST,        //Reset
  output logic [7:0] DATA //Ouput for observing ALU result
);

//declarations of internal connections between modules
logic jmp;
logic fr_z;
logic fr_s;
logic rf_en;
logic dm_en;
logic acc_en;
logic fr_cy_out;
logic fr_cy_in;
logic [1:0] alu_mux_src;
logic [2:0] rf_addr;
logic [3:0] alu_op;
logic [4:0] jmp_addr;
logic [4:0] pc_wire;
logic [7:0] id_data;
logic [7:0] rf_data;
logic [7:0] dm_data;
logic [7:0] alu_data;
logic [7:0] alu_result;
logic [7:0] acc_data;
logic [9:0] dm_addr;
logic [15:0] pm_wire;

assign DATA = alu_result; //constantous asign of ALU result operations to output

//declarations of modules
//Program Counter
PC pc ( 
  .CLK(CLK),
  .RST(RST),
  .JMP(jmp),
  .JMP_ADDR(jmp_addr),
  .PC_OUT(pc_wire)
);
//Program Memory
PM pm (
  .PM_IN(pc_wire),
  .PM_OUT(pm_wire)
);
//Instruction Decoder
ID id (
  .ID_IN(pm_wire),
  .FR_Z(fr_z),
  .FR_S(fr_s),
  .JMP(jmp),
  .JMP_ADDR(jmp_addr),
  .RF_EN(rf_en),
  .RF_ADDR(rf_addr),
  .DM_EN(dm_en),
  .DM_ADDR(dm_addr),
  .ALU_MUX_SRC(alu_mux_src),
  .ID_OUT(id_data),
  .ALU_OP(alu_op),
  .ACC_EN(acc_en)
);
//Register File
RF rf (
  .CLK(CLK),
  .RST(RST),
  .RF_EN(rf_en),
  .RF_ADDR(rf_addr),
  .RF_IN(acc_data),
  .RF_OUT(rf_data)
);
//Data Memory
DM dm (
  .CLK(CLK),
  .RST(RST),
  .DM_EN(dm_en),
  .DM_ADDR(dm_addr),
  .DM_IN(acc_data),
  .DM_OUT(dm_data)
);
//ALU Operand Multiplexer
ALU_MUX alu_mux (
  .ID_DATA(id_data),
  .RF_DATA(rf_data),
  .DM_DATA(dm_data),
  .SRC(alu_mux_src),
  .ALU_DATA(alu_data)
);
//Arithmetic-Logical Unit
ALU alu (
  .IN_A(acc_data),
  .IN_R(alu_data),
  .IN_OP(alu_op),
  .CY_F(fr_cy_in),
  .OUT_A(alu_result),
  .OUT_CY(fr_cy_out)
);
//Flag Register
FR fr (
  .CLK(CLK),
  .RST(RST),
  .ALU_RESULT(alu_result),
  .ALU_CY(fr_cy_out),
  .CY(fr_cy_in),
  .Z(fr_z),
  .S(fr_s)
);
//Accumulator
Register acc (
  .CLK(CLK),
  .RST(RST),
  .EN(acc_en),
  .IN(alu_result),
  .OUT(acc_data)
);
  
endmodule