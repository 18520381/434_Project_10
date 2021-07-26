module MaxPooling3x3#(
    parameter DATA_WIDTH = 32,
    parameter WIDTH = 3
)(
    input [DATA_WIDTH-1:0] i_data,
    input valid_in, valid_in_max, 
    input [2:0] valid_in_max1, 
    input clk, rst,
    output [DATA_WIDTH-1:0] o_data
);
  
    wire[DATA_WIDTH-1:0] i1, i2, i3, i4, i5, i6, i7, i8, i9;

 linebuffer #(
   .DATA_WIDTH(DATA_WIDTH),
   .WIDTH(3)
  )inst1(
    .o_data0(i1),
    .o_data1(i2), 
    .o_data2(i3), 
    .o_data3(i4),  
    .o_data4(i5),
    .o_data5(i6), 
    .o_data6(i7), 
    .o_data7(i8),
    .o_data8(i9),
    .i_data(i_data),
    .valid_in(valid_in), 
    .clk(clk), 
    .rst(rst)
  );
  
  Max9#(
    .DATA_WIDTH(DATA_WIDTH) 
  )inst2(
    .i1(i1),
    .i2(i2), 
    .i3(i3), 
    .i4(i4),  
    .i5(i5),
    .i6(i6), 
    .i7(i7), 
    .i8(i8),
    .i9(i9),
    .valid_in(valid_in_max), 
    .valid_in1(valid_in_max1),
    .clk(clk), 
    .rst(rst),
    .o_data(o_data)
  );

  

endmodule


