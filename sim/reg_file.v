`timescale 1ns/1ps

module regfile_tb;
    reg clk;
    reg write_enable;
    reg [1:0] read_addr_a, read_addr_b, write_addr;
    reg [7:0] write_data;
    wire [7:0] read_data_a, read_data_b;

    // Connects directly to module regfile
    regfile dut (
        .clk(clk),
        .write_enable(write_enable),
        .read_addr_a(read_addr_a),
        .read_addr_b(read_addr_b),
        .write_addr(write_addr),
        .write_data(write_data),
        .read_data_a(read_data_a),
        .read_data_b(read_data_b)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; write_enable = 0;

        // Write 5 to R0
        write_addr = 2'b00; write_data = 8'd5; write_enable = 1; #10;
        
        // Write 3 to R1
        write_addr = 2'b01; write_data = 8'd3; write_enable = 1; #10;
        
        write_enable = 0;
        read_addr_a = 2'b00;
        read_addr_b = 2'b01; #10;

        if (read_data_a === 8'd5 && read_data_b === 8'd3)
            $display("PASS: Regfile dual-read verified (R0=%0d, R1=%0d)", read_data_a, read_data_b);
        else
            $display("FAIL: Regfile read mismatch");

        $finish;
    end
endmodule
