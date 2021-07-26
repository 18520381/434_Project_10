module MaxPooling#(
    parameter DATA_WIDTH = 32,
    parameter WIDTH = 6
)(
    input [DATA_WIDTH-1:0] i_data,
    input valid_in, valid_in_max, valid_in_max1, clk, rst,
    output [DATA_WIDTH-1:0] o_data
);
  
    wire[DATA_WIDTH-1:0] i_data0, i_data1, i_data2, i_data3;

  lineMax #(
   .DATA_WIDTH(DATA_WIDTH),
   .WIDTH(WIDTH)
  )inst1(
    .o_data0(i_data0),
    .o_data1(i_data1), 
    .o_data2(i_data2), 
    .o_data3(i_data3),  
    .i_data(i_data),
    .valid_in(valid_in), 
    .clk(clk), 
    .rst(rst)
  );
  
  Max4#(
    .DATA_WIDTH(DATA_WIDTH) 
  )inst2(
    .InA(i_data0),
    .InB(i_data1),
    .InC(i_data2),
    .InD(i_data3),
    .valid_in(valid_in_max), 
    .valid_in1(valid_in_max1),
    .clk(clk), 
    .rst(rst),
    .o_data(o_data)
  );

  

endmodule
