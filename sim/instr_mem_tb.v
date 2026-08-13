`timescale 1ns/1ps

module instr_mem_tb;
    reg [3:0] addr;
    wire [7:0] instruction;

    // Connects directly to module instr_mem(addr, instruction)
    instr_mem dut (
        .addr(addr),
        .instruction(instruction)
    );

    initial begin
        addr = 4'd0; #10;
        $display("PC=0: Instruction = 8'b%b (LOAD R0, #5)", instruction);
        
        addr = 4'd1; #10;
        $display("PC=1: Instruction = 8'b%b (LOAD R1, #3)", instruction);

        addr = 4'd2; #10;
        $display("PC=2: Instruction = 8'b%b (ADD R0, R1)", instruction);

        $finish;
    end
endmodule
