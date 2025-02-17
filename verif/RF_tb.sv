`timescale 1ns/1ps

module RF_tb;
    logic CLK;
    logic RST;
    logic RF_EN_t;
    logic [1:0] RF_ADDR_t;
    logic [7:0] RF_IN_t;
    logic [7:0] RF_OUT_t;

RF uut(
    .CLK(CLK),
    .RST(RST),
    .RF_EN(RF_EN_t),
    .RF_ADDR(RF_ADDR_t),
    .RF_IN(RF_IN_t),
    .RF_OUT(RF_OUT_t)
);

always #5 CLK = ~CLK;

initial begin
    $display("RF Testbench...");
    //Reset
    CLK = 0; RST = 1; RF_IN_t = '0; #10;
    RST = 0;

    RF_ADDR_t = 2'b00;
    RF_EN_t = 1;
    RF_IN_t = 8'hAA;
    #20;
    RF_IN_t = 8'h00;
    RF_EN_t = 0;
    #20;
    RF_ADDR_t = 2'b01;
    #20;
    RF_EN_t = 1;
    #20;
    RF_IN_t = 8'hFF;
    #20;
    RF_IN_t = 8'h00;
    RF_EN_t = 0;
    #20;
    RF_ADDR_t = 2'b00;
    #20;
    RF_EN_t = 1;
    #20;

    $finish;
end

initial begin
	$dumpfile("rf.vcd");
	$dumpvars();	
end

endmodule