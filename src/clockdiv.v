module clockdiv (input sysclk, output pulse);

parameter WIDTH=8;
parameter COUNT=WIDTH**2-1;
reg [(WIDTH-1):0] clockdiv;
assign pulse=&clockdiv;

always @(posedge sysclk) begin
    if (clockdiv == COUNT) 
        clockdiv <= 0;
    else
        clockdiv <= clockdiv + 1;
end


endmodule
