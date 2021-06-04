module linebuff#(
  parameter DATA_WIDTH = 32,
  parameter WIDTH = 7
)(
  output [DATA_WIDTH-1:0] o_data0,o_data1,o_data2,o_data3,o_data4,o_data5,o_data6,o_data7,o_data8,
  input  [DATA_WIDTH-1:0] i_data,
  input            valid_in, clk, rst,
  output  reg      valid_out
 // output  reg [7:0] k, j             
);
  
  parameter DIN = WIDTH*2 + 3;
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
  
  reg [7:0] k,j;
  always @(posedge clk or posedge rst)begin
      if(rst)begin
          k <= 7'b0;
          j <= 7'b0;
      end
      else if(valid_in)begin 
          k <= k + 1;
          if(k >= DIN-1)begin
              j <= j + 1'b1;
              if((j % WIDTH == (WIDTH-1))||(j % WIDTH == (WIDTH-2)))
                      valid_out <= 0; 
              else valid_out <= 1; 
          end
          else valid_out <= 0; 
      end 
      else  valid_out <= 0;   
  end     
      
  
          assign o_data0 = regs[DIN-1];
          assign o_data1 = regs[DIN-2];
          assign o_data2 = regs[DIN-3];
          assign o_data3 = regs[DIN-WIDTH-1];
          assign o_data4 = regs[DIN-WIDTH-2];
          assign o_data5 = regs[DIN-WIDTH-3];
          assign o_data6 = regs[2];
          assign o_data7 = regs[1];
          assign o_data8 = regs[0];

endmodule
                    