`timescale 1ns/1ps

module FR (
  input logic CLK,
  input logic RST,
  input logic [7:0] ALU_RESULT,
  input logic ALU_CY,
  output logic CY,
  output logic Z,
  output logic S
);

always_ff @( posedge CLK or posedge RST ) begin : FR
  if(RST)begin
    CY <= 1'b0;
    Z <= 1'b0;
    S <= 1'b0;
  end else begin
    CY <= ALU_CY;
    Z <= (ALU_RESULT == 8'd0);
    S <= ALU_RESULT[7];
  end
end
  
endmodule