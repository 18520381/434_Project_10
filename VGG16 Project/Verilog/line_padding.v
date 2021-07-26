module line_padding#(
  parameter DATA_WIDTH = 32,
  parameter WIDTH = 5
)(
  output [DATA_WIDTH-1:0] o_data0,o_data1,o_data2,o_data3,o_data4,o_data5,o_data6,o_data7,o_data8,
  input  [DATA_WIDTH-1:0] i_data,
  input            valid_in, clk, rst,
  input [31:0] counter_col, counter_row
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

  
  assign o_data0 = (counter_row == 0 | counter_col == 0)                ? 0 : regs[DIN-1];
  assign o_data1 = (counter_row == 0)                                   ? 0 : regs[DIN-2];
  assign o_data2 = (counter_row == 0 | counter_col == WIDTH - 1)        ? 0 : regs[DIN-3];
  assign o_data3 = (counter_col == 0)                                   ? 0 : regs[DIN-WIDTH-1];
  assign o_data4 =                                                            regs[DIN-WIDTH-2];
  assign o_data5 = (counter_col == WIDTH - 1)                           ? 0 : regs[DIN-WIDTH-3];
  assign o_data6 = (counter_row == WIDTH - 1 | counter_col == 0)        ? 0 : regs[2];
  assign o_data7 = (counter_row == WIDTH - 1)                           ? 0 : regs[1];
  assign o_data8 = (counter_row == WIDTH - 1 | counter_col == WIDTH - 1)? 0 : regs[0];

endmodule
                    
