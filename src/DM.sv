`timescale 1ns/1ps

module DM (
  input logic CLK,
  input logic RST,
  input logic DM_EN,
  input logic [9:0] DM_ADDR,
  input logic [7:0] DM_IN,
  output logic [7:0] DM_OUT
);

logic [7:0] MEM [0:1023];

always_ff @( posedge CLK ) begin : DM
  if (DM_EN) begin
    MEM[DM_ADDR] <= DM_IN;
  end
end

assign DM_OUT = MEM[DM_ADDR];

endmodule