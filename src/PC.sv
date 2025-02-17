`timescale 1ns/1ps

module PC (
    input logic CLK,
    input logic RST,
    output logic [4:0] PC_OUT
);
    
always_ff @( posedge CLK or posedge RST ) begin : PC
    if (RST) begin
        PC_OUT <= '0;
    end else begin
        PC_OUT <= PC_OUT + 1;
    end
end

endmodule