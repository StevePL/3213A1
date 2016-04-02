module clockdiv (input clk, output pulse);

reg [14:0] clockdiv;

// Count to 5207 (50MHz clock to 9600 BAUD)
always @(posedge clk) 
begin
    if (clockdiv == 5207) 
        clockdiv <= 0;
    else
        clockdiv <= clockdiv + 1;
end

// Pulse every serial bit
pulse = (clockdiv == 0);

endmodule
