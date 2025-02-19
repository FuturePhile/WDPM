`timescale 1ns/1ps

module Register (
    input logic     CLK,        //Clock
    input logic     RST,        //Reset
    input logic     EN,         //Enable
    input logic     [7:0] IN,   //Data in
    output logic    [7:0] OUT   //Data out
);

always_ff @( posedge CLK or posedge RST ) begin : Register
    if (RST) begin
        OUT <= '0; //reset condition
    end else if (EN) begin
        OUT <= IN; //enable condition
    end
end
    
endmodule