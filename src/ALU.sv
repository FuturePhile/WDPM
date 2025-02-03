module ALU (
  input logic   [7:0] IN_A,
  input logic   [7:0] IN_R,
  input logic   [2:0] IN_OP,
  output logic  [7:0] OUT_A,
  output logic        OUT_CY
);

typedef enum logic [2:0] { 
  ADD = 3'b000, 
  SUB = 3'b001, 
  OR  = 3'b010, 
  AND = 3'b011, 
  XOR = 3'b100, 
  NOT = 3'b101, 
  LD  = 3'b110 
  } OP_CODE;

always_comb begin : ALU
  OUT_CY = 0;
  OUT_A = 8'b0;
  case (IN_OP)
    ADD : begin
      {OUT_CY, OUT_A} = IN_A + IN_R;
    end 
    SUB : begin
      {OUT_CY, OUT_A} = IN_A - IN_R;
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
    LD : begin
      OUT_A = IN_R;
    end
    default : begin
      OUT_CY = 0;
      OUT_A = 8'b0;
    end 
  endcase
end
  
endmodule