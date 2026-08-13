module instr_mem( input wire [3:0] addr, output wire [7:0] instruction);//4 bit address input, 16 possible values, 8bit instruction output
	
	reg [7:0] rom [0:15];//same reg storage, rom is read only memory, similar to reg file except no change
	
	initial begin// inital blocks run exactly once, when fpga loads up, starting fixed values
		rom[0] = 8'b101_00_101;//first rom slot set to specfic 8bit instruction pattern, LOAD R0, #5
		rom[1] = 8'b101_01_011;//underscores separate into opcode/reg/immediate, LOAD R1, #3
		rom[2] = 8'b001_00_001; // ADD R0, R1
		rom[3] = 8'b000_00_000; // HALT/NOP
		rom[4] = 8'b000_00_000;
		rom[5] = 8'b000_00_000;
		rom[6] = 8'b000_00_000;
		rom[7] = 8'b000_00_000;
		rom[8] = 8'b000_00_000;
		rom[9] = 8'b000_00_000;
		rom[10] = 8'b000_00_000;
		rom[11] = 8'b000_00_000;
		rom[12] = 8'b000_00_000;
		rom[13] = 8'b000_00_000;
		rom[14] = 8'b000_00_000;
		rom[15] = 8'b000_00_000;
	end
	
	assign instruction = rom[addr]; //actual read port, combinational, addr -> instruction
	
endmodule