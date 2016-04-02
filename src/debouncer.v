module debouncer (input wire btn, input wire sysclk, input wire reset, output wire btn_deb);

wire pulse;

// create clockdiv
clockdiv #(21) clockdiv(.sysclk(sysclk),.pulse(pulse));

// flip-flops
reg [2:0] ff;  
reg ff_out;

always @(posedge sysclk) begin	
  	ff_out<=ff[0]&ff[1]&ff[2]; 
	if(reset) begin
	   ff<=3'b0;
	end
	else if(pulse) begin
	     ff[0]<=btn;
	     ff[1]<=ff[0];
	     ff[2]<=ff[1];
	   end
end


//output logic
assign	btn_deb=(ff[0]&ff[1]&ff[2])&(~ff_out);

endmodule
