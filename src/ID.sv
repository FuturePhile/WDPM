`timescale 1ns/1ps

module ID (
  input logic [15:0] ID_IN,
  input logic FR_Z, //reserved for future use
  input logic FR_S, //reserved for future use
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

typedef enum logic [3:0] { //Declaration of OP_CODE
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

typedef enum logic [3:0] { //Declaration of REG_CODE
  REG_R0 = 4'b0000,
  REG_R1 = 4'b0001,
  REG_R2 = 4'b0010,
  REG_R3 = 4'b0011,
  REG_ID = 4'b0100,
  REG_DM0 = 4'b1100, //PAGE0 Data Memory
  REG_DM1 = 4'b1101, //PAGE1 Data Memory
  REG_DM2 = 4'b1110, //PAGE2 Data Memory
  REG_DM3 = 4'b1111  //PAGE3 Data Memory
 } REG_CODE_T;

 typedef enum logic [1:0] { //Declaration of Source Selection of ALU_MUX from REG_CODE
  RF = 2'b00, //Register File
  ID = 2'b01, //Instruction Decoder
  NS = 2'b10, //not selected
  DM = 2'b11  //Data memory
  } AUX_SRC_T;

   typedef enum logic [1:0] { //Declaration of REG/DM_PAGE from REG_CODE **declared for future use**
  RP0 = 2'b00,
  RP1 = 2'b01,
  RP2 = 2'b10,
  RP3 = 2'b11
  } REG_PAGE_T;
//Declarations of internal variables
logic [3:0] op_code;
logic [3:0] reg_code;
logic [1:0] mux_code;
logic [1:0] reg_page;
logic [7:0] id_data;
logic [4:0] jmp_addr;
//Assignments of internal variables to external signals
assign op_code = ID_IN[15:12];
assign reg_code = ID_IN[11:8];
assign id_data =  ID_IN[7:0];
assign jmp_addr = ID_IN[7:3];
assign mux_code = reg_code[3:2];
assign reg_page = reg_code[1:0];
//Assignments of outputs to internal variables
assign RF_ADDR = reg_page;
assign DM_ADDR = {reg_page, id_data};
assign ALU_MUX_SRC = mux_code;

always_comb begin
  JMP       = 1'b0; //Declared default to prevent unpredicted values staged on output
  JMP_ADDR  = '0;
  RF_EN     = 1'b0;
  DM_EN     = 1'b0;
  ID_OUT    = id_data;
  ALU_OP    = OP_NOP;
  ACC_EN    = 1'b0;

  case (op_code)
    OP_ADD : begin //ADD operation
      ALU_OP = OP_ADD;
      ACC_EN = 1'b1;
    end
    OP_SUB : begin //SUB operation
      ALU_OP = OP_SUB;
      ACC_EN = 1'b1;
    end
    OP_OR : begin //OR operation
      ALU_OP = OP_OR;
      ACC_EN = 1'b1;
    end
    OP_AND : begin //AND operation
      ALU_OP = OP_AND;
      ACC_EN = 1'b1;
    end
    OP_XOR : begin //XOR operation
      ALU_OP = OP_XOR;
      ACC_EN = 1'b1;
    end
    OP_NOT : begin //NOT operation
      ALU_OP = OP_NOT;
      ACC_EN = 1'b1;
    end
    OP_ST : begin //ST operation
      if (mux_code == RF) begin
        RF_EN = 1'b1;
      end else if (mux_code == DM) begin
        DM_EN = 1'b1;
      end
    end
    OP_LD : begin //LD operation
      ALU_OP = OP_LD;
      ACC_EN = 1'b1;
    end 
    OP_NOP : begin //NOP operation
      ALU_OP = OP_NOP;
    end
    OP_JMP : begin //JMP operation
      JMP = 1'b1;
      JMP_ADDR = jmp_addr;
    end
    default: begin //Declared default to prevent avoid latches on output
      ALU_OP = OP_NOP;
    end
  endcase


end

endmodule