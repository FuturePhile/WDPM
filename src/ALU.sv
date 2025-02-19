`timescale 1ns/1ps

module ALU (
  input logic   [7:0] IN_A,   //Input from ACC
  input logic   [7:0] IN_R,   //Input from ALU_MUX
  input logic   [3:0] IN_OP,  //OP_CODE input
  input logic         CY_F,   //Input CY flag
  output logic  [7:0] OUT_A,  //Output from ALU
  output logic        OUT_CY  //Output CY flag
);

typedef enum logic [3:0] { //Declaration of OP_CODE
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
    ADD : begin //ADD operation
      {OUT_CY, OUT_A} = IN_A + IN_R + CY_F;
    end 
    SUB : begin //SUB operation
      {OUT_CY, OUT_A} = IN_A - IN_R - CY_F;
    end
    OR : begin  //OR operation
      OUT_CY = 0;
      OUT_A = IN_A | IN_R;
    end
    AND : begin //AND operation
      OUT_CY = 0;
      OUT_A = IN_A & IN_R;
    end
    XOR : begin //XOR operation
      OUT_CY = 0;
      OUT_A = IN_A ^ IN_R;
    end
    NOT : begin //NOT operation
      OUT_CY = 0;
      OUT_A = ~IN_A;
    end
    LD  : begin //LD operation
      OUT_A = IN_R;
    end
    default : begin //Declared default to prevent unpredicted values staged on output
      OUT_CY = 0;
      OUT_A = 8'b0;
    end 
  endcase
end
  
endmodule