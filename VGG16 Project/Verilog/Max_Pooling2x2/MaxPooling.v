module MaxPooling#(
    parameter DATA_WIDTH = 32,
    parameter WIDTH = 6
)(
    input [DATA_WIDTH-1:0] i_data,
    input valid_in, clk, rst,
    output [DATA_WIDTH-1:0] o_data,
    output valid_out
);
  
    wire valid_in_op1;
    wire[DATA_WIDTH-1:0] i_data0, i_data1, i_data2, i_data3;

    










    .clk(clk), 
    .rst(rst),
    .valid_out(valid_in_op1)











    .clk(clk), 
    .rst(rst),
    .o_data(o_data),
    .valid_out(valid_out)


