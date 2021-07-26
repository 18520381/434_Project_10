module control_MaxPooling#(
    parameter WIDTH = 5
)(
    input  clk, rst, valid_in,
    output valid_out_line, valid_in_max1, 
    output  valid_out
);

  control_lineMax#(
    .WIDTH(WIDTH)
    ) control1(
    .valid_in(valid_in), 
    .clk(clk), 
    .rst(rst),
    .valid_out(valid_out_line)  
    ); 
    
  control_Max4 control2(
    .valid_in(valid_out_line), 
    .clk(clk), 
    .rst(rst),
    .valid_out(valid_out), 
    .valid_in1(valid_in_max1) 
  );


endmodule







