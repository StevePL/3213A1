module addr( 
	input wire [7:0] count,
	input wire sysclk,
	output reg [4:0] addr
    );


	always @(posedge sysclk) begin
		if (count < 8) addr <= 4'b0000;
		else if ((count > 7) && (count < 16)) addr <= 4'b0001;
		else if ((count > 15) && (count < 24)) addr <= 4'b0010;
		else if ((count > 23) && (count < 32)) addr <= 4'b0011;
		else if ((count > 31) && (count < 40)) addr <= 4'b0100;
		else if ((count > 39) && (count < 48)) addr <= 4'b0101;
		else if ((count > 47) && (count < 56)) addr <= 4'b0110;
		else if ((count > 55) && (count < 64)) addr <= 4'b0111;
		else if ((count > 63) && (count < 72)) addr <= 4'b1000;
		else if ((count > 71) && (count < 80)) addr <= 4'b1001;
		else if ((count > 79) && (count < 88)) addr <= 4'b1010;
		else if ((count > 87) && (count < 96)) addr <= 4'b1011;
		else if ((count > 95) && (count < 104)) addr <= 4'b1100;
		else if ((count > 103) && (count < 112)) addr <= 4'b1101;
		else if ((count > 111) && (count < 120)) addr <= 4'b1110;
		else if ((count > 119) && (count < 128)) addr <= 4'b0010;
		else addr = 4'b0000;
	end

endmodule
