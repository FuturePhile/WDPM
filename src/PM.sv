`timescale 1ns/1ps

module PM #(
    parameter DATA_WIDTH = 6
) 
(
    input logic [4:0] PM_IN,
    output logic [DATA_WIDTH-1:0] PM_OUT
);

logic [DATA_WIDTH-1:0] MEM [0:31]; 

initial begin
    MEM[0] = 6'b000000;
    MEM[1] = 6'b111000;
    MEM[2] = 6'b010110;
    MEM[3] = 6'b101010;
    MEM[4] = 6'b010101;
    MEM[5] = 6'b111111;

    for (int i = 6; i < 32 ; i++) begin
        MEM[i] = 6'b1010_00; //NOP
    end
end

assign PM_OUT = MEM[PM_IN];
    
endmodule