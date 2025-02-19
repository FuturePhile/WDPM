`timescale 1ns/1ps
//Program Counter
module PC (
    input logic CLK,            //Clock
    input logic RST,            //Reset
    input logic JMP,            //Jump enable
    input logic [4:0] JMP_ADDR, //5-bit input for jump operation
    output logic [4:0] PC_OUT   //5-bit output
);
    
always_ff @( posedge CLK or posedge RST ) begin : PC
    if (RST) begin
        PC_OUT <= '0;
    end else if (JMP) begin //conditional expression to make jump
        PC_OUT <= JMP_ADDR;
    end else begin
        PC_OUT <= PC_OUT + 1; //counter incrementation
    end
end

endmodule