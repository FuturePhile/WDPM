`timescale 1ns/1ps

module PM #(
    parameter DATA_WIDTH = 16
) 
(
    input logic [4:0] PM_IN,                //Addres input from PC
    output logic [DATA_WIDTH-1:0] PM_OUT    //Program data output to ID
);

logic [DATA_WIDTH-1:0] MEM [0:31]; //Declare memory array

initial begin
    MEM[0] = 16'b0111_0100_00001000; //LD ID, 8     | Load 8 from PM to ACC
    MEM[1] = 16'b0110_0000_00000000; //ST R0        | Store 8 from ACC to R0
    MEM[2] = 16'b0111_0100_00001100; //LD ID, 12    | Load 12 from PM to ACC
    MEM[3] = 16'b0000_0000_00000000; //ADD R0       | Add 12 from ACC to 8 from R0
    MEM[4] = 16'b0110_1101_00000000; //ST DM1, 0    | Store result form ACC to DM[0100000000]
    MEM[5] = 16'b0111_1101_00000000; //LD DM1, 0    | Load from DM[0100000000] to ACC
    MEM[6] = 16'b0000_1101_00000000; //ADD DM1, 0   | Add DM[0100000000] to DM[0100000000]
    MEM[7] = 16'b1111_0000_00100_000; //JMP 4       | Jump to MEM[4]

    for (int i = 8; i < 32 ; i++) begin
        MEM[i] = 16'b1010_0000_00000000; //NOP
    end
end

assign PM_OUT = MEM[PM_IN]; //Assigned memory position with incremented address
    
endmodule

/*

Instructions:
    Regular:
        4-bit OP_CODE | 4-bit reg_code | 8-bit value
    JMP case:
        4-bit OP_CODE | 4-bit reg_code | 5-bit PC addres | 3-bit reserved


In Regular expression 8-bit value can be used only in 2 cases:
    1. Providing data form instruction decoder to alu_mux
        ex. LD ID 10    | Load from ID value 10
    2. Addressing memory cell in Data Memory
        ex. ST DM1 52   | Store from ACC do DM Page 1 addres 52

OP_code:
    0000 - ADD
    0001 - SUB
    0010 - OR
    0011 - AND
    0100 - XOR
    0101 - NOT
    0110 - ST
    0111 - LD
    1000 - reserved
    1001 - reserved
    1010 - NOP
    1011 - reserved
    1100 - reserved
    1101 - reserved
    1110 - reserved
    1111 - JMP

reg_code:
    0000 - R0
    0001 - R1
    0010 - R2
    0011 - R3
    0100 - ID - all operations except ST
    0101 - reserved
    0110 - reserved
    0111 - reserved
    1000 - reserved
    1001 - reserved
    1010 - reserved
    1011 - reserved
    1100 - DM0
    1101 - DM1
    1110 - DM2
    1111 - DM3
*/