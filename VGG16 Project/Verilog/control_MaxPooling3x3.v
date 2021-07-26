module control_MaxPooling3x3#(
    parameter WIDTH = 5
)(
    input  clk, rst, valid_in,
    output valid_out_line, 
    output [2:0] valid_in_max1, 
    output  valid_out
);

  control_lineMax3x3#(
    .WIDTH(WIDTH)
    ) control1(
    .valid_in(valid_in), 
    .clk(clk), 
    .rst(rst),
    .valid_out(valid_out_line)  
    ); 
    
  control_Max9 control2(
    .valid_in(valid_out_line), 
    .clk(clk), 
    .rst(rst),
    .valid_out(valid_out), 
    .valid_in1(valid_in_max1) 
  );


endmodule









