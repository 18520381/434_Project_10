module layer1_1#(
    parameter DATA_WIDTH = 32,
    parameter WIDTH = 112
)(
  input  [DATA_WIDTH*3-1:0] i_data,
  input              clk, rst, valid_in,
  output [DATA_WIDTH*8-1:0] o_data,
  output             valid_out
);
  wire [DATA_WIDTH*3-1:0] i_CORE_IP1 [7:0];
  wire padding_valid, valid_in_pipeline2D, valid_in_bias;
  wire [31:0] counter_col, counter_row;
  wire [3:0] valid_pipeline2D;
  wire [1:0] valid_pipeline_bias;

/// CON2D_1///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101110001000101110001001000),
      .k2(32'b00111110011110000101110000100100),
      .k3(32'b00111110001001011000100001101000),
      .k4(32'b00111101101110100011011011101111),
      .k5(32'b00111101010011011110010110110100),
      .k6(32'b10111101110100010101111111111001),
      .k7(32'b00111110001011000110101000110011),
      .k8(32'b00111110000110001011000011110010),
      .k9(32'b10111100100100010100100001010000)
  ) CON2D_1(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110001010001011001010001101),
      .k2(32'b00111101001100101111111001011111),
      .k3(32'b00111110000111011101111101001000),
      .k4(32'b10111100111101101111010010000001),
      .k5(32'b10111110001100001011001010000111),
      .k6(32'b00111110000110100010010010110001),
      .k7(32'b10111110001001001110100111110000),
      .k8(32'b00111110010101110001101101110000),
      .k9(32'b00111100111010011000110110111000)
  ) CON2D_2(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000000010010111111100001),
      .k2(32'b00111101010111010010000010111101),
      .k3(32'b10111110010000010001011101011001),
      .k4(32'b10111101011010110111011011111010),
      .k5(32'b10111110000101100010011011100001),
      .k6(32'b10111101000011110111010100001010),
      .k7(32'b10111101011000001110010000101011),
      .k8(32'b10111110001011101011001111110011),
      .k9(32'b10111110011010011101101111110011)
  ) CON2D_3(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );


pipeline_layer1#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111011000111011011111110110000)
)   op1(
    .i_pipeline_layer1(i_CORE_IP1[0]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*1-1:DATA_WIDTH*0])
);

/// CON2D_2///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100110100100010110010001001),
      .k2(32'b10111101001010101001111001010101),
      .k3(32'b00111110001110000001001111101011),
      .k4(32'b00111101101111011100110101100011),
      .k5(32'b00111101011101010101001011010000),
      .k6(32'b10111110001100110010001110010101),
      .k7(32'b10111101111011101011110100100101),
      .k8(32'b00111110001011011100000110100001),
      .k9(32'b10111101101000110110010100101111)
  ) CON2D_4(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111001000000000000101100),
      .k2(32'b10111100100100001000110101100011),
      .k3(32'b00111101101011010001110011110011),
      .k4(32'b10111101001010010101100001101001),
      .k5(32'b00111101110000000001000100100101),
      .k6(32'b00111101111000111110110100010100),
      .k7(32'b10111110010101000110001110101101),
      .k8(32'b10111110001001010000001011111111),
      .k9(32'b10111110000000011011101111010110)
  ) CON2D_5(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100110000101000010011000001),
      .k2(32'b00111110001100101010110010100111),
      .k3(32'b10111110010011001000111010010001),
      .k4(32'b00111110010001000100001111010011),
      .k5(32'b10111101100000010001111101001010),
      .k6(32'b10111101111001110101100011101000),
      .k7(32'b00111110001111010111111011100111),
      .k8(32'b00111110000010001111010111010100),
      .k9(32'b10111101101110001110001010101101)
  ) CON2D_6(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );


pipeline_layer1#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111100001101100011101000000000)
)   op2(
    .i_pipeline_layer1(i_CORE_IP1[1]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*2-1:DATA_WIDTH*1])
);

/// CON2D_3///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110001101001011101100000100),
      .k2(32'b10111110011111010001001101001011),
      .k3(32'b00111110000111100001101111111000),
      .k4(32'b00111101110101100110010000110010),
      .k5(32'b10111110011111000111000011011010),
      .k6(32'b00111110000001101001101110010011),
      .k7(32'b00111110011001110100011101100001),
      .k8(32'b10111101100010000110001101011011),
      .k9(32'b00111110010110001111100011110100)
  ) CON2D_7(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110011010001011011100111100),
      .k2(32'b00111101101110010100010111001111),
      .k3(32'b00111110001101111011010010000001),
      .k4(32'b00111100110110111010100000011110),
      .k5(32'b10111101101100111110110010110001),
      .k6(32'b00111110011100100100010000010111),
      .k7(32'b00111110010001010110001010000011),
      .k8(32'b10111101101010111001010100000001),
      .k9(32'b10111101100101000010000010111111)
  ) CON2D_8(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101101111000110100111010110),
      .k2(32'b00111110000111011001100010111001),
      .k3(32'b00111100111011110001000110011100),
      .k4(32'b00111110010011110111111000001001),
      .k5(32'b00111101001011110110100001111101),
      .k6(32'b10111110010111000000100011011001),
      .k7(32'b00111101111111011010010010110001),
      .k8(32'b00111110000010101011110100110101),
      .k9(32'b10111110010000011101011010110010)
  ) CON2D_9(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );


pipeline_layer1#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111011100101011101110111011010)
)   op3(
    .i_pipeline_layer1(i_CORE_IP1[2]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*3-1:DATA_WIDTH*2])
);

/// CON2D_4///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110010010101000010110111110),
      .k2(32'b10111110001111111011111101101101),
      .k3(32'b00111110000010010001000000100010),
      .k4(32'b00111110010000001010011111110110),
      .k5(32'b10111110000010111110000100010000),
      .k6(32'b00111110010111110001010111010001),
      .k7(32'b10111101101111110110010100101110),
      .k8(32'b00111110001101010110100101001000),
      .k9(32'b00111101011111110010101111011101)
  ) CON2D_10(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000101011001100001011100),
      .k2(32'b10111101111100011011000010110111),
      .k3(32'b10111100001010110100111101011100),
      .k4(32'b00111110010011101010101101110110),
      .k5(32'b10111110000010100000101101001010),
      .k6(32'b10111101101111100010000000001101),
      .k7(32'b00111011011110111101010001100110),
      .k8(32'b00111101101101101001111001011110),
      .k9(32'b00111101111110010000110001110101)
  ) CON2D_11(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100001111110111010001111010),
      .k2(32'b10111110001100001101111111010100),
      .k3(32'b10111100110101111001000011000001),
      .k4(32'b00111110010010000111000000010010),
      .k5(32'b10111110000100100011101110010100),
      .k6(32'b10111101110100101011011010001111),
      .k7(32'b10111101111110111110100011100100),
      .k8(32'b10111110011111101111110110110111),
      .k9(32'b00111110000110011100100110011101)
  ) CON2D_12(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );


pipeline_layer1#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111100010010001011110000111100)
)   op4(
    .i_pipeline_layer1(i_CORE_IP1[3]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*4-1:DATA_WIDTH*3])
);

/// CON2D_5///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101100011001111100000101011),
      .k2(32'b10111110001111001000100110101000),
      .k3(32'b00111100110110011010110001001000),
      .k4(32'b10111011011101101101100111111110),
      .k5(32'b00111110010000000111101011010000),
      .k6(32'b00111101010011100100110110011101),
      .k7(32'b10111100100101010001001000011001),
      .k8(32'b10111011111100000101111000110001),
      .k9(32'b10111101110101100010001010001100)
  ) CON2D_13(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101011011011010100001010100),
      .k2(32'b00111110000111110100000000101101),
      .k3(32'b00111110000111001000001001111101),
      .k4(32'b00111110000100110111010010101010),
      .k5(32'b10111101000110101110100110000010),
      .k6(32'b10111110100000010010011011101001),
      .k7(32'b10111101100101000011101111101101),
      .k8(32'b10111110001100010101000010001010),
      .k9(32'b00111110011010111011111101000000)
  ) CON2D_14(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000111101111101000111001),
      .k2(32'b00111110011100111100111011001000),
      .k3(32'b00111110000010101011010011000110),
      .k4(32'b00111110010111101000001010111000),
      .k5(32'b00111101010111111000101000010101),
      .k6(32'b00111101101000110000100011001111),
      .k7(32'b10111100000010001110100100000001),
      .k8(32'b00111110010110010000101011001011),
      .k9(32'b00111101110010110110010111111000)
  ) CON2D_15(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );


pipeline_layer1#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111011101101001110011101101010)
)   op5(
    .i_pipeline_layer1(i_CORE_IP1[4]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*5-1:DATA_WIDTH*4])
);

/// CON2D_6///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110010011111100000101000111),
      .k2(32'b10111100001010111010000100011100),
      .k3(32'b10111110010101000000010100101110),
      .k4(32'b00111110001101001011101010010111),
      .k5(32'b10111101000101110000001000110001),
      .k6(32'b00111110000010110111111010001110),
      .k7(32'b00111101111101110100110010010100),
      .k8(32'b10111101101101000011011110110010),
      .k9(32'b00111101110000110011111100010110)
  ) CON2D_16(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000010000010100111000011),
      .k2(32'b00111101111000111000100100000110),
      .k3(32'b10111101000000101001000011110011),
      .k4(32'b00111100111100100101010011000010),
      .k5(32'b10111110010111101000001110110000),
      .k6(32'b00111101111100101010010000001101),
      .k7(32'b10111110001000010010111000000000),
      .k8(32'b10111110010110100101010101111001),
      .k9(32'b00111110010110100000000110100010)
  ) CON2D_17(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101000000001000110110110101),
      .k2(32'b10111101010100011101110001001111),
      .k3(32'b10111100001010011100110110100110),
      .k4(32'b10111101101100111100010111010111),
      .k5(32'b00111101001111110010011011100001),
      .k6(32'b00111110001101111010000000011101),
      .k7(32'b10111110001011010011001111010000),
      .k8(32'b10111110010001110110111000101100),
      .k9(32'b00111110100001111100111100001100)
  ) CON2D_18(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );


pipeline_layer1#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111100010101101010001101000010)
)   op6(
    .i_pipeline_layer1(i_CORE_IP1[5]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*6-1:DATA_WIDTH*5])
);

/// CON2D_7///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101010111111111001110101010),
      .k2(32'b00111110010000010001101001110110),
      .k3(32'b00111110001101011011011011011001),
      .k4(32'b10111100100100101001011111001101),
      .k5(32'b00111110000100110000010001111110),
      .k6(32'b00111101101110110011100011101100),
      .k7(32'b00111110000010101111100011111010),
      .k8(32'b00111110000011001111100010101110),
      .k9(32'b10111110000101010111111110001001)
  ) CON2D_19(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110001000111101111000000100),
      .k2(32'b10111110001100111110111100111110),
      .k3(32'b00111110001100100010011010111001),
      .k4(32'b00111110001101101100111100100010),
      .k5(32'b10111110011100010011011011000100),
      .k6(32'b10111110011001000011011011010101),
      .k7(32'b10111101001001011000001101010001),
      .k8(32'b10111101100111100001010100100110),
      .k9(32'b00111110010101111001100110010000)
  ) CON2D_20(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000011011000111110111111),
      .k2(32'b00111110010001100110110000111101),
      .k3(32'b10111110001111001001101111001100),
      .k4(32'b10111110001111100101111010110000),
      .k5(32'b00111101011111010000111001000010),
      .k6(32'b00111110000111001011011100111101),
      .k7(32'b00111110010110101110011110001111),
      .k8(32'b10111110001001001111110010011111),
      .k9(32'b00111101110000101100111010111010)
  ) CON2D_21(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );


pipeline_layer1#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111100100010111101001001001010)
)   op7(
    .i_pipeline_layer1(i_CORE_IP1[6]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*7-1:DATA_WIDTH*6])
);

/// CON2D_8///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110010111110100011010111001),
      .k2(32'b00111100100101101011111111010101),
      .k3(32'b10111101101110110011100101111110),
      .k4(32'b10111101010101101111011011011011),
      .k5(32'b00111110010100010100011110100101),
      .k6(32'b10111101110011110100000111111011),
      .k7(32'b00111110010011111001011101110000),
      .k8(32'b10111110000110110110010101010011),
      .k9(32'b00111110010101100011001000000010)
  ) CON2D_22(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000001001101000111001011),
      .k2(32'b10111110010000011000000011000100),
      .k3(32'b00111110000011010000010010011101),
      .k4(32'b00111110011000100001011000101001),
      .k5(32'b00111101101000010000010111010100),
      .k6(32'b00111110100000011110000001011000),
      .k7(32'b10111110011010001000011100111000),
      .k8(32'b00111100001100001001010000110000),
      .k9(32'b00111110001011000010001100010001)
  ) CON2D_23(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110010011111100001100010111),
      .k2(32'b00111110011000010000101011010010),
      .k3(32'b10111110000100011001101000011101),
      .k4(32'b10111101101111011011000100111001),
      .k5(32'b10111011011010001111000110110111),
      .k6(32'b00111110001001110110100111001000),
      .k7(32'b10111101111111100110010011111111),
      .k8(32'b10111110011101101010000100010010),
      .k9(32'b10111011000000000100010000011001)
  ) CON2D_24(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );


pipeline_layer1#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111001011111011011001010110000)
)   op8(
    .i_pipeline_layer1(i_CORE_IP1[7]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*8-1:DATA_WIDTH*7])
);

  control_layer1#(
      .WIDTH(WIDTH)
    )control( 
      .clk(clk), 
      .rst(rst),
      .valid_in(valid_in), 
      .padding_valid(padding_valid), 
      .counter_col(counter_col), 
      .counter_row(counter_row), 
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .valid_pipeline2D(valid_pipeline2D),
      .valid_in_bias(valid_in_bias),
      .valid_pipeline_bias(valid_pipeline_bias),
      .valid_out(valid_out)
    );
endmodule
