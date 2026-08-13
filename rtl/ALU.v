module alu (input wire [7:0] a, //8bit input wires
input wire [7:0] b, 
input wire [1:0] opcode, //2bit operation
output reg [7:0] result, //result register
output wire zero, //checks when result is equal to 0
output reg carry_out//when operation leads to greater number than 8bit
);
	always @(*) begin //Combinational logic
		carry_out = 1'b0;//set to 0
		case(opcode)
			2'b00: {carry_out, result} = a + b; //ADD
			2'b01: {carry_out, result} = a - b; //SUBTRACT
			2'b10: result = a & b;//AND
			2'b11: result = a | b;//OR
			default: result = 8'b0;//def 0
		endcase
	end

		assign zero = (result == 8'b0);//when result equals 0 zero is set to 1
		
endmodule
