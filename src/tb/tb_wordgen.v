`timescale 10ns / 10ns

module tb_wordgen;

	reg sysclk; 
	 reg sw1;
	 reg sw2; 
	 reg sw3; 
	 reg sw4; 
	 reg write;
	 reg auto;
	 wire out;


    wordgen UUT( 
        .sysclk(sysclk),
        .sw1(sw1),
        .sw2(sw2),
        .sw3(sw3),
        .sw4(sw4),
        .write(write),
        .auto(auto),
		  .out(out)
    );
       
    // 50 MHz clock
    initial begin
        sysclk=1'b0;
        forever #1 sysclk = ~sysclk;
    end
    
    initial begin
        $dumpfile("wordgen.vcd");
        $dumpvars;
        sw1 = 1'b0;
        sw2 = 1'b0;
        sw3 = 1'b0;
        sw4 = 1'b0;
        write = 1'b0;
        auto = 1'b0;
		  #1000 sw1 = 1'b1;
		  #5000 sw1 = 1'b0;
		  #6000 write = 1'b1;
		  #7000 write = 1'b0;
		  #10000 sw1 = 1'b1;
		  #15000 write = 1'b1;
		  #20000 write = 1'b0;
		  #25000 sw1 = 1'b1;
		  #30000 sw1 = 1'b1;
		  #30000 sw2 = 1'b1;
		  #30000 sw3 = 1'b1;
		  #32000 write = 1'b1;
		  #35000 write = 1'b0;
		  #40000 sw4 = 1'b1;
		  #45000 write = 1'b1;
		  #46000 auto = 1'b0;
		  #50000 sw1 = 1'b0;
		  #50000 sw2 = 1'b0;
		  #50000 sw3 = 1'b0;
		  #50000 sw4 = 1'b0;
		  #70000 write = 1'b0;
		  #70000 auto = 1'b0;		  
        #1000000; $finish;
    end

endmodule
