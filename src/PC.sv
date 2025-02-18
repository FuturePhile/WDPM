`timescale 1ns/1ps

module PC (
    input logic CLK,
    input logic RST,
    input logic JMP,
    input logic [4:0] JMP_ADDR,
    output logic [4:0] PC_OUT
);
    
always_ff @( posedge CLK or posedge RST ) begin : PC
    if (RST) begin
        PC_OUT <= '0;
    end else if (JMP) begin
        PC_OUT <= JMP_ADDR;
    end else begin
        PC_OUT <= PC_OUT + 1;
    end
end

endmodule