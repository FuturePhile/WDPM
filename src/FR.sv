`timescale 1ns/1ps

module FR (
  input logic CLK,              //Clock
  input logic RST,              //Reset
  input logic [7:0] ALU_RESULT, //ALU_result to detect flag
  input logic ALU_CY,           //Carry flag from ALU
  output logic CY,              //Carry Flag
  output logic Z,               //Zero flag
  output logic S                //Sign flag
);

always_ff @( posedge CLK or posedge RST ) begin : FR
  if(RST)begin //Reset condidion
    CY <= 1'b0; 
    Z <= 1'b0;
    S <= 1'b0;
  end else begin
    CY <= ALU_CY;               //Store CY flag
    Z <= (ALU_RESULT == 8'd0);  //Detecting Z flag
    S <= ALU_RESULT[7];         //Detecting S flag
  end
end
  
endmodule