module cpu_top(input wire clk, input wire reset, output wire [7:0] debug_reg_a); 
	
	reg [3:0] pc;
	//program counter
	always @(posedge clk) begin //4bit flipflopbased register
		if (reset)
			pc <= 4'd0; //resets to 0
		else if(!is_halt)
			pc <= pc + 4'd1; //else count and add 1, <= bc inside always block
		
	end
	//fetch
	wire [7:0] instruction; //
	
	instr_mem u_instr_mem(.addr(pc), .instruction(instruction)); //instance of memory module, wire pc into instruction memory's address input, grab whatever instruction comes out
	
	//decode
	wire [1:0] alu_opcode; //declare and instantiate, connecting outputs from instructions to wires
	wire [1:0] reg_read_addr_a, reg_read_addr_b, reg_write_addr;
	wire reg_write_enable, is_load;
	wire is_halt;
	
	control_unit u_control_unit(.instruction(instruction), //instances
	.alu_opcode(alu_opcode),
	.reg_read_addr_a(reg_read_addr_a),
	.reg_read_addr_b(reg_read_addr_b),
	.reg_write_addr(reg_write_addr),
	.reg_write_enable(reg_write_enable),
	.is_load(is_load),
	.is_halt(is_halt));
	//read+execute
	
	wire [7:0] read_data_a, read_data_b; //wires can be declared and connected at any point, a and b not delcared yet
	wire [7:0] alu_result;
	wire alu_zero, alu_carry_out;
	
	alu u_alu( //same instances for ALU
	.a(read_data_a),
	.b(read_data_b),
	.opcode(alu_opcode),
	.result(alu_result),
	.zero(alu_zero),
	.carry_out(alu_carry_out)
	);
	
	//immediate value
	
	wire [7:0] immediate_value = {5'b00000, instruction[2:0]}; //zero extension, delcared and assigned in one line
	
	//write back mux
	
	wire [7:0] write_data = is_load ? immediate_value : alu_result; //mux derivation, if is_load is true, use immediate value, else use alu_result
	
	regfile u_regfile( //reg instaniation, where a and b are produced and mux output write data is consumed
	.clk(clk),
	.write_enable(reg_write_enable),
	.read_addr_a(reg_read_addr_a),
	.read_addr_b(reg_read_addr_b),
	.write_addr(reg_write_addr),
	.write_data(write_data),
	.read_data_a(read_data_a),
	.read_data_b(read_data_b)
	);
	
	assign debug_reg_a = read_data_a; //simple assignment for further led implementation
	
endmodule