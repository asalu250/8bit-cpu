`timescale 1ns/1ps

module cpu_top_tb;
    reg clk, reset;
    wire [7:0] debug_reg_a;

    // Connects directly to module cpu_top(clk, reset, debug_reg_a)
    cpu_top dut (
        .clk(clk),
        .reset(reset),
        .debug_reg_a(debug_reg_a)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, cpu_top_tb);

        clk = 0;
        reset = 1;
        @(negedge clk);
        reset = 0;

        repeat (5) @(negedge clk);

        // Probes internal registers array (dut.u_regfile.registers)
        if (dut.u_regfile.registers[0] === 8'd8) begin
            $display("PASS: R0 = %0d (expected 8, from 5+3)", dut.u_regfile.registers[0]);
        end else begin
            $display("FAIL: R0 = %0d (expected 8)", dut.u_regfile.registers[0]);
        end

        $display("R1 = %0d (expected 3)", dut.u_regfile.registers[1]);
        $finish;
    end
endmodule
