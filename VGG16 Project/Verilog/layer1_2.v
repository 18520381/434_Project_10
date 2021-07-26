module layer1_2#(
    parameter DATA_WIDTH = 32,
    parameter WIDTH = 112
)(
  input  [DATA_WIDTH*3-1:0] i_data,
  input              clk, rst, valid_in,
  output [DATA_WIDTH*8-1:0] o_data,
  output             valid_out
);

  wire[DATA_WIDTH*8-1:0] o_layer1;
  wire valid_in_layer2;

  layer1_1#(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  )layer1(
    .i_data(i_data),
    .clk(clk),
    .rst(rst),
    .valid_in(valid_in),
    .o_data(o_layer1),
    .valid_out(valid_in_layer2)
  );
  
  layer2_1#(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  )layer2(
    .i_data(o_layer1),
    .clk(clk),
    .rst(rst),
    .valid_in(valid_in_layer2),
    .o_data(o_data),
    .valid_out(valid_out)
  );
  
endmodule