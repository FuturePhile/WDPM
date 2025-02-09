`timescale 1ns/1ps

module Register (
    input logic     CLK,
    input logic     RST, 
    input logic     EN,
    input logic     [7:0] IN,
    output logic    [7:0] OUT
);

always_ff @( posedge CLK or posedge RST ) begin : Register
    if (RST) begin
        OUT <= '0;
    end else if (EN) begin
        OUT <= IN;
    end
end
    
endmodule