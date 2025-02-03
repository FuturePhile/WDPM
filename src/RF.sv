`timescale 1ns/1ps

module RF (
    input logic CLK,
    input logic RST,
    input logic RF_EN,
    input logic [1:0] RF_ADDR,
    input logic [7:0] RF_IN,
    output logic [7:0] RF_OUT
);

logic [7:0] Registers [0:3];

always_ff @( posedge CLK or posedge RST ) begin : RF
    if (RST) begin
        for (int i = 0; i < 4 ; i++ ) begin
            Registers[i] <= '0;
        end
    end else if (RF_EN) begin
        Registers[RF_ADDR] <= RF_IN;
    end
end
    
assign RF_OUT = Registers[RF_ADDR];

endmodule