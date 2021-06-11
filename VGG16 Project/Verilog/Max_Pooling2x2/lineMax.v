`define INLINE 2'b00

`define CACULATER 2'b01

`define PRINT 2'b10

`define NONE 2'b11
module lineMax#(
  parameter DATA_WIDTH = 32,
  parameter WIDTH = 5
)(
  output [DATA_WIDTH-1:0] o_data0,o_data1,o_data2,o_data3,
  input  [DATA_WIDTH-1:0] i_data,
  input            valid_in, clk, rst,
  output  reg      valid_out
  //output  reg [31:0] k, j ,
  //output  reg [1:0] stage            
);
  
  parameter DIN = WIDTH + 2;
  reg [DATA_WIDTH-1:0] regs[0:DIN-1];

  genvar i;
  generate 
      for (i=0; i < DIN; i = i + 1)begin
          always @(posedge clk) begin
              if (valid_in)begin
                  if(i == 0)
                      regs[i] <= i_data;    
                  else
                      regs[i] <= regs[i-1];
              end
         end
     end
  endgenerate
  
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
            if(j % 2 == 0) 
                next_stage = `PRINT;
            else if(j == WIDTH - 1 ) 
                next_stage = `INLINE;
            else
                next_stage = `CACULATER;
          end
        `PRINT: begin
            if(j % 2 == 1) 
                next_stage = `CACULATER;
           	else if(j == WIDTH - 1 ) 
                next_stage = `INLINE;
            else
                next_stage = `PRINT;
          end
      endcase
  end
  /*always @(posedge clk or posedge rst)begin
      if(rst)begin
          k <= 32'b0;
          j <= 32'b0;
          e <= 0;
      end
      else if(valid_in)begin 
          if(k >= DIN-1)begin
              if(k %(DIN-2) == 0)
                  e <= 1;
              else e <= 0;
              if(e == 1)begin 
                  if(j % WIDTH == 0)
                        valid_out <= 1; 
                  else valid_out <= 0; 
              end
              j <= j + 1;
          end
          else valid_out <= 0; 
          k <= k + 1;
      end 
      else  valid_out <= 0;   
  end */    

  
          assign o_data0 = regs[DIN-1];
          assign o_data1 = regs[DIN-2];
          assign o_data2 = regs[1];
          assign o_data3 = regs[0];

endmodule
                    

