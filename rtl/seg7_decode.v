module seg7_decode (input wire  [3:0] hex_digit, output reg [6:0] segments);

	always @(*) begin //lookup table
		case (hex_digit)// hex literal notation
			4'h0: segments = 7'b1000000; //4'h means 4bit value written in hex
			4'h1: segments = 7'b1111001; //4'A = 4'b1010
			4'h2: segments = 7'b0100100; //physical wiring matching 7 seg display
			4'h3: segments = 7'b0110000; //display are active low
			4'h4: segments = 7'b0011001; //7'b1000000 for 0 means 6 segments on the 0 bits 1 off the 1 bit
			4'h5: segments = 7'b0010010; //forms 0 by lighting everything except middle segment
			4'h6: segments = 7'b0000010;
			4'h7: segments = 7'b1111000;
			4'h8: segments = 7'b0000000;
			4'h9: segments = 7'b0010000;
			4'hA: segments = 7'b0001000;
			4'hB: segments = 7'b0000011;
			4'hC: segments = 7'b1000110;
			4'hD: segments = 7'b0100001;
			4'hE: segments = 7'b0000110;
			4'hF: segments = 7'b0001110;
			default: segments = 7'b1111111;
		endcase
	end
endmodule
