module layer3_1#(
    parameter DATA_WIDTH = 32,
    parameter WIDTH = 56
)(
  input  [DATA_WIDTH*8-1:0] i_data,
  input              clk, rst, valid_in,
  output [DATA_WIDTH*16-1:0] o_data,
  output             valid_out
);
  wire [DATA_WIDTH*8-1:0] i_CORE_IP1 [15:0];
  wire padding_valid, valid_in_pipeline2D, valid_in_bias;
  wire [31:0] counter_col, counter_row;
  wire [3:0] valid_pipeline2D;
  wire [3:0] valid_pipeline_bias;

/// CON2D_1///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100111010101101110011010100),
      .k2(32'b00111101111100010001011101111100),
      .k3(32'b00111101010000111001001101100101),
      .k4(32'b10111101011001111001001010100100),
      .k5(32'b10111101010101111010001110101011),
      .k6(32'b00111110000010010111110010000100),
      .k7(32'b10111101000011110100111001001111),
      .k8(32'b00111110000001010100101100000001),
      .k9(32'b10111101110111101101010000001001)
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
      .k1(32'b10111101011100010111101100010110),
      .k2(32'b10111101100110100000010010111001),
      .k3(32'b10111101001000111000111110111100),
      .k4(32'b10111110001011000010001110010010),
      .k5(32'b10111100100010101110010001010001),
      .k6(32'b10111101010111111111000110101001),
      .k7(32'b00111101110000011111111111110000),
      .k8(32'b10111101111100110101000001101101),
      .k9(32'b10111001110010001111100000100101)
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
      .k1(32'b10111101110110010000010101111111),
      .k2(32'b10111101011010101101110100100001),
      .k3(32'b10111101010111010110111110001100),
      .k4(32'b00111110000111111110110111100111),
      .k5(32'b10111100111011000100001001001011),
      .k6(32'b00111110000000001100100000011001),
      .k7(32'b00111101100101100111011011011101),
      .k8(32'b10111110000100100001111010001010),
      .k9(32'b00111101111100100101001100010010)
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101110111101001001000111101),
      .k2(32'b10111101011001111000101100011011),
      .k3(32'b00111110001010001111001111000101),
      .k4(32'b10111101000010011110000000111100),
      .k5(32'b10111110000000011110001011101101),
      .k6(32'b10111100001100111011001100100000),
      .k7(32'b10111100010110010111101001000001),
      .k8(32'b00111101101101110111100011110001),
      .k9(32'b10111101000010111011011110111010)
  ) CON2D_4(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101100010000110001000001110),
      .k2(32'b00111101001111111100110001011010),
      .k3(32'b10111110000101001000110111011000),
      .k4(32'b10111101000101110100001101001111),
      .k5(32'b00111100001001010000010000001110),
      .k6(32'b00111101000000000001010101110100),
      .k7(32'b00111101110110010101001110000011),
      .k8(32'b00111101110111011110000000000010),
      .k9(32'b00111101101110010111000011100100)
  ) CON2D_5(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000101110110101101000000),
      .k2(32'b10111101011000000111100000010001),
      .k3(32'b00111110000100111111111000101110),
      .k4(32'b10111101111110100111001111100000),
      .k5(32'b00111100110010110111011100101111),
      .k6(32'b10111101001111101000010110010111),
      .k7(32'b00111001101100100101110110111010),
      .k8(32'b10111110000001010000010111001111),
      .k9(32'b00111110000111001000111111110111)
  ) CON2D_6(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100110010010100100111000100),
      .k2(32'b00111101111000111011111011111011),
      .k3(32'b00111101110111111110010110100101),
      .k4(32'b10111110000001011001000000011011),
      .k5(32'b00111101001010010111111011110000),
      .k6(32'b10111110000101011101100010010111),
      .k7(32'b10111101101110111011111110101100),
      .k8(32'b10111101100100110011010100011110),
      .k9(32'b10111110001001011010100110000110)
  ) CON2D_7(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101110010001100111010101000),
      .k2(32'b00111101111110010000010100000001),
      .k3(32'b10111110000100111101000111101111),
      .k4(32'b00111101000111011000110011011100),
      .k5(32'b00111101000100111001001000010001),
      .k6(32'b00111101011010110010011000101110),
      .k7(32'b00111101001000110000010010110101),
      .k8(32'b10111101010100110101111110110001),
      .k9(32'b00111100111010110110111011011110)
  ) CON2D_8(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111100001110000000011110011100)
)   op1(
    .i_pipeline_layer2(i_CORE_IP1[0]), 
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
      .k1(32'b00111101100010101011000111100101),
      .k2(32'b10111101111110000101011010110001),
      .k3(32'b00111101111110101110110010010000),
      .k4(32'b00111101100010111010001110100000),
      .k5(32'b10111101001111100101000010001010),
      .k6(32'b10111100001001101000011100000100),
      .k7(32'b00111100011110110110000000111011),
      .k8(32'b00111101100101110110110100011010),
      .k9(32'b00111101110010100010011001001110)
  ) CON2D_9(
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
      .k1(32'b10111100110101111111001000100101),
      .k2(32'b10111110001010110101111111110111),
      .k3(32'b00111101110101111101110010101100),
      .k4(32'b10111101000111010111101110111011),
      .k5(32'b10111110000101011001011110011110),
      .k6(32'b10111101101101010111111001001011),
      .k7(32'b00111110000111010101110000000110),
      .k8(32'b00111101100001000000111010100011),
      .k9(32'b10111101101111000011111111010101)
  ) CON2D_10(
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
      .k1(32'b00111100001010011011111100111111),
      .k2(32'b10111110000010011000110110100100),
      .k3(32'b10111100011111000110001110001111),
      .k4(32'b00111101110001000101010111101000),
      .k5(32'b10111101100000000011000001111101),
      .k6(32'b10111100010101010100001100000100),
      .k7(32'b10111101100001101010110110010111),
      .k8(32'b00111101011010000011101001111010),
      .k9(32'b10111101010111110101000101101100)
  ) CON2D_11(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101010101011111101111000),
      .k2(32'b10111101001100110011100100101011),
      .k3(32'b10111101111110010101101001110010),
      .k4(32'b00111100111111110111110110100001),
      .k5(32'b10111101100011101110000000011001),
      .k6(32'b10111101100001001111100000111000),
      .k7(32'b00111101001100000101010111001010),
      .k8(32'b10111101100000010110101011101110),
      .k9(32'b00111100111000110001110000001111)
  ) CON2D_12(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000101010000100000100101),
      .k2(32'b10111101111101111001110010110100),
      .k3(32'b10111100110000111100000011011001),
      .k4(32'b10111110000010101000111101111111),
      .k5(32'b00111101101101011000001000111010),
      .k6(32'b10111110000011101010111001001001),
      .k7(32'b00111100010110111111001011111110),
      .k8(32'b10111101110100110000011100000100),
      .k9(32'b10111101110000100010111110111001)
  ) CON2D_13(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000011001011011110001110),
      .k2(32'b10111101000000110110100001100101),
      .k3(32'b00111101110100111110100001110000),
      .k4(32'b00111101000101101000010101011100),
      .k5(32'b00111110001010110100111111001101),
      .k6(32'b10111100100101110010011111010101),
      .k7(32'b00111101011001000101001000100011),
      .k8(32'b00111110001000000001010100111011),
      .k9(32'b10111101101101011100000010010110)
  ) CON2D_14(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101100001000101010110100111),
      .k2(32'b00111110000000011001001111100000),
      .k3(32'b10111101001001011100100000100011),
      .k4(32'b10111110000111000001110100001100),
      .k5(32'b00111101111111011001001101111110),
      .k6(32'b10111101100001111111010100001000),
      .k7(32'b00111100000100110011001010110100),
      .k8(32'b00111101011000101110000100000000),
      .k9(32'b10111101000101110110010001000111)
  ) CON2D_15(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101101000000100111101011),
      .k2(32'b10111100101101101011010001010000),
      .k3(32'b10111101111111011110111000111011),
      .k4(32'b10111101101110110101100010110100),
      .k5(32'b10111101101001110000100010101110),
      .k6(32'b00111101111101010100001111011001),
      .k7(32'b10111110000001101001010011010110),
      .k8(32'b10111101100000100001010010001000),
      .k9(32'b00111011110111001101111010011111)
  ) CON2D_16(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111100100010010100001011000001)
)   op2(
    .i_pipeline_layer2(i_CORE_IP1[1]), 
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
      .k1(32'b10111110001100001000101001110100),
      .k2(32'b00111101111011001101110000110011),
      .k3(32'b10111100110101101010010001111011),
      .k4(32'b10111101001011111011110111010101),
      .k5(32'b10111101111010100110101111010001),
      .k6(32'b00111110000001000111100010110000),
      .k7(32'b10111110000000010101011110010011),
      .k8(32'b10111101110100111000101001001101),
      .k9(32'b10111110000001100100001101111000)
  ) CON2D_17(
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
      .k1(32'b00111101101101011000100101110000),
      .k2(32'b10111101010011001101101101101100),
      .k3(32'b10111101010100110100101001011100),
      .k4(32'b00111110000000000110100100011010),
      .k5(32'b10111101111001100110000101110011),
      .k6(32'b00111100001010111100001100100110),
      .k7(32'b10111101100100001101100110000110),
      .k8(32'b10111110001001110110010100110101),
      .k9(32'b10111101110001000111010101000000)
  ) CON2D_18(
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
      .k1(32'b00111110001000001111111101000011),
      .k2(32'b10111101001110100110010100010110),
      .k3(32'b00111101101101001010101111110111),
      .k4(32'b00111110000001011001000011011111),
      .k5(32'b00111101010000101010000110010111),
      .k6(32'b00111100101000011001011001001001),
      .k7(32'b10111101110101110011011101101001),
      .k8(32'b00111110000110100011100101011110),
      .k9(32'b00111101101100110001101101001110)
  ) CON2D_19(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101101001010101011010100001),
      .k2(32'b00111110001001001100001010111011),
      .k3(32'b10111110000000101100000000101101),
      .k4(32'b00111011100111110011000100010100),
      .k5(32'b10111110001000100101011110011000),
      .k6(32'b10111101110110000001011100100100),
      .k7(32'b10111101100101011101100100111001),
      .k8(32'b00111110001100001110001001111111),
      .k9(32'b00111101101101111100110000000111)
  ) CON2D_20(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101011001010110100001101111),
      .k2(32'b00111101101010110100111110011100),
      .k3(32'b10111101101101111001110111110011),
      .k4(32'b00111101111111010101001001000110),
      .k5(32'b10111101101011101010000101010101),
      .k6(32'b00111101101000011001101001101111),
      .k7(32'b00111101001001110011101111011001),
      .k8(32'b00111100101101000101000010000000),
      .k9(32'b00111100011111010010110010001000)
  ) CON2D_21(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101011110111100100110000011),
      .k2(32'b00111101110011011110000100000110),
      .k3(32'b00111110000000110100111011100101),
      .k4(32'b00111110001000010111001001111101),
      .k5(32'b00111101000101101101010010100101),
      .k6(32'b00111100111111001000011010010111),
      .k7(32'b00111110000010010000100001111100),
      .k8(32'b00111101101111001100100101010001),
      .k9(32'b10111101000101100111101111011110)
  ) CON2D_22(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100100111100001011010100001),
      .k2(32'b00111110000011111011111100000011),
      .k3(32'b10111100010111011111110110001000),
      .k4(32'b00111100111101110101110110100001),
      .k5(32'b10111101010111100110011101001010),
      .k6(32'b00111101111001101000010001110111),
      .k7(32'b10111110000000010010111101000010),
      .k8(32'b00111101101100111110100011010110),
      .k9(32'b10111101100010101110100010110111)
  ) CON2D_23(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100111110100101100101100000),
      .k2(32'b00111101001111010110111011111100),
      .k3(32'b10111101111010101101011000011111),
      .k4(32'b10111110000111110101101000010010),
      .k5(32'b10111101110001001001101111101010),
      .k6(32'b00111110000000111111110110001111),
      .k7(32'b10111101111101001101011011011000),
      .k8(32'b00111101111100010011110011010111),
      .k9(32'b00111110000011011011110000101101)
  ) CON2D_24(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111100100010001110111000101101)
)   op3(
    .i_pipeline_layer2(i_CORE_IP1[2]), 
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
      .k1(32'b10111001111001000001001110111101),
      .k2(32'b00111110000000111001010010111101),
      .k3(32'b10111101101111000000011001110001),
      .k4(32'b00111101111101100011101110100110),
      .k5(32'b00111101111101010001100010001100),
      .k6(32'b00111110000101110101101011101010),
      .k7(32'b00111101100011101110111001110100),
      .k8(32'b10111011110100110001110001100001),
      .k9(32'b00111110000110000111110011110001)
  ) CON2D_25(
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
      .k1(32'b00111100100000011011110000101001),
      .k2(32'b00111101110110110010000110001001),
      .k3(32'b00111101000110111100101001001110),
      .k4(32'b00111101111111010010000010010111),
      .k5(32'b10111101101111100110101011111111),
      .k6(32'b00111101000111101000101000000100),
      .k7(32'b00111110000010100000101101001000),
      .k8(32'b10111101100000110110110111110100),
      .k9(32'b00111101010001000110110011000101)
  ) CON2D_26(
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
      .k1(32'b10111101010111100000110100110100),
      .k2(32'b00111101111000000100001101011010),
      .k3(32'b00111110000101101011001100010111),
      .k4(32'b00111100010011101100010101000110),
      .k5(32'b00111101100001101110110000111001),
      .k6(32'b00111101001101111010000100101000),
      .k7(32'b10111101110011000111100100110000),
      .k8(32'b00111101010101110110111101101011),
      .k9(32'b10111011100111011101010100110001)
  ) CON2D_27(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101110111010011101110001),
      .k2(32'b00111101101111101001111100101010),
      .k3(32'b10111101101011011010001110011100),
      .k4(32'b10111100111110001111111111110110),
      .k5(32'b10111101101001000110110011100111),
      .k6(32'b00111101111110110101110110100101),
      .k7(32'b10111101101000000110001011110111),
      .k8(32'b10111101111000100100111111110011),
      .k9(32'b10111101101000110001010011001111)
  ) CON2D_28(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100110000010100101111100100),
      .k2(32'b00111110000101001001111010000100),
      .k3(32'b00111110000001010010001110000000),
      .k4(32'b00111110000011111110000111111001),
      .k5(32'b00111110001000000011100001010100),
      .k6(32'b10111101000001100110110100010111),
      .k7(32'b10111110000110010110111000111101),
      .k8(32'b00111110000101000010011110011010),
      .k9(32'b10111100111000000001011010110001)
  ) CON2D_29(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101000111100100101100001),
      .k2(32'b00111101000101000101101101000101),
      .k3(32'b10111100111001111110111111011110),
      .k4(32'b00111100101011101011011111001101),
      .k5(32'b10111110000011100111110000101111),
      .k6(32'b10111101100100111010110010110111),
      .k7(32'b00111101100010000011101010000100),
      .k8(32'b10111110000011101010010011101011),
      .k9(32'b00111101111101110100001100100110)
  ) CON2D_30(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101001110101110110110100011),
      .k2(32'b00111101011100101001000011111111),
      .k3(32'b00111110000100001101101100001000),
      .k4(32'b10111101000011011001010010110110),
      .k5(32'b10111101011011111011101001110100),
      .k6(32'b00111100100010101110101101000111),
      .k7(32'b00111101110011110000000000000100),
      .k8(32'b00111101111011010011110001001101),
      .k9(32'b10111100110001111110010100111100)
  ) CON2D_31(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101011110110111001101001),
      .k2(32'b10111101100111110110100010111110),
      .k3(32'b00111110001001001010001001101100),
      .k4(32'b00111110000001011010101100111011),
      .k5(32'b00111101101110101101000010011011),
      .k6(32'b10111110000010001000111000111000),
      .k7(32'b10111110000101011000000110011000),
      .k8(32'b10111101101100101111001101110011),
      .k9(32'b10111101100001100000010100000111)
  ) CON2D_32(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111001001111011011101101011010)
)   op4(
    .i_pipeline_layer2(i_CORE_IP1[3]), 
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
      .k1(32'b00111101100000010101100101010000),
      .k2(32'b00111011001101010111010000101100),
      .k3(32'b10111100111010111100110010000010),
      .k4(32'b10111110001000101100110110101100),
      .k5(32'b00111101111110100100001011101110),
      .k6(32'b00111100110001010000101110101010),
      .k7(32'b10111101101011111111110011111100),
      .k8(32'b00111011101001000010011010011011),
      .k9(32'b00111110000110101001010010101001)
  ) CON2D_33(
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
      .k1(32'b00111101101001101010100010110101),
      .k2(32'b00111011000011110010110100010101),
      .k3(32'b00111100101101001110000100000100),
      .k4(32'b10111101001001011100111100100111),
      .k5(32'b10111110000011011010111111110011),
      .k6(32'b00111101001110011000000110110001),
      .k7(32'b10111101101100101000000110000011),
      .k8(32'b10111101011001101010001100100101),
      .k9(32'b10111101011111101000010101111000)
  ) CON2D_34(
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
      .k1(32'b10111100110110010110000111101011),
      .k2(32'b10111100100101110100010101010011),
      .k3(32'b00111101100100100110010100000111),
      .k4(32'b10111101011100010111010101110110),
      .k5(32'b10111101111011111100001111101110),
      .k6(32'b10111011010001111001100001110000),
      .k7(32'b10111110000000001001111100001110),
      .k8(32'b00111101100110110110111110000110),
      .k9(32'b00111101110001111101011101011010)
  ) CON2D_35(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000111000001001100001110),
      .k2(32'b00111110000000110110001011100111),
      .k3(32'b10111100011100001011111000010111),
      .k4(32'b00111110000011111001101011000101),
      .k5(32'b00111110001000011001001100101000),
      .k6(32'b10111101011001100111010110011111),
      .k7(32'b10111110000000011111000001000111),
      .k8(32'b00111101101110001001111100001111),
      .k9(32'b10111101000010000111101011101011)
  ) CON2D_36(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101110011101000111111011110),
      .k2(32'b10111110001000011101110011011000),
      .k3(32'b00111101010100001100101011110001),
      .k4(32'b00111101101001010101101000101011),
      .k5(32'b10111011001010011011101001111100),
      .k6(32'b00111110000100010110100010110111),
      .k7(32'b00111100111101010111111001111101),
      .k8(32'b10111101001100101111111101110001),
      .k9(32'b00111110000000010000111010110111)
  ) CON2D_37(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101111011011101110100110100),
      .k2(32'b00111110000100101101010011110010),
      .k3(32'b00111101111111100111001011101001),
      .k4(32'b00111101110011011111001100101000),
      .k5(32'b00111100100001110100001110111111),
      .k6(32'b10111100001000000100101010011111),
      .k7(32'b00111100000011111100001111001111),
      .k8(32'b10111101110101011011001001111001),
      .k9(32'b10111101100100111101010101111011)
  ) CON2D_38(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101101111010001111101110110),
      .k2(32'b10111110000111000011100101010001),
      .k3(32'b00111101100010000011111011111110),
      .k4(32'b00111110000001010001110000010010),
      .k5(32'b00111101011101101110001011010010),
      .k6(32'b10111110000001111000010000001101),
      .k7(32'b00111110001010010111010010101001),
      .k8(32'b00111101111000110011010011011101),
      .k9(32'b00111110001010101000111110100100)
  ) CON2D_39(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101101000011100100111111000),
      .k2(32'b10111101101101111111000110010011),
      .k3(32'b10111110000000110111111000111100),
      .k4(32'b00111101101001011100011000110110),
      .k5(32'b10111100000101110111001110011100),
      .k6(32'b00111011010110110110101110000100),
      .k7(32'b00111101011001010100000111011100),
      .k8(32'b00111101111101110001001000110011),
      .k9(32'b10111100100111101111000001101110)
  ) CON2D_40(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111100000001110100100000000000)
)   op5(
    .i_pipeline_layer2(i_CORE_IP1[4]), 
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
      .k1(32'b00111101000101000001111000011101),
      .k2(32'b10111011110011000011001100111001),
      .k3(32'b00111101101111101001111101100000),
      .k4(32'b10111101110001001001101110001100),
      .k5(32'b10111101111110001011001111000101),
      .k6(32'b10111100101111111011100101010100),
      .k7(32'b00111101111011010011010011111011),
      .k8(32'b00111110000111011101110110001010),
      .k9(32'b10111101100011011110010000001101)
  ) CON2D_41(
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
      .k1(32'b10111101110001101011011000010001),
      .k2(32'b10111101101101101000010000000011),
      .k3(32'b00111110001010101111111101111101),
      .k4(32'b00111101110010101000100011010100),
      .k5(32'b10111011010001011000010001111001),
      .k6(32'b10111100000011001110111010000110),
      .k7(32'b10111110000100000110101000111001),
      .k8(32'b00111100001011101000111000111001),
      .k9(32'b10111110000111110000001000001011)
  ) CON2D_42(
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
      .k1(32'b00111100110010111110001010001110),
      .k2(32'b10111101111110000110100010100011),
      .k3(32'b00111101110101100101110101001110),
      .k4(32'b00111100110111000001111000011101),
      .k5(32'b10111100110101110000100001000100),
      .k6(32'b10111101010110011101101111001110),
      .k7(32'b10111101111000011101110001001110),
      .k8(32'b00111110000110001111000010100000),
      .k9(32'b10111101111110100011001111111111)
  ) CON2D_43(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100010101010111010010111111),
      .k2(32'b00111110000101000101000011011000),
      .k3(32'b10111110000001101000110000110001),
      .k4(32'b00111101001010110101100000101000),
      .k5(32'b00111101110110011101010101111011),
      .k6(32'b10111101110010100010001100010010),
      .k7(32'b10111101010101011001101000100111),
      .k8(32'b10111110000001101100010111010010),
      .k9(32'b10111010011011001101110100100010)
  ) CON2D_44(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101110000101101101101010101),
      .k2(32'b10111101111110011011100010010100),
      .k3(32'b00111101110010001100100111010100),
      .k4(32'b00111110000000100011000010111000),
      .k5(32'b00111101100100100001001010110011),
      .k6(32'b10111110000001101110000111010010),
      .k7(32'b10111101011110110100110110000000),
      .k8(32'b00111100011011001000011011011010),
      .k9(32'b10111101111111110001101011001011)
  ) CON2D_45(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101011101110100011101100000),
      .k2(32'b00111110000110011110000000101110),
      .k3(32'b10111100001000011101100001111010),
      .k4(32'b10111101000100010110001011001000),
      .k5(32'b10111101011101010011101011101100),
      .k6(32'b00111101101000011000101111101110),
      .k7(32'b10111101001001001100110010100001),
      .k8(32'b00111101001000001101001000001010),
      .k9(32'b10111101001110110010101001100011)
  ) CON2D_46(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111011111001111110111100001011),
      .k2(32'b00111110000111101000010000010111),
      .k3(32'b00111110000110111110100100001110),
      .k4(32'b00111101111000000000111110011100),
      .k5(32'b00111110000000010001110100001001),
      .k6(32'b10111101111011001000001101000100),
      .k7(32'b00111110000110100111011101101011),
      .k8(32'b00111101110100001010110011100001),
      .k9(32'b00111100101001101110000110100110)
  ) CON2D_47(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000011101000110001011100),
      .k2(32'b10111110000100110100010000010001),
      .k3(32'b10111101110111011110000011000101),
      .k4(32'b10111101100100100100110100001010),
      .k5(32'b10111101111110100100110110001100),
      .k6(32'b10111101100100101111100001101110),
      .k7(32'b00111101110000110110100100111101),
      .k8(32'b10111101100110011101110110100100),
      .k9(32'b10111110000000000010011011101100)
  ) CON2D_48(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111100101000100000101101001101)
)   op6(
    .i_pipeline_layer2(i_CORE_IP1[5]), 
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
      .k1(32'b10111101011100000011000110101110),
      .k2(32'b00111100011101011011011111110100),
      .k3(32'b10111100101011000100101010111001),
      .k4(32'b00111110001011101110000100000011),
      .k5(32'b00111101001011101110000110111100),
      .k6(32'b00111101101011111100010101000100),
      .k7(32'b00111110001101000100010111001010),
      .k8(32'b00111101011001100110001101110111),
      .k9(32'b00111110000001010101101000100111)
  ) CON2D_49(
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
      .k1(32'b10111110000010100101010100100001),
      .k2(32'b00111101111111110100101100111011),
      .k3(32'b10111101110101111111100101001000),
      .k4(32'b10111100101010001001011010001101),
      .k5(32'b00111100100110111100100101110000),
      .k6(32'b10111101000010010100000010110000),
      .k7(32'b10111110000010110010010100101100),
      .k8(32'b10111011111110001101110001101001),
      .k9(32'b10111101101001011000111000010111)
  ) CON2D_50(
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
      .k1(32'b00111101001111001011010100000101),
      .k2(32'b10111011111110001000010111100000),
      .k3(32'b10111101100000100000010010011001),
      .k4(32'b10111011110110010001111011111101),
      .k5(32'b10111110000110000011110000000111),
      .k6(32'b00111101111000101011110111010010),
      .k7(32'b10111100110001001101101100110100),
      .k8(32'b00111101101000001100110111100101),
      .k9(32'b10111110000111100100000101001011)
  ) CON2D_51(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101000101110010111001010011),
      .k2(32'b10111110000000000011010101100000),
      .k3(32'b10111101101111110100000011100111),
      .k4(32'b10111100110100011011010110001011),
      .k5(32'b00111101101101010101111111100010),
      .k6(32'b10111100001101110101010010001111),
      .k7(32'b10111101010100000001111110101101),
      .k8(32'b00111110000101100011011100001101),
      .k9(32'b00111100110010001101100101010010)
  ) CON2D_52(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100111010001111011011100111),
      .k2(32'b10111110000101100100111010110001),
      .k3(32'b10111101111010110001111101100100),
      .k4(32'b10111101100010001101101011111000),
      .k5(32'b10111101110000001011111001101011),
      .k6(32'b00111101111011111001010110111010),
      .k7(32'b00111101101011000010010011001110),
      .k8(32'b00111101110000000101110001001111),
      .k9(32'b10111110001011011100010111110110)
  ) CON2D_53(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101111011000011000001001111),
      .k2(32'b10111110000011111001010010000111),
      .k3(32'b00111110001010001101001101010100),
      .k4(32'b00111101001000010100110111011011),
      .k5(32'b00111110000101100010001101001100),
      .k6(32'b00111101000111110001000010100101),
      .k7(32'b00111101001101011000001000000001),
      .k8(32'b10111101101000100001111010010000),
      .k9(32'b10111101100101101111100000111011)
  ) CON2D_54(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110001000000000011100001010),
      .k2(32'b00111101101110111000100110100101),
      .k3(32'b10111101111011011100010000000100),
      .k4(32'b00111011110100111101110101001001),
      .k5(32'b10111110000001000010110011001111),
      .k6(32'b10111101100101011101000001101000),
      .k7(32'b10111100100110100111101011100011),
      .k8(32'b00111100110100111100011100000100),
      .k9(32'b10111100101101100110111110111011)
  ) CON2D_55(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100110001100110111001101111),
      .k2(32'b10111110000101000111111100100001),
      .k3(32'b10111101101011110111111101010000),
      .k4(32'b00111110000010011001100111101011),
      .k5(32'b10111101100101011111011001101100),
      .k6(32'b00111101100100110110100011011101),
      .k7(32'b10111101001111001111010111010110),
      .k8(32'b00111100001100101101110001001000),
      .k9(32'b10111110000001001001111100010000)
  ) CON2D_56(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111100010110010000011001000100)
)   op7(
    .i_pipeline_layer2(i_CORE_IP1[6]), 
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
      .k1(32'b10111101111101010110111011000010),
      .k2(32'b00111100000001101111110001001000),
      .k3(32'b00111101101010101010010011110010),
      .k4(32'b10111110000011100001100001111000),
      .k5(32'b10111100111010010010100000100110),
      .k6(32'b00111101000111010110110101100001),
      .k7(32'b10111101000110000011001011011010),
      .k8(32'b00111101100001101000001100100001),
      .k9(32'b10111101111000111001000100000001)
  ) CON2D_57(
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
      .k1(32'b00111110001001111111011011011011),
      .k2(32'b00111110000011011101101111110110),
      .k3(32'b10111100000101111000000110101100),
      .k4(32'b10111101111011001110000011001110),
      .k5(32'b10111101000000001011111010101011),
      .k6(32'b10111100111000011100011110100001),
      .k7(32'b00111101000110101010011001100101),
      .k8(32'b00111100000101110010000010111001),
      .k9(32'b00111110001000001001100101101011)
  ) CON2D_58(
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
      .k1(32'b10111101101100001111000110010111),
      .k2(32'b10111101101100010001000101101010),
      .k3(32'b00111100101100101100001001011110),
      .k4(32'b10111110000111011110110111000010),
      .k5(32'b00111110001010101101100101101000),
      .k6(32'b00111101110001111001001010100101),
      .k7(32'b00111101110010101101000000110100),
      .k8(32'b00111011101011000000110010000111),
      .k9(32'b00111110001010100100001001001110)
  ) CON2D_59(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111011000011011110000000000010),
      .k2(32'b10111110001010110011011100010010),
      .k3(32'b00111101111000000101011111010100),
      .k4(32'b10111110000000011100000110011100),
      .k5(32'b10111100101111000000110101111011),
      .k6(32'b10111101111111110100001000010010),
      .k7(32'b10111110000011100110111011100011),
      .k8(32'b00111110000011001010111111110000),
      .k9(32'b00111101010010000010111010110011)
  ) CON2D_60(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101010110010000011111111101),
      .k2(32'b00111101111011011100101010001010),
      .k3(32'b00111110001100100000110111111010),
      .k4(32'b00111101101010011100001110110000),
      .k5(32'b00111110001011111011111010101100),
      .k6(32'b10111101011011110110001101100010),
      .k7(32'b00111100110001000101101000000010),
      .k8(32'b10111110001000000000110000100010),
      .k9(32'b00111101101111101011001000001100)
  ) CON2D_61(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101011100100111110111100),
      .k2(32'b00111101010100011110000110110101),
      .k3(32'b00111101000101010100110011111010),
      .k4(32'b00111101111100100010101101000111),
      .k5(32'b00111100010011001001000110111000),
      .k6(32'b00111110000010110110001110011101),
      .k7(32'b10111110001010100100000001011110),
      .k8(32'b00111101101000111100001000100100),
      .k9(32'b10111101110000111001010100001111)
  ) CON2D_62(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101000100101101111111110111),
      .k2(32'b10111101101010110010001111101001),
      .k3(32'b00111101110000111100010011001000),
      .k4(32'b10111110000111101001101111100001),
      .k5(32'b10111101100011110010110010110110),
      .k6(32'b00111101110001101111101101111111),
      .k7(32'b10111101110110100000011000110110),
      .k8(32'b10111110000111001011111101000011),
      .k9(32'b10111101101000100011100110011111)
  ) CON2D_63(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111011110000110001110011011001),
      .k2(32'b10111101101110000100000001000011),
      .k3(32'b10111101110000100000110001111110),
      .k4(32'b00111110001011000111010001100000),
      .k5(32'b10111100011101111101111001101011),
      .k6(32'b00111101000001011011101100101000),
      .k7(32'b10111101111000001110100111010110),
      .k8(32'b00111100010101111000101100001101),
      .k9(32'b10111110000101101010010000011111)
  ) CON2D_64(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111011101110000110010010011000)
)   op8(
    .i_pipeline_layer2(i_CORE_IP1[7]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*8-1:DATA_WIDTH*7])
);

/// CON2D_9///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111010011001101100111001100010),
      .k2(32'b10111101100000010010100101000000),
      .k3(32'b10111101001110011011010111110000),
      .k4(32'b10111110001000101100100111110010),
      .k5(32'b10111101001110111001001000000010),
      .k6(32'b00111101000100011101011011010010),
      .k7(32'b00111101100110110011000101111011),
      .k8(32'b10111101110001100001010001000101),
      .k9(32'b10111101101011110101110011001000)
  ) CON2D_65(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101000011111011000001110100),
      .k2(32'b10111101101000011000110111111101),
      .k3(32'b10111101101101000001110101100110),
      .k4(32'b00111110000110000001010000000111),
      .k5(32'b00111101100110010001110110000110),
      .k6(32'b10111110000000111111011110001111),
      .k7(32'b00111110000111101001111010111001),
      .k8(32'b00111110001011000000111101011100),
      .k9(32'b10111101100001101000111100100100)
  ) CON2D_66(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101011100011101000101110110),
      .k2(32'b00111101001000111111000101110110),
      .k3(32'b10111101011001101001010111001000),
      .k4(32'b00111100001101111111000110110101),
      .k5(32'b10111101101100110100101111110110),
      .k6(32'b00111101110011100110101001011001),
      .k7(32'b00111101100001000010000101110010),
      .k8(32'b00111101110110111001010010010111),
      .k9(32'b00111100100001100010011000010100)
  ) CON2D_67(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100100101110010110111011011),
      .k2(32'b10111101100011001100001111010011),
      .k3(32'b10111110001011011110011010100100),
      .k4(32'b10111101100111010110111100010001),
      .k5(32'b10111110000100110111000111110011),
      .k6(32'b00111101000010000111111111011101),
      .k7(32'b00111101001001011101010001011101),
      .k8(32'b10111101001101100011101101001011),
      .k9(32'b10111100100101010111110001111010)
  ) CON2D_68(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101001000101100001110011000),
      .k2(32'b10111101111001000100001111000001),
      .k3(32'b10111101100011010110001110101110),
      .k4(32'b00111100111101100000001110101101),
      .k5(32'b10111011111111001011010011001101),
      .k6(32'b00111101100101101110010010100101),
      .k7(32'b00111101011001101110110101101101),
      .k8(32'b00111110000001000011000001011100),
      .k9(32'b00111110001011101011001011101100)
  ) CON2D_69(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101100001011110001010100110),
      .k2(32'b10111110000110110101110110001111),
      .k3(32'b00111100001010111001101010000000),
      .k4(32'b00111101111100011011101110111000),
      .k5(32'b00111101111011010000011101111101),
      .k6(32'b10111101100111011010011101101100),
      .k7(32'b00111101010111110111100000100101),
      .k8(32'b10111101110110100110110101101100),
      .k9(32'b00111101010111110011101001111111)
  ) CON2D_70(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101110010111000010010110101),
      .k2(32'b10111101001011000010001111111001),
      .k3(32'b10111110000111110000010011110101),
      .k4(32'b10111101011100101010111111000010),
      .k5(32'b00111101111000000100000100110101),
      .k6(32'b00111100100111101100010001111011),
      .k7(32'b00111101110011001100001111000011),
      .k8(32'b00111101101010111100011010100011),
      .k9(32'b00111011001000000010101100010101)
  ) CON2D_71(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101110010100101110010111),
      .k2(32'b10111101111010111111010011010111),
      .k3(32'b10111101101001111101001110101000),
      .k4(32'b10111110000101111010110110110101),
      .k5(32'b00111101100100100010000111001101),
      .k6(32'b00111101001111101001000100010001),
      .k7(32'b00111110001000111001000100011011),
      .k8(32'b00111101111011100000100010000101),
      .k9(32'b10111110001000000000111111001000)
  ) CON2D_72(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111011011101111010100100101000)
)   op9(
    .i_pipeline_layer2(i_CORE_IP1[8]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*9-1:DATA_WIDTH*8])
);

/// CON2D_10///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101110111110011011000111100),
      .k2(32'b00111100100101110001010101111000),
      .k3(32'b10111101100110100011011110001010),
      .k4(32'b00111110000011100011110100110110),
      .k5(32'b10111101111011101001101000111001),
      .k6(32'b10111101110000011011111101000000),
      .k7(32'b00111110000010011000100111110101),
      .k8(32'b00111110001100001101000010000001),
      .k9(32'b00111110000101011001011000001110)
  ) CON2D_73(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100010011101101000000110101),
      .k2(32'b00111110001011011100100011101110),
      .k3(32'b10111101101000011100011010000111),
      .k4(32'b00111110000101100101011101100011),
      .k5(32'b00111101011011100001010111111100),
      .k6(32'b00111110000111011100100110010110),
      .k7(32'b00111101000001010100100110111000),
      .k8(32'b10111101101011001110100001110100),
      .k9(32'b00111101000000000101001110000110)
  ) CON2D_74(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111011101000110100001000000010),
      .k2(32'b10111101000101110001110101100000),
      .k3(32'b00111101101100000100000011101000),
      .k4(32'b10111101110011010110001000100101),
      .k5(32'b00111101001001001011111101011000),
      .k6(32'b10111101001110101101010001010101),
      .k7(32'b10111101101010010110111010101011),
      .k8(32'b10111101111110011001001110010101),
      .k9(32'b10111101000110011000000111110011)
  ) CON2D_75(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000101101101001000100111),
      .k2(32'b00111101101000001111100101100000),
      .k3(32'b10111010110110011011111101010010),
      .k4(32'b00111100001000011110100110011111),
      .k5(32'b00111101100011100101010110010101),
      .k6(32'b00111110000100100100000000010001),
      .k7(32'b10111100111000010100110110011000),
      .k8(32'b10111101110111111010111111010010),
      .k9(32'b00111101100101101100011011010100)
  ) CON2D_76(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000100100010111011111100),
      .k2(32'b00111100100110110011111010010100),
      .k3(32'b10111100011010110000001100010010),
      .k4(32'b10111101101001011100010010110100),
      .k5(32'b10111101101001101100101010111111),
      .k6(32'b00111101101111000001010111111101),
      .k7(32'b00111101110100011011000111100100),
      .k8(32'b10111101110011100000000110101101),
      .k9(32'b00111101101011100110110100000101)
  ) CON2D_77(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101001101100010000000101101),
      .k2(32'b10111101111110010101101000111111),
      .k3(32'b00111101101111101011110010110011),
      .k4(32'b00111101110001101101011111110000),
      .k5(32'b00111100101111011111011011001111),
      .k6(32'b10111100101000000001111010000000),
      .k7(32'b10111101100000001001001101001111),
      .k8(32'b10111101011101110011111000111111),
      .k9(32'b00111101010101001111101011000000)
  ) CON2D_78(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000011100000000000101101),
      .k2(32'b10111101111011000101110001101011),
      .k3(32'b00111101101000011111111011101111),
      .k4(32'b10111110000001110101100100100010),
      .k5(32'b10111110000101001010000101000111),
      .k6(32'b00111101101101100100101010010110),
      .k7(32'b10111101111011000110000110000101),
      .k8(32'b00111101111001011111111110111000),
      .k9(32'b00111110000000110011001000111011)
  ) CON2D_79(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110001000101100000101010101),
      .k2(32'b00111101010100101000100011001010),
      .k3(32'b00111101111000001001011100000100),
      .k4(32'b10111101101111101110000000010111),
      .k5(32'b10111101111000111011000001100011),
      .k6(32'b00111101111110001000000111000001),
      .k7(32'b00111110000101001001000100110000),
      .k8(32'b00111101100011110001100101101111),
      .k9(32'b10111110000100000110000000110001)
  ) CON2D_80(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111100010001110010110000011010)
)   op10(
    .i_pipeline_layer2(i_CORE_IP1[9]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*10-1:DATA_WIDTH*9])
);

/// CON2D_11///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101000010000011011110111111),
      .k2(32'b10111101111101100010101100001100),
      .k3(32'b00111101110001001111100001001011),
      .k4(32'b10111101101111110101011011101011),
      .k5(32'b10111110000110000010010100101100),
      .k6(32'b10111110000100000000101011100011),
      .k7(32'b00111101000101001111110101100111),
      .k8(32'b00111101111011000110101001001100),
      .k9(32'b10111101000001011010100001110101)
  ) CON2D_81(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101100100001110100010010111),
      .k2(32'b00111011100011011110011101011010),
      .k3(32'b00111011001001001101111011110101),
      .k4(32'b00111101100010011111001110101001),
      .k5(32'b00111110000000111101101101010110),
      .k6(32'b10111100101001001000011110111100),
      .k7(32'b00111110000000011001101101100110),
      .k8(32'b00111110000010110010001101100110),
      .k9(32'b10111101110000111011001000011101)
  ) CON2D_82(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101001011010111100110111101),
      .k2(32'b00111101111010100101100011111111),
      .k3(32'b10111101111101010110011100111001),
      .k4(32'b10111101110100011101110101011101),
      .k5(32'b10111101110111111011010010101001),
      .k6(32'b10111110001000011101111101110000),
      .k7(32'b00111110000111000101110011010010),
      .k8(32'b00111100000001010110111100110101),
      .k9(32'b10111110000011000001111011010010)
  ) CON2D_83(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101100110100110101001111),
      .k2(32'b00111101111011001111011001111111),
      .k3(32'b10111110000100010110101001001011),
      .k4(32'b00111101100101100001111010111100),
      .k5(32'b10111101100001011111111101010111),
      .k6(32'b00111101101110010100101100001010),
      .k7(32'b10111100001111010110110110101001),
      .k8(32'b10111101110110010011111001111110),
      .k9(32'b10111101100011110010111101011111)
  ) CON2D_84(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101011101101101111110000111),
      .k2(32'b10111100011101110100101101100111),
      .k3(32'b00111101010010100010101111010101),
      .k4(32'b10111110000011000010010001010011),
      .k5(32'b00111101101100001110100111110101),
      .k6(32'b10111110001001000110110111011110),
      .k7(32'b00111110000101100010101111010001),
      .k8(32'b10111101100111010010101111101101),
      .k9(32'b10111110001010010010101111110000)
  ) CON2D_85(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111011110010100011101100000010),
      .k2(32'b10111110000111111111101100101101),
      .k3(32'b10111101100000000101101010110111),
      .k4(32'b00111101111110000000101110111101),
      .k5(32'b00111101011110001100000100000011),
      .k6(32'b10111110001001110111101010001001),
      .k7(32'b00111101101001001101110101110101),
      .k8(32'b00111101101000010000100001100101),
      .k9(32'b00111100100010001110101001111010)
  ) CON2D_86(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101001110101101110100111111),
      .k2(32'b10111100010111010101000110010111),
      .k3(32'b10111101100000001000110011000001),
      .k4(32'b00111110000001011001110011101010),
      .k5(32'b00111110000011101101011010100110),
      .k6(32'b10111101011101011000110000001001),
      .k7(32'b00111110000111101000000110001011),
      .k8(32'b10111100010100100001000110110110),
      .k9(32'b00111110000000100111101111110101)
  ) CON2D_87(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100111011100000101110011100),
      .k2(32'b10111110000101110000100101010100),
      .k3(32'b10111101010010011100111100110101),
      .k4(32'b00111101100100001001001001011001),
      .k5(32'b10111110000000101010111101011110),
      .k6(32'b10111101000110111101010101011001),
      .k7(32'b10111011111111011001100010010000),
      .k8(32'b00111101110100000001101000010110),
      .k9(32'b00111101011101010110100001011010)
  ) CON2D_88(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111010001100000010011110000011)
)   op11(
    .i_pipeline_layer2(i_CORE_IP1[10]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*11-1:DATA_WIDTH*10])
);

/// CON2D_12///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110001001100100001010001011),
      .k2(32'b10111101110011110100110011101010),
      .k3(32'b00111100110011001010110101001001),
      .k4(32'b00111101100011110000011111000010),
      .k5(32'b10111101011100101110011011011111),
      .k6(32'b00111101010110000101100111110110),
      .k7(32'b00111110000000100100110101110111),
      .k8(32'b10111101111001000110001000010010),
      .k9(32'b10111101100101011011000100000010)
  ) CON2D_89(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000011101110001100001011),
      .k2(32'b00111110000111100100100010010100),
      .k3(32'b00111100000001001001101011000101),
      .k4(32'b10111100010010110000001011101110),
      .k5(32'b10111100010100000111101000110011),
      .k6(32'b10111011100110100010001010011000),
      .k7(32'b00111101110000110011010010110000),
      .k8(32'b10111101100110000011110101111110),
      .k9(32'b00111101011111110001101110010110)
  ) CON2D_90(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101110110100001110011100101),
      .k2(32'b10111110000111000101001111000111),
      .k3(32'b10111101000011010110111100000000),
      .k4(32'b10111101111011110101010010010100),
      .k5(32'b10111110000101001000010100000000),
      .k6(32'b10111101001101111001010110100011),
      .k7(32'b10111101100110000111000000001000),
      .k8(32'b10111101110011000100110101101110),
      .k9(32'b00111110001000010100001011111111)
  ) CON2D_91(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101101110111101001001100000),
      .k2(32'b00111100011111001100101000110001),
      .k3(32'b00111100110001010101000100001110),
      .k4(32'b10111101011111100011000111110000),
      .k5(32'b00111101111101100011010000001010),
      .k6(32'b10111101010111111101100111101111),
      .k7(32'b10111110000010001111110111110111),
      .k8(32'b00111101111110110001010100001110),
      .k9(32'b10111100010001001100010010000111)
  ) CON2D_92(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101110110100011000010110101),
      .k2(32'b00111101100001010001101000100000),
      .k3(32'b00111110000001101111100010111110),
      .k4(32'b10111101000010100111111101000100),
      .k5(32'b00111110001001100001001100010110),
      .k6(32'b10111110000010011111101111101000),
      .k7(32'b00111001001100111110011000001001),
      .k8(32'b00111110000011100111000010000101),
      .k9(32'b00111101111101101011000100101000)
  ) CON2D_93(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100110001010111101100100110),
      .k2(32'b00111110000000000110111001000000),
      .k3(32'b10111101010101111111101100101001),
      .k4(32'b10111101110110000001010011010000),
      .k5(32'b10111101111010101101001101000100),
      .k6(32'b10111110000010110110000100001000),
      .k7(32'b00111110001011011101000111111110),
      .k8(32'b10111011010010101011010010000111),
      .k9(32'b00111101100001000001101001111100)
  ) CON2D_94(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000011100000110111000011),
      .k2(32'b10111101010110010111110110110100),
      .k3(32'b10111101100111111011010010011101),
      .k4(32'b00111101110101101001010110111001),
      .k5(32'b10111101110110110110001101110010),
      .k6(32'b10111100111001000011100110010101),
      .k7(32'b10111110001000111101000110011001),
      .k8(32'b00111110000110101100001101111100),
      .k9(32'b10111110001000001101101101110100)
  ) CON2D_95(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101110010111000101000000111),
      .k2(32'b00111101111110111100011110110110),
      .k3(32'b10111101110101101110110110011010),
      .k4(32'b10111101000001010010011100000011),
      .k5(32'b00111110000011011101011100110110),
      .k6(32'b10111101100110100100100011101011),
      .k7(32'b00111101101110001001011100110111),
      .k8(32'b10111101100110100010010001010100),
      .k9(32'b00111110000001110101001011101101)
  ) CON2D_96(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111011011100011010101010110010)
)   op12(
    .i_pipeline_layer2(i_CORE_IP1[11]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*12-1:DATA_WIDTH*11])
);

/// CON2D_13///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101100000101110010011110110),
      .k2(32'b10111110001101001100100010010001),
      .k3(32'b00111100110000011010100011110111),
      .k4(32'b10111101010111010110101101000001),
      .k5(32'b10111011111001001000010100100011),
      .k6(32'b00111101101101010110010000001000),
      .k7(32'b00111101010110011100111110101001),
      .k8(32'b10111101100000110101100011110000),
      .k9(32'b00111101110010100100101110011101)
  ) CON2D_97(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101011001010110011011000110),
      .k2(32'b00111101100001100010110101111110),
      .k3(32'b10111110000110111011001111000011),
      .k4(32'b10111100110110110101001001111000),
      .k5(32'b10111101010100010101010101010000),
      .k6(32'b00111101110011110011010111111110),
      .k7(32'b00111101110111001101001011000000),
      .k8(32'b00111110000011000001000001011010),
      .k9(32'b00111101110101100111001010100110)
  ) CON2D_98(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000101110000101111001111),
      .k2(32'b10111101010111111101101000111001),
      .k3(32'b10111101111100100101000101001100),
      .k4(32'b00111011001011111110001001001100),
      .k5(32'b00111011010000011100001011111011),
      .k6(32'b10111101111100010111101100000010),
      .k7(32'b10111110000101111101111111000000),
      .k8(32'b00111101101111011000000000110010),
      .k9(32'b00111110001000111110011010010011)
  ) CON2D_99(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110001000000010101110101010),
      .k2(32'b10111101100101110000010111100101),
      .k3(32'b00111101101010000110000100011011),
      .k4(32'b00111101100101011100100010000101),
      .k5(32'b10111101011000111010010100110011),
      .k6(32'b00111101010101001111000010000011),
      .k7(32'b10111101011001001110000100001000),
      .k8(32'b10111100111011110101001110100011),
      .k9(32'b00111101110011010010000111110000)
  ) CON2D_100(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101110010010000101100011111),
      .k2(32'b10111110000001000011101010100111),
      .k3(32'b10111110000011000111110101111010),
      .k4(32'b00111100000001000010100110111011),
      .k5(32'b00111101101010010011010101001100),
      .k6(32'b00111100100110001100000010110010),
      .k7(32'b00111101100001110001101110100100),
      .k8(32'b00111101010100011110010010100000),
      .k9(32'b00111110000000111111011011110111)
  ) CON2D_101(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000101001001010111011100),
      .k2(32'b00111101111011101100100001001000),
      .k3(32'b00111101101101101111011101001000),
      .k4(32'b00111100010111001111001011010110),
      .k5(32'b00111011111000000101000100011011),
      .k6(32'b00111101000010010011011111000001),
      .k7(32'b00111101110011111001110000001001),
      .k8(32'b10111110000101111100111001001111),
      .k9(32'b00111101100100111001011011011010)
  ) CON2D_102(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100101001011011100011111100),
      .k2(32'b10111110000101010110000100010111),
      .k3(32'b10111101111000111111111010001100),
      .k4(32'b00111101001101000111011110000000),
      .k5(32'b00111101111011101110111111000000),
      .k6(32'b00111101000001100000101011101110),
      .k7(32'b10111110000000011011000100101011),
      .k8(32'b00111101111101100110101101000000),
      .k9(32'b10111101100000100111110011011011)
  ) CON2D_103(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101110101000111001000111111),
      .k2(32'b00111100001100100010111011000001),
      .k3(32'b00111110000001001001100100010111),
      .k4(32'b10111110000110101000011001011001),
      .k5(32'b10111100001100011010010110100001),
      .k6(32'b10111100111000101011001111010010),
      .k7(32'b10111100010101001101111110000100),
      .k8(32'b00111100001001011100001111111111),
      .k9(32'b00111101100101000010011000100101)
  ) CON2D_104(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111011010011101011011110010100)
)   op13(
    .i_pipeline_layer2(i_CORE_IP1[12]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*13-1:DATA_WIDTH*12])
);

/// CON2D_14///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111000111101010001111010),
      .k2(32'b10111100101111101111001110101010),
      .k3(32'b00111110000101001100100100001010),
      .k4(32'b10111100010001100000010001010001),
      .k5(32'b00111101011011010111110110011000),
      .k6(32'b10111110000011000100011110000000),
      .k7(32'b00111100011001111110011001111001),
      .k8(32'b00111101100110011100111010000011),
      .k9(32'b00111101110000100110010000100010)
  ) CON2D_105(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101110110110100001010100100),
      .k2(32'b10111100000001100110011011111001),
      .k3(32'b10111110000101110011111111001101),
      .k4(32'b10111011001110100010011010001000),
      .k5(32'b00111101111111100011010110101110),
      .k6(32'b10111101011011111001100110011111),
      .k7(32'b00111100100010101110100010010000),
      .k8(32'b10111100000000001101111111010100),
      .k9(32'b00111101001111100010011000111000)
  ) CON2D_106(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110001010111011001111000100),
      .k2(32'b00111110000100111101001011111011),
      .k3(32'b00111101101101101101010001111001),
      .k4(32'b10111101101110010011100010110000),
      .k5(32'b00111101100101100100111101010111),
      .k6(32'b00111101101101001011001010110100),
      .k7(32'b10111110000110111011100000011100),
      .k8(32'b10111101011010111001000111110000),
      .k9(32'b00111110001000111111111110101101)
  ) CON2D_107(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110001010010110000100000011),
      .k2(32'b00111101110010101111011011111010),
      .k3(32'b10111100001111000010001111101001),
      .k4(32'b10111101100111110011000100000111),
      .k5(32'b10111101110101001001010011001110),
      .k6(32'b00111100011010000111110000010110),
      .k7(32'b10111110001000011110011010000111),
      .k8(32'b10111101101110001100010000010000),
      .k9(32'b00111100100000001001111111011101)
  ) CON2D_108(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000011100111010001000001),
      .k2(32'b10111110000010101100001011010111),
      .k3(32'b00111101111110110111100000100111),
      .k4(32'b10111100110100111111000100010100),
      .k5(32'b00111110000011001000100111110000),
      .k6(32'b00111110001001111010010110001010),
      .k7(32'b10111101001001110100000010011100),
      .k8(32'b10111101011010001000010111110101),
      .k9(32'b00111101101110000101000101000111)
  ) CON2D_109(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000100011011101110000001),
      .k2(32'b00111110001001101011111010010000),
      .k3(32'b10111101101010110011100011100111),
      .k4(32'b00111110000100011100110000100001),
      .k5(32'b00111101010111100010111110101100),
      .k6(32'b10111101101001001101100010100110),
      .k7(32'b00111101101110111100100110001101),
      .k8(32'b10111110000100010101110000000111),
      .k9(32'b00111101001100001110010011000000)
  ) CON2D_110(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101010110000001111011111010),
      .k2(32'b10111101011000111111101000111111),
      .k3(32'b00111101111101000100101101100100),
      .k4(32'b10111101101000000111110001001100),
      .k5(32'b00111101110010100110110001101110),
      .k6(32'b00111101111110000000000001000101),
      .k7(32'b10111100110000010010111101101010),
      .k8(32'b00111101101101010100100111001101),
      .k9(32'b00111101110101111101110010101100)
  ) CON2D_111(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101100100011001010110101010),
      .k2(32'b00111101100001000011110110100001),
      .k3(32'b10111101100000010010100000010110),
      .k4(32'b10111110000010011010011110101011),
      .k5(32'b10111100101001001110011101101101),
      .k6(32'b00111110000111111101111010010100),
      .k7(32'b10111101110000011010110110100101),
      .k8(32'b00111110000011010000110101100001),
      .k9(32'b00111101011110001010010101101011)
  ) CON2D_112(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111011101110101111011110001100)
)   op14(
    .i_pipeline_layer2(i_CORE_IP1[13]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*14-1:DATA_WIDTH*13])
);

/// CON2D_15///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100101110010111010101001000),
      .k2(32'b10111101100011111110010101011001),
      .k3(32'b00111101100111010110111001100001),
      .k4(32'b00111101010010111010111010010100),
      .k5(32'b00111101111101000011010110101101),
      .k6(32'b00111011101101010001010110011000),
      .k7(32'b10111101001000001100110100010000),
      .k8(32'b00111110000011100011010001010111),
      .k9(32'b10111101101000010010110100101010)
  ) CON2D_113(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100100001101101100011100111),
      .k2(32'b00111110000001001110011011100110),
      .k3(32'b10111110001000101101110100110100),
      .k4(32'b10111101111111001010110110110110),
      .k5(32'b00111101111110001111001000101011),
      .k6(32'b10111101011000011011100000011110),
      .k7(32'b00111110000010011010001111011010),
      .k8(32'b00111101001010010110111100000010),
      .k9(32'b00111110000000000110101010111110)
  ) CON2D_114(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000110101001000001101000),
      .k2(32'b10111010110100000111001011101101),
      .k3(32'b10111101011100001110011100001001),
      .k4(32'b00111101000000010000111000010110),
      .k5(32'b10111110000110010010000011001100),
      .k6(32'b10111101110100010001001000011000),
      .k7(32'b00111110000010010100101111100100),
      .k8(32'b10111101010100011001001000010010),
      .k9(32'b00111110000100011100010011111111)
  ) CON2D_115(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101111101000110101001011110),
      .k2(32'b10111101110001111001001111000101),
      .k3(32'b00111110000000100111011000001010),
      .k4(32'b10111101111110100000011001101000),
      .k5(32'b10111110000001010011010100001011),
      .k6(32'b10111100111100110001101101101001),
      .k7(32'b10111110001001111111101110111000),
      .k8(32'b00111101111001100001010010011000),
      .k9(32'b00111101101000101111000110000110)
  ) CON2D_116(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101010101100011010100011),
      .k2(32'b00111100100001001101010000000111),
      .k3(32'b00111101101100110001010000001101),
      .k4(32'b00111101110001110001000010001001),
      .k5(32'b10111110001000010110000001111111),
      .k6(32'b00111110000111111101010001101111),
      .k7(32'b00111101111001010011101110010011),
      .k8(32'b00111101101101110111010000001001),
      .k9(32'b10111011100010010110101011010000)
  ) CON2D_117(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000000101000010000111100),
      .k2(32'b10111101100111000001000010111111),
      .k3(32'b10111100010010001001110010100100),
      .k4(32'b00111011111101001011101000000111),
      .k5(32'b10111101111101101001001110011000),
      .k6(32'b00111100111011111101111110100100),
      .k7(32'b10111110000110001000000101111111),
      .k8(32'b00111101011110111100110101000100),
      .k9(32'b00111101101010101011001110010010)
  ) CON2D_118(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101111110110100001100110110),
      .k2(32'b10111110001000001010001111111011),
      .k3(32'b00111100111111011101111101101000),
      .k4(32'b00111110000000101111000011000011),
      .k5(32'b00111101010010111101000100000001),
      .k6(32'b00111101110000111110000111001000),
      .k7(32'b10111101011100001010011000100100),
      .k8(32'b00111110000101000001111110011010),
      .k9(32'b10111101110111001111100101001110)
  ) CON2D_119(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111000011101001111110100),
      .k2(32'b00111101111011100111111000100011),
      .k3(32'b00111110000011111001000001010011),
      .k4(32'b10111101000100111011100011100010),
      .k5(32'b10111101010001110111101010000000),
      .k6(32'b10111100001011101010101001001101),
      .k7(32'b00111100011010011001101110110100),
      .k8(32'b00111101010011111000010101010000),
      .k9(32'b00111101110110011000000110011101)
  ) CON2D_120(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111100000010101100010010101110)
)   op15(
    .i_pipeline_layer2(i_CORE_IP1[14]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*15-1:DATA_WIDTH*14])
);

/// CON2D_16///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000101011100111110010101),
      .k2(32'b00111110000001011100111100011001),
      .k3(32'b00111110000111110110101101101000),
      .k4(32'b00111110001011011001010100010000),
      .k5(32'b00111100010001001101110101001111),
      .k6(32'b10111101100111000100000100110111),
      .k7(32'b10111101111110101101000011101110),
      .k8(32'b10111101010000100010000010110000),
      .k9(32'b00111110000010101111010110101101)
  ) CON2D_121(
      .i_data(i_data[DATA_WIDTH*1-1:DATA_WIDTH*0]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110001000101111111111010111),
      .k2(32'b10111101111110110010100000001101),
      .k3(32'b10111110000101100110011001100001),
      .k4(32'b10111110000101011010101101010111),
      .k5(32'b10111100010011010001100011010110),
      .k6(32'b00111101110110100010001110011010),
      .k7(32'b10111100111110110010100110000001),
      .k8(32'b10111101000101011110011111101000),
      .k9(32'b10111101011110100011100101100010)
  ) CON2D_122(
      .i_data(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100111110011110010000110000),
      .k2(32'b00111101010001101001011111010100),
      .k3(32'b10111110001001011101001101100111),
      .k4(32'b00111101101100010110010110001000),
      .k5(32'b00111101011000011101001010010001),
      .k6(32'b10111101101110011000001110111010),
      .k7(32'b10111101011111000110110100110101),
      .k8(32'b10111101100011011001111010010111),
      .k9(32'b10111101101111011101000111110101)
  ) CON2D_123(
      .i_data(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*3-1:DATA_WIDTH*2])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101010011111010101001010011),
      .k2(32'b00111101110000111001111011001110),
      .k3(32'b00111101110101001001101000000110),
      .k4(32'b10111101111011011001011110100110),
      .k5(32'b00111110000010001001110011001100),
      .k6(32'b10111101111000111010010111011111),
      .k7(32'b00111011110011001111101010010011),
      .k8(32'b00111100110110100010000011111000),
      .k9(32'b10111100111111000100001101010111)
  ) CON2D_124(
      .i_data(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000101011001001001100111),
      .k2(32'b00111101111001011010000110110011),
      .k3(32'b10111100100100000111001101000110),
      .k4(32'b10111101101111110101000100000111),
      .k5(32'b10111100100111001100100110100011),
      .k6(32'b00111101111001001110101011111111),
      .k7(32'b10111110000001011110011111110100),
      .k8(32'b10111101101110000111101010010011),
      .k9(32'b00111101100111101001010011010111)
  ) CON2D_125(
      .i_data(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101001111000010011010010010),
      .k2(32'b00111101010011000101000101100010),
      .k3(32'b00111101000101010110101000100001),
      .k4(32'b10111101011011001010110100010001),
      .k5(32'b00111110000111100110010011111100),
      .k6(32'b00111110001001101111011100001010),
      .k7(32'b00111110001000011000010110111010),
      .k8(32'b00111110000010100001011101011001),
      .k9(32'b10111101111101100100100000100010)
  ) CON2D_126(
      .i_data(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110001010001001110000000010),
      .k2(32'b10111101010000011001101110011110),
      .k3(32'b00111101101011010000010001010111),
      .k4(32'b00111110000100011110001111001100),
      .k5(32'b10111101100110111101011001110011),
      .k6(32'b00111101110101011011000110000010),
      .k7(32'b00111101111100110000011100000100),
      .k8(32'b00111101000111010111010010110010),
      .k9(32'b10111110000110001010001000101111)
  ) CON2D_127(
      .i_data(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000010000101000000111001),
      .k2(32'b10111101101011100001011100100100),
      .k3(32'b00111101100001000111100010000001),
      .k4(32'b10111110000101000110010010110111),
      .k5(32'b00111101111111011001001000100011),
      .k6(32'b10111110000011011110011001101000),
      .k7(32'b10111110001000100010000110101000),
      .k8(32'b10111101001110010101110001000010),
      .k9(32'b00111101101000010110101110001011)
  ) CON2D_128(
      .i_data(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*8-1:DATA_WIDTH*7])
  );


pipeline_layer2#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111010101011000000110110001001)
)   op16(
    .i_pipeline_layer2(i_CORE_IP1[15]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(o_data[DATA_WIDTH*16-1:DATA_WIDTH*15])
);

  control_layer3#(
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
