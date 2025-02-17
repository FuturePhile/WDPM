`timescale 1ns/1ps

module PM #(
    parameter DATA_WIDTH = 16
) 
(
    input logic [4:0] PM_IN,
    output logic [DATA_WIDTH-1:0] PM_OUT
);

logic [DATA_WIDTH-1:0] MEM [0:31]; 

initial begin
    MEM[0] = 16'b0000_00_0000000000;
    MEM[1] = 16'b0000_0000000000_00;
    MEM[2] = 16'b0000_00000_0000000;
    MEM[3] = 16'b101010;
    MEM[4] = 16'b010101;
    MEM[5] = 16'b111111;

    for (int i = 6; i < 32 ; i++) begin
        MEM[i] = 16'b1010_00; //NOP
    end
end

assign PM_OUT = MEM[PM_IN];
    
endmodule

/*

Instructions:
    Regular:
        4-bit OP_CODE | 4-bit reg_code | 8-bit value
    JMP case:
        4-bit OP_CODE | 4-bit reg_code | 5-bit PC addres | 3-bit reserved


OP_code:
    0000 - ADD
    0001 - SUB
    0010 - OR
    0011 - AND
    0100 - XOR
    0101 - NOT
    0110 - ST
    0111 - LD
    1000 -
    1001 -
    1010 - NOP
    1011 - 
    1100 - 
    1101 - 
    1110 - 
    1111 - JMP

reg_code:
    0000 - R0
    0001 - R1
    0010 - R2
    0011 - R3
    0100 - ID
    0101 -
    0110 -
    0111 -
    1000 - 
    1001 -
    1010 -
    1011 -
    1100 - DM0
    1101 - DM1
    1110 - DM2
    1111 - DM3
*/