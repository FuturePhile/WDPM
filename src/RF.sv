`timescale 1ns/1ps

module RF (
    input logic CLK,            //Clock
    input logic RST,            //Reset
    input logic RF_EN,          //Register enable
    input logic [1:0] RF_ADDR,  //Register address
    input logic [7:0] RF_IN,    //Data in
    output logic [7:0] RF_OUT   //Data out
);

logic [7:0] Registers [0:3]; //Registers declaration

always_ff @( posedge CLK or posedge RST ) begin : RF
    if (RST) begin
        for (int i = 0; i < 4 ; i++ ) begin //Reset condition in regiser file
            Registers[i] <= '0; 
        end
    end else if (RF_EN) begin
        Registers[RF_ADDR] <= RF_IN; //Enable specify register to make store operation
    end
end
    
assign RF_OUT = Registers[RF_ADDR]; //Assigned selected register

endmodule