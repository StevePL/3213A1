module splitter (
	input wire sysclk,
	input wire sw1,
	input wire sw2,
	input wire sw3,
	input wire sw4,
	input wire holder,
	input wire [7:0] rom1,
	input wire [7:0] rom2,
	input wire [7:0] rom3,
	input wire [7:0] rom4,
	output reg [7:0] currentData,
	output reg [3:0] count8,
	output reg [7:0] count);

	// Is this correct syntax?
	reg [1:0] signum = 2'b00;
	
    // next state
    always @(posedge sysclk) begin
		if (holder == 1)
			begin
				if ((signum == 0) && (count == 87))
					begin 
						signum <= 1;
						count <= 0;
					end
				else if ((signum == 1) && (count == 79))
					begin 
						signum <= 2;
						count <= 0;
					end
				else if ((signum == 2) && (count == 55))
					begin 
						signum <= 3;
						count <= 0;
					end
				else if ((signum == 3) && (count == 31))
					begin 
						signum <= 0;
						count <= 0;
					end
				else 	count <= count + 1;
				
				if (count8 == 7) count8=3'b000;
				else count8 <= count8 + 1;
				
				if ((sw1 == 1) && (signum == 0))
					begin 
						currentData <= rom1;
					end
				else if ((sw2== 1) && (signum == 1))
					begin 
						currentData <= rom2;
					end 
				else if ((sw3 == 1) && (signum == 2))
					begin 
						currentData <= rom3;
					end
				else if ((sw4 == 1) && (signum == 3))
					begin 
						currentData <= rom4;
					end
				else currentData <= 8'b00000000;
			end
		else 
			begin
				signum <= 0;
				count <= 0;
				count8 <= 0;
				currentData <= 8'b00000000;
			end
		end
endmodule
