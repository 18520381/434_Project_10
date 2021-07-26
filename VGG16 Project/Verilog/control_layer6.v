module control_layer6#(
    parameter WIDTH = 5
)(
    input  clk, rst, valid_in,
    output padding_valid,
    output [31:0] counter_col, counter_row,
    output valid_in_pipeline2D,
    output [3:0] valid_pipeline2D,
    output valid_in_bias,
    output [5:0] valid_pipeline_bias,
    output  valid_out
);

    control_line_padding#(
      .WIDTH(WIDTH)
    )control1 (
      .valid_in(valid_in), 
      .clk(clk), 
      .rst(rst),
      .padding_valid(padding_valid),
      .valid_out(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row)
    );   
    
    control_pipeline2D control2(
    .clk(clk), 
    .rst(rst), 
    .valid_in(valid_in_pipeline2D),
    .valid_out(valid_in_bias), 
    .valid_pipeline2D(valid_pipeline2D)
    );
    
    control_pipeline_layer6 control3(
    .valid_in_bias(valid_in_bias), 
    .clk(clk), 
    .rst(rst),
    .valid_out(valid_out), 
    .valid_pipeline(valid_pipeline_bias)
    );  
    


endmodule









