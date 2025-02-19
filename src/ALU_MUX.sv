`timescale 1ns/1ps

module ALU_MUX (
  input logic [7:0] ID_DATA,  //Data in from ID
  input logic [7:0] RF_DATA,  //Data in from RF
  input logic [7:0] DM_DATA,  //Data in from DM
  input logic [1:0] SRC,      //Data source selection
  output logic [7:0] ALU_DATA //Data out to ALU
);
  
typedef enum logic [1:0] { //Declaration of source selection
  RF = 2'b00, 
  ID = 2'b01, 
  DM = 2'b11
  } SRC_CODE;

always_comb begin
  case (SRC) //Assigments in case of source selection
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
      ALU_DATA = '0; //Declared default to prevent unpredicted values staged on output
    end
  endcase
end

endmodule