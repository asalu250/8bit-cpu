module de10lite_top (input wire MAX10_CLK1_50, //pin assignment matches DE10 Lite .qpsf file
input wire [1:0] KEY,
output wire [9:0] LEDR,
output wire [6:0] HEX0,
output wire [6:0] HEX1);

	wire reset = ~KEY[0]; //~ is not, cpu_top needs reset to be active high so use bitwise operator to show inversion, KEY[0] = 1
	
	wire [7:0] debug_reg_a;
	
	cpu_top u_cpu_top (.clk(MAX10_CLK1_50), .reset(reset), .debug_reg_a(debug_reg_a)); //instantiate whole cpu as single unit, alu regfile, instr_mem, control_unit, OC
	
	assign LEDR[7:0] = debug_reg_a; //routes 8bit debug value to leds
	assign LEDR[9:8] = 2'b00; //top 2 are turned off
	
	seg7_decode u_hex0(.hex_digit(debug_reg_a[3:0]), .segments(HEX0)); //1 instance decoding low bits
	
	seg7_decode u_hex1(.hex_digit(debug_reg_a[7:4]), .segments(HEX1)); //1 instance decoding high bits
	
endmodule