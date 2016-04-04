module wordgen (input wire sysclk, input wire sw1, input wire sw2, input wire sw3, input wire sw4, input wire write, input wire auto, output wire out);

    wire write_deb, auto_deb;
    reg start;
    wire status; //cereal status
    reg [7:0] data;
    reg auto_on = 0;
	 reg i = 0;
    
    // rom wires
    wire [7:0] d1;
    wire [7:0] d2;
    wire [7:0] d3;
    wire [7:0] d4;
    wire [3:0] a1;
    wire [3:0] a2;
    wire [3:0] a3;
    wire [3:0] a4;
    
    parameter W1 = 4'b0000;
    parameter W2 = 4'b0001;
    parameter W3 = 4'b0010;
    parameter W4 = 4'b0100;
    parameter WAIT = 4'b1000;
    
    reg state[3:0] = WAIT;
    reg next[3:0] = WAIT;
    
    reg done = 0;
    
    // inst debouncers
    debouncer debouncer(.sysclk(sysclk),.btn(write),.btn_deb(write_deb));
    debouncer debouncer(.sysclk(sysclk),.btn(auto),.btn_deb(auto_deb));
    // inst cereal
    cereal cereal(.sysclk(sysclk),.data(data),.start(start),.cereal(out),.status(status));
    //inst slowclk ~1 s heartbeat
    clockdiv #(25) clockdiv(.sysclk(sysclk),.pulse(slowclk));
    //inst roms
    rom1 rom1(.data(d1),.addr(a1));
    rom2 rom2(.data(d2),.addr(a2));
    rom3 rom3(.data(d3),.addr(a3));
    rom4 rom4(.data(d4),.addr(a4));
    
    // control auto mode
    always @(posedge auto_deb) begin
        if (!auto_on) auto_on = 1;
        else auto_on = 0;
    end
    
    // next state
    always @(posedge slowclk) state <= next;
    
    // select next state
    always @(*) begin
        case(state)
            WAIT: if(write_deb || auto_on) begin
                    next <= W1;
                    done = 0;
                end
                else next <= WAIT;
            W1: if(done) begin
                    next <= W2;
                    done = 0;
                end
                else next <= W1; 
            W2: if(done) begin
                    next <= W3;
                    done = 0;
                end
                else next <= W2;
            W3: if(done) begin
                    next <= W4;
                    done = 0;
                end
                else next <= W3;
            W4: if(done) begin
                    if(auto_on) begin
                        next <= W1;
                        done = 0;
                    end
                    else next <= WAIT;
                end
                else next <= W4;
        endcase
    end
    
    // output logic
    always @(state) begin
        case(state)
            W1: begin 
						for (a1 = 4'b0000; a1 < 4'b1011; a1 = a1 + 1'b1) begin
                        data = d1;
                        start = 1;
						end
                done = 1;
					 start = 0;
					 end
            W2: begin 
						for (a2 = 4'b0000; a2 < 4'b1010; a2 = a2 + 1'b1) begin
                        data = d2;
                        start = 1;
						end
                done = 1;
					 start = 0;
					 end
            W3: begin
						for (a3 = 4'b0000; a3 < 4'b0111; a3 = a3 + 1'b1) begin
                        data = d3;
                        start = 1;
						end
                done = 1;
					 start = 0;
					 end
            W4: begin
						for (a4 = 4'b0000; a3 < 4'b0100; a3 = a3 + 1'b1) begin
                        data = d4;
                        start = 1;
						end
                done = 1;
					 start = 0;
					 end
            default: data = 8'b00000000;
        endcase
    end
endmodule
