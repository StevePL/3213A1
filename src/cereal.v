module cereal (input wire sysclk,
               input wire [7:0] data,
               input wire start,
               output reg cereal);
  
  reg [3:0] state;
  wire pulse;
  
  // inst clockdiv
  clockdiv #(15,5207) clockdiv(.sysclk(sysclk),.pulse(pulse));
  
  // states
  parameter IDLE=4'b0000;
  parameter START=4'b0001;
  parameter BIT0=4'b0011;
  parameter BIT1=4'b0010;
  parameter BIT2=4'b0110;
  parameter BIT3=4'b0111;
  parameter BIT4=4'b0101;
  parameter BIT5=4'b0100;
  parameter BIT6=4'b1100;
  parameter BIT7=4'b1001;
  parameter DONE=4'b1011;
  
  //next state
  always @(posedge sysclk) begin
    case(state)
      IDLE: if(start) state <= START;   // go to start
      START: if(pulse) state <= BIT0;   // send start bit
      BIT0: if(pulse) state <= BIT1;    // bits 0--7
      BIT1: if(pulse) state <= BIT2;
      BIT2: if(pulse) state <= BIT3;
      BIT3: if(pulse) state <= BIT4;
      BIT4: if(pulse) state <= BIT5;
      BIT5: if(pulse) state <= BIT6;
      BIT6: if(pulse) state <= BIT7;
      BIT7: if(pulse) state <= DONE;
      DONE: if(pulse) state <= IDLE;    // stop bit
      default: state <= IDLE;           // fallback
    endcase
  end
  
  //send data over cereal
  always @(posedge sysclk) begin
    case(state)
      IDLE: cereal = 1'b1;              // send high idle
      START: cereal = 1'b0;             // send start bit
      BIT0: cereal = data[0];           // bits 0--7
      BIT1: cereal = data[0];
      BIT2: cereal = data[0];
      BIT3: cereal = data[0];
      BIT4: cereal = data[0];
      BIT5: cereal = data[0];
      BIT6: cereal = data[0];
      BIT7: cereal = data[0];
      DONE: cereal = 1;                 // stop bit
      default: cereal = 1;              // fallback
    endcase
  end
endmodule
