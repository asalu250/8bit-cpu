`timescale 1ns/1ps

module control_unit_tb;
    reg [7:0] instruction;
    wire [1:0] alu_opcode;
    wire [1:0] reg_read_addr_a, reg_read_addr_b, reg_write_addr;
    wire reg_write_enable, is_load, is_halt;

    // Connects directly to module control_unit
    control_unit dut (
        .instruction(instruction),
        .alu_opcode(alu_opcode),
        .reg_read_addr_a(reg_read_addr_a),
        .reg_read_addr_b(reg_read_addr_b),
        .reg_write_addr(reg_write_addr),
        .reg_write_enable(reg_write_enable),
        .is_load(is_load),
        .is_halt(is_halt)
    );

    initial begin
        // Test LOAD R0, #5 (8'b10100101)
        instruction = 8'b10100101; #10;
        if (is_load === 1'b1 && reg_write_enable === 1'b1)
            $display("PASS [Control Unit]: LOAD decode correct");

        // Test ADD R0, R1 (8'b00100001)
        instruction = 8'b00100001; #10;
        if (is_load === 1'b0 && alu_opcode === 2'b00 && reg_write_enable === 1'b1)
            $display("PASS [Control Unit]: ADD decode correct");

        // Test HALT (8'b00000000)
        instruction = 8'b00000000; #10;
        if (is_halt === 1'b1 && reg_write_enable === 1'b0)
            $display("PASS [Control Unit]: HALT decode correct");

        $finish;
    end
endmodule
