module control (input wire sysclk, input wire write, input wire sw1, input wire sw2, input wire sw3, input wire sw4, output wire out_fin);


	wire holderOut;
	wire [3:0] addr;
   wire [7:0] d1;
	wire [7:0] d2;
	wire [7:0] d3;
	wire [7:0] d4;
	wire [2:0] count8;
	wire [7:0] count;
	
    // rom instances
    rom1 rom1(.data(d1),.addr(addr));
    rom2 rom2(.data(d2),.addr(addr));
    rom3 rom3(.data(d3),.addr(addr));
    rom4 rom4(.data(d4),.addr(addr));
    
	 holder holder(.sysclk(sysclk), .write(write), .sw1(sw1), .sw2(sw2), .sw3(sw3), .sw4(sw4), .out(holderOut));
	 splitter splitter(.sysclk(sysclk), .sw1(sw1), .sw2(sw2), .sw3(sw3), .sw4(sw4), .holder(holderOut), .rom1(d1), .rom2(d2), .rom3(d3), .rom4(d4), .count8(count8), .out(out_fin), .count(count));
	 addr addr1(.sysclk(sysckl), .count(count), .addr(addr));
	 

endmodule
