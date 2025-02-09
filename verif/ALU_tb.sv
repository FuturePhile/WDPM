`timescale 1ns/1ps

module ALU_tb;
    logic [7:0] A_t;
    logic [7:0] R_t;
    logic [2:0] OP_t;
    logic [7:0] OUT_t;
    logic CY_t;

ALU uut (
    .IN_A(A_t),
    .IN_R(R_t),
    .IN_OP(OP_t),
    .OUT_A(OUT_t),
    .OUT_CY(CY_t)
);

initial begin
    $display("ALU Testbench...");

    //Reset
    A_t = 8'd0; R_t = 8'd0; OP_t = 3'd0; #5

    //ADD test
    A_t = 8'b11111111; R_t = 8'b00000001; OP_t = 3'b000; #10;
    $display("ADD: %d + %d = %d, CY = %b", A_t, R_t, OUT_t, CY_t);

    //SUB test
    A_t = 8'd0; R_t = 8'd1; OP_t = 3'b001; #10;
    $display("SUB: %d - %d = %d, CY = %b", A_t, R_t, OUT_t, CY_t);

    //OR test
    A_t = 8'b10101010; R_t = 8'b01010101; OP_t = 3'b010; #10;
    $display("OR: %b | %b = %b, CY = %b", A_t, R_t, OUT_t, CY_t);

    //AND test
    A_t = 8'b10101010; R_t = 8'b01010101; OP_t = 3'b011; #10;
    $display("AND: %b & %b = %b, CY = %b", A_t, R_t, OUT_t, CY_t);

    //XOR test
    A_t = 8'b10101010; R_t = 8'b01010101; OP_t = 3'b100; #10;
    $display("XOR: %b ^ %b = %b, CY = %b", A_t, R_t, OUT_t, CY_t);

    //NOT test
    A_t = 8'b00111100; R_t = 8'b01010101; OP_t = 3'b101; #10;
    $display("NOT: %b = ~%b, CY = %b", A_t, OUT_t, CY_t);

    //LD test
    A_t = 8'b11110000; R_t = 8'b00001111; OP_t = 3'b110; #10;
    $display("LD: %b = %b, CY = %b", R_t, OUT_t, CY_t);

    $finish;
end

initial begin
	$dumpfile("alu.vcd");
	$dumpvars();	
end
    
endmodule