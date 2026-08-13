module regfile (
input wire clk,//writing clock edge
input wire write_enable,//prevents additional writes if one happens
input wire [1:0] read_addr_a,//port 1 that selects different registers from 0-3 for read ports
input wire [1:0] read_addr_b,//port 2 that selects different registers from 0-3 for read ports
input wire [1:0] write_addr,//what register to write into
input wire [7:0] write_data,//what 8bit value to write
output wire [7:0] read_data_a,//read ports output value 1, assign -> wire
output wire [7:0] read_data_b//read ports output value 2, assign -> wire
);
	reg[7:0] registers [0:3];//storage, 4 elements each 8bits wide, R0-R3, flipflops
	
	assign read_data_a = registers[read_addr_a]; // read port 1, combinational lookup
	assign read_data_b = registers[read_addr_b]; // read port 2, combinational lookup
	
	always@(posedge clk) begin //sequential logic
		if (write_enable) begin //if write_enable 1, i.e. if there is a write
			registers[write_addr] <= write_data; //store data with whatever register addr points to, <= refers to nonblocking, i.e. all right hand sides compute at same time
		end
	end
endmodule
