module control_line_padding#(
  parameter WIDTH = 112
)(
  input            valid_in, clk, rst,
  output           padding_valid,
  output  reg      valid_out,
  output  reg[31:0] counter_col, counter_row            
);
  parameter DOUT = WIDTH + 2;
  reg trash;
  reg [31:0] counter;  
  wire En, En_valid_out;
  assign padding_valid = (valid_in == 1 | trash == 1) ? 1: 0;
  assign En = (padding_valid == 1 & counter >= DOUT) ? 1: 0;
  assign En_valid_out = (padding_valid == 1 & counter >= DOUT - 1) ? 1: 0;
  
  always @(posedge clk or posedge rst)begin
      if(rst)begin
          trash <= 0;
      end
      else if(counter >= WIDTH*WIDTH-1)begin 
          trash <= 1;
      end
      else trash <= 0;   
  end 

  always @(posedge clk or posedge rst)begin
      if(rst)begin
          counter <= 32'b0;
      end
      else if(padding_valid)begin 
          counter <= (counter == WIDTH*WIDTH+WIDTH) ? 0:counter + 1;
      end   
      else counter <= counter;
  end     
  
  always @(posedge clk or posedge rst)begin
      if(rst)begin
           counter_col <= 32'b0;
      end
      else if(En)begin 
           counter_col <= (counter_col == WIDTH-1) ? 0: counter_col + 1;
      end 
      else counter_col <= counter_col; 
  end   
  always @(posedge clk or posedge rst)begin
      if(rst)begin
           counter_row <= 32'b0;
      end
      else if(En)begin 
           counter_row <= (counter_col == WIDTH-1) ? counter_row + 1: counter_row;
      end 
      else counter_row <= counter_row; 
  end 
  
  always @(posedge clk or posedge rst)begin
      if(rst)begin
           valid_out <= 0;
      end
      else if(En_valid_out)begin 
           valid_out <= 1;
      end 
      else valid_out <= 0; 
  end 
      
endmodule

