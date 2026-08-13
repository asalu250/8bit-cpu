`timescale 1ns/1ps

module alu_tb;
    reg [7:0] a, b;
    reg [1:0] opcode;
    wire [7:0] result;
    wire zero, carry_out;

    // Connects directly to module alu(a, b, opcode, result, zero, carry_out)
    alu dut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .zero(zero),
        .carry_out(carry_out)
    );

    initial begin
        // ADD Test (opcode = 2'b00)
        a = 8'd10; b = 8'd20; opcode = 2'b00; #10;
        if (result === 8'd30) $display("PASS [ADD]: a=%0d b=%0d -> result=%0d", a, b, result);
        else $display("FAIL [ADD]");

        // SUB Test (opcode = 2'b01)
        a = 8'd30; b = 8'd10; opcode = 2'b01; #10;
        if (result === 8'd20) $display("PASS [SUB]: a=%0d b=%0d -> result=%0d", a, b, result);
        else $display("FAIL [SUB]");

        // AND Test (opcode = 2'b10)
        a = 8'hAA; b = 8'hCC; opcode = 2'b10; #10;
        if (result === 8'h88) $display("PASS [AND]: a=%0h b=%0h -> result=%0h", a, b, result);
        else $display("FAIL [AND]");

        // OR Test (opcode = 2'b11)
        a = 8'hAA; b = 8'hCC; opcode = 2'b11; #10;
        if (result === 8'hEE) $display("PASS [OR]: a=%0h b=%0h -> result=%0h", a, b, result);
        else $display("FAIL [OR]");

        // Zero Flag Test
        a = 8'd15; b = 8'd15; opcode = 2'b01; #10;
        if (zero === 1'b1) $display("PASS [ZERO FLAG]: zero correctly high on result=0");

        // Carry Out Test
        a = 8'hFF; b = 8'h01; opcode = 2'b00; #10;
        if (carry_out === 1'b1) $display("PASS [CARRY OUT]: carry_out correctly high on overflow");

        $finish;
    end
endmodule
