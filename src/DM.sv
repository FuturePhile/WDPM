`timescale 1ns/1ps

module DM (
  input logic CLK,            //Clock
  input logic RST,            //Reset
  input logic DM_EN,          //Enable to store
  input logic [9:0] DM_ADDR,  //10-bit data memeory address 
  input logic [7:0] DM_IN,    //Data in
  output logic [7:0] DM_OUT   //Data out
);

logic [7:0] MEM [0:1023]; //Memory declaration

always_ff @( posedge CLK ) begin : DM
  if (DM_EN) begin
    MEM[DM_ADDR] <= DM_IN; //Enable specify data memory cell address to make store operation
  end
end

assign DM_OUT = MEM[DM_ADDR]; //Assigned selected data memory cell

endmodule