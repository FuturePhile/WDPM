`timescale 1ns/1ps

module PC_tb;

logic CLK;
logic RST;
logic [4:0] PC_OUT_tb;

PC uut(
    .CLK(CLK),
    .RST(RST),
    .PC_OUT(PC_OUT_tb)
);

always #5 CLK = ~CLK;

initial begin
    $display("PC Testbench...");
    //Reset
    CLK = 0; RST = 1; #20;
    RST = 0;
    #1000;

    $finish;
end

initial begin
	$dumpfile("pc.vcd");
	$dumpvars();	
end

endmodule