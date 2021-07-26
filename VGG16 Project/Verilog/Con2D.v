module Con2D#(
    parameter DATA_WIDTH = 32,
    parameter WIDTH = 7,
    parameter k1  = 32'b01000000000000000000000000000000,
    parameter k2  = 32'b01000000000000000000000000000000,
    parameter k3  = 32'b01000000000000000000000000000000,
    parameter k4  = 32'b01000000000000000000000000000000,
    parameter k5  = 32'b01000000000000000000000000000000,
    parameter k6  = 32'b01000000000000000000000000000000,
    parameter k7  = 32'b01000000000000000000000000000000,
    parameter k8  = 32'b01000000000000000000000000000000,
    parameter k9  = 32'b01000000000000000000000000000000
)(
  input  [DATA_WIDTH-1:0] i_data,
  input         clk, rst, valid_in, valid_in_pipeline2D,
  input [31:0] counter_col, counter_row,
  input [3:0] valid_pipeline2D,
  output [DATA_WIDTH-1:0] o_data        
);

  wire [DATA_WIDTH-1:0] i1, i2, i3, i4, i5, i6, i7, i8, i9;

  line_padding #(
         .DATA_WIDTH(DATA_WIDTH),
         .WIDTH(WIDTH)
  )op0(
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
         .rst(rst),
         .counter_col(counter_col),
         .counter_row(counter_row)           
  ); 
pipeline2D#(
     .DATA_WIDTH(DATA_WIDTH),
     .k1(k1),
     .k2(k2),
     .k3(k3),
     .k4(k4),
     .k5(k5),
     .k6(k6),
     .k7(k7),
     .k8(k8),
     .k9(k9)
  )op2(  
     .i1(i1),
     .i2(i2),
     .i3(i3),
     .i4(i4),
     .i5(i5),
     .i6(i6),
     .i7(i7),
     .i8(i8),
     .i9(i9),   
     .clk(clk), 
     .rst(rst),  
     .valid_in(valid_in_pipeline2D),
     .valid_pipeline2D(valid_pipeline2D),
     .o_data(o_data)
  );

endmodule
                    


