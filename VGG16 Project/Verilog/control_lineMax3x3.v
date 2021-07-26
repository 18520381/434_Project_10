`define INLINE 2'b00

`define CACULATER 2'b01

`define PRINT 2'b10

`define NONE 2'b11

module control_lineMax3x3#(
    parameter WIDTH = 112
  )(
    input valid_in, clk, rst,
    output reg valid_out
  );
  parameter DIN = 2*WIDTH + 3;
  reg [31:0] k,j;
  reg [1:0] stage;
  reg [1:0] next_stage;
  
  always @(*)begin
      if(rst)begin
          stage  <= `INLINE;
      end
      else begin
          stage <= next_stage;
      end
  end
     
  always @(posedge clk or posedge rst)begin
      if(rst) begin
          k <= 32'b0;
          j <= 32'b0;
          valid_out <= 0;
      end
      else if(valid_in)begin
          case(stage)
          `NONE: begin
            	   k <= 32'b0;
                j <= 32'b0;
                valid_out <= 0; 
          end 
          `INLINE: begin
                k <= k + 1;
                j <= 32'd0;
                valid_out <= 0;
          end
          `CACULATER: begin
                k <= 32'd0;
                j = j + 1;
                valid_out <= 0;
          end
          `PRINT: begin
                k <= 32'd0;
                j = j + 1;
                valid_out <= 1;
          end
        endcase
      end
      else valid_out <= 0;
    end
    
  always @(*) begin
      case(stage)
        `NONE: begin
            if(valid_in)
                next_stage = `INLINE;
            else
                next_stage = `NONE;
          end
        `INLINE: begin
            if(k == DIN - 1)
                next_stage = `CACULATER;
            else
                next_stage = `INLINE;
          end
        `CACULATER: begin
            if(j % 3 == 0) 
                next_stage = `PRINT;
            else if(j == WIDTH - 1 ) 
                next_stage = `INLINE;
            else
                next_stage = `CACULATER;
          end
        `PRINT: begin
            if(j % 3 != 0) 
                next_stage = `CACULATER;
           	else if(j == WIDTH - 1 ) 
                next_stage = `INLINE;
            else
                next_stage = `PRINT;
          end
      endcase
  end
  
endmodule


