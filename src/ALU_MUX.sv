`timescale 1ns/1ps

module ALU_MUX (
  input logic [7:0] ID_DATA,
  input logic [7:0] RF_DATA,
  input logic [7:0] DM_DATA,
  input logic [1:0] SRC,
  output logic [7:0] ALU_DATA
);
  
typedef enum logic [1:0] { 
  RF = 2'b00 
  ID = 2'b01 
  DM = 2'b11
  } SRC_CODE;

always_comb begin
  case (SRC)
    RF : begin
      ALU_DATA = RF_DATA;
    end 
    ID : begin
      ALU_DATA = ID_DATA;
    end
    DM : begin
      ALU_DATA = DM_DATA;
    end
    default: begin
      ALU_DATA = '0;
    end
  endcase
end

endmodule