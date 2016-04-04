module cereal (input wire sysclk,
               input wire [7:0] data,
               input wire start,
               output reg cereal,
               output reg status);
  
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
  
  reg [3:0] state = IDLE;
  
  //next state
  always @(posedge pulse) begin
    case(state)
      IDLE: if (start) state <= START;   // go to start
      START: state <= BIT0;   // send start bit
      BIT0: state <= BIT1;    // bits 0--7
      BIT1: state <= BIT2;
      BIT2: state <= BIT3;
      BIT3: state <= BIT4;
      BIT4: state <= BIT5;
      BIT5: state <= BIT6;
      BIT6: state <= BIT7;
      BIT7: state <= DONE;
      DONE: state <= IDLE;              // stop bit
      default: state <= IDLE;           // fallback
    endcase
  end
  
  //send data over cereal
  always @(state) begin
    case(state)
      IDLE: begin cereal = 1'b1; status = 1'b1; end                   // send high idle and status to ready
      START: begin cereal = 1'b0; status = 1'b0; end                  // send start bit and status to busy
      BIT0: cereal = data[0];                                         // bits 0--7
      BIT1: cereal = data[1];
      BIT2: cereal = data[2];
      BIT3: cereal = data[3];
      BIT4: cereal = data[4];
      BIT5: cereal = data[5];
      BIT6: cereal = data[6];
      BIT7: cereal = data[7];
      DONE: begin cereal = 1'b1; status = 1'b1; end                 // stop bit and status to ready
      default: cereal = 1'b1;                                       // fallback
    endcase
  end
endmodule
