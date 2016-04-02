module clockdiv (input clk, output pulse);

parameter WIDTH=8;          // 15 for 9600 cereal
parameter COUNT=WIDTH**2-1; // 5207 for 9600 cereal
reg [(WIDTH-1):0] clockdiv;
assign pulse=&clockdiv;

always @(posedge clk) 
begin
    if (clockdiv == COUNT) 
        clockdiv <= 0;
    else
        clockdiv <= clockdiv + 1;
end


endmodule
