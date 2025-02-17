`timescale 1ns/1ps

module PC_PM_tb;

logic CLK;
logic RST;
logic [5:0] PM_OUT_tb;

logic [4:0] PC_PM;

PC pc_uut(
    .CLK(CLK),
    .RST(RST),
    .PC_OUT(PC_PM)
);

PM pm_uut(
    .PM_IN(PC_PM),
    .PM_OUT(PM_OUT_tb)
);

always #5 CLK = ~CLK;

initial begin
    $display("PC_PM Testbench...");

    //Reset
    CLK = 0; RST = 1; #10;
    RST = 0;

    #1000;
    $finish;
end

initial begin
	$dumpfile("pc_pm.vcd");
	$dumpvars();	
end

endmodule