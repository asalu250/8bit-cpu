module control_unit(input wire [7:0] instruction, //input 8bit instr from mem
output reg [1:0] alu_opcode, //2bit output tells alu what op to perform
output wire [1:0] reg_read_addr_a, //2bit output tells regfile what registers to read from
output wire [1:0] reg_read_addr_b, //2bit output tells regfile what registers to read from
output wire [1:0] reg_write_addr, //2bit output tells regfile what registers to write to
output reg reg_write_enable, //decides whether write happens
output wire is_load, //checks whether instruction is load
output wire is_halt); //pc freeze
	
	always @(*) begin
		case (instruction[7:5])//slices opcode field of instruction, corresponding code checked below
			3'b001: alu_opcode = 2'b00;//ADD
			3'b010: alu_opcode = 2'b01;//SUB
			3'b011: alu_opcode = 2'b10;//AND
			3'b100: alu_opcode = 2'b11;//OR
			default: alu_opcode = 2'b00;//HALT/LOAD, reserved, unused
		endcase
	end
	
	always@(*) begin //decides reg_write_enable
		case (instruction[7:5]) //Makes sure no writing occurs when not supposed to
			3'b000: reg_write_enable = 1'b0;//HALT/NOP
			3'b110: reg_write_enable = 1'b0;//Reserved
			3'b111: reg_write_enable = 1'b0;
			default: reg_write_enable = 1'b1; //every other opcode does write, e.g. ADD/SUB/etc
		endcase
	end
	
	assign reg_read_addr_a = instruction[4:3]; //direct connection of opcode
	assign reg_read_addr_b = instruction[1:0]; //2nd op reg for alu
	assign reg_write_addr = reg_read_addr_a; //reuses earlier value
	assign is_load = (instruction[7:5] == 3'b101); //evaluates 1 when specifically LOAD call
	assign is_halt = (instruction[7:5] == 3'b000); //evaluates to 1 when is_halt is 1
endmodule
