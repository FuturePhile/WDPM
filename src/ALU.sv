`timescale 1ns/1ps

module ALU (
  input logic   [7:0] IN_A,
  input logic   [7:0] IN_R,
  input logic   [3:0] IN_OP,
  input logic         CY_F,
  output logic  [7:0] OUT_A,
  output logic        OUT_CY
);

typedef enum logic [3:0] { 
  ADD = 4'b0000, 
  SUB = 4'b0001, 
  OR  = 4'b0010, 
  AND = 4'b0011, 
  XOR = 4'b0100, 
  NOT = 4'b0101, 
  LD  = 4'b0110
  } OP_CODE;

always_comb begin : ALU
  OUT_CY = 0;
  OUT_A = 8'b0;
  case (IN_OP)
    ADD : begin
      {OUT_CY, OUT_A} = IN_A + IN_R + CY_F;
    end 
    SUB : begin
      {OUT_CY, OUT_A} = IN_A - IN_R - CY_F;
    end
    OR : begin
      OUT_CY = 0;
      OUT_A = IN_A | IN_R;
    end
    AND : begin
      OUT_CY = 0;
      OUT_A = IN_A & IN_R;
    end
    XOR : begin
      OUT_CY = 0;
      OUT_A = IN_A ^ IN_R;
    end
    NOT : begin
      OUT_CY = 0;
      OUT_A = ~IN_A;
    end
    LD  : begin
      OUT_A = IN_R;
    end
    default : begin
      OUT_CY = 0;
      OUT_A = 8'b0;
    end 
  endcase
end
  
endmodule