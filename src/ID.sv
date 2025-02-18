`timescale 1ns/1ps

module ID (
  input logic CLK,
  input logic RST,
  input logic [15:0] ID_IN,
  input logic FR_Z,
  input logic FR_S,
  output logic JMP,
  output logic [4:0] JMP_ADDR,
  output logic RF_EN,
  output logic [1:0] RF_ADDR,
  output logic DM_EN,
  output logic [9:0] DM_ADDR,
  output logic [1:0] ALU_MUX_SRC,
  output logic [7:0] ID_OUT,
  output logic [3:0] ALU_OP,
  output logic ACC_EN
);

typedef enum logic [3:0] { 
   OP_ADD = 4'b0000,
   OP_SUB = 4'b0001,
   OP_OR  = 4'b0010,
   OP_AND = 4'b0011,
   OP_XOR = 4'b0100,
   OP_NOT = 4'b0101,
   OP_ST  = 4'b0110,
   OP_LD  = 4'b0111,
   OP_NOP = 4'b1010,
   OP_JMP = 4'b1111
 } OP_CODE_T;

typedef enum logic [3:0] { 
  REG_R0 = 4'b0000,
  REG_R1 = 4'b0001,
  REG_R2 = 4'b0010,
  REG_R3 = 4'b0011,
  REG_ID = 4'b0100,
  REG_DM0 = 4'b1100,
  REG_DM1 = 4'b1101,
  REG_DM2 = 4'b1110,
  REG_DM3 = 4'b1111 
 } REG_CODE_T;

 typedef enum logic [1:0] { 
  RF = 2'b00,
  ID = 2'b01,
  NS = 2'b10,
  DM = 2'b11
  } AUX_SRC_T;

logic [3:0] op_code;
logic [3:0] reg_code;
logic [7:0] id_data;
logic [4:0] jmp_addr;

assign op_code = ID_IN[15:12];
assign reg_code = ID_IN[11:8];
assign id_data =  ID_IN[7:0];
assign jmp_addr = ID_IN[7:3];

always_comb begin
  JMP       = 1'b0;
  JMP_ADDR  = '0;
  RF_EN     = 1'b0;
  RF_ADDR   = REG_R0;
  DM_EN     = 1'b0;
  DM_ADDR   = REG_DM0;
  ALU_MUX_SRC = NS;
  ID_OUT    = id_data;
  ALU_OP    = OP_NOP;
  ACC_EN    = 1'b0;

  case (op_code)
    OP_ADD : begin
      
    end
    OP_SUB : begin
      
    end
    OP_OR : begin
      
    end
    OP_AND : begin
      
    end
    OP_XOR : begin
      
    end
    OP_NOT : begin
      
    end
    OP_ST : begin
      
    end
    OP_LD : begin
      
    end 
    OP_NOP : begin
      
    end
    OP_JMP : begin
      
    end
    default: begin
      
    end
  endcase

end

endmodule