module layer2_1#(
    parameter DATA_WIDTH = 32,
    parameter WIDTH = 112
)(
  input  [DATA_WIDTH*8-1:0] i_data,
  input              clk, rst, valid_in,
  output [DATA_WIDTH*8-1:0] o_data,
  output             valid_out
);
  wire [DATA_WIDTH*8-1:0] i_CORE_IP1 [7:0];
  wire [DATA_WIDTH*8-1:0] i_CORE_IP2;
  wire padding_valid, valid_in_pipeline2D, valid_in_bias;
  wire [31:0] counter_col, counter_row;
  wire valid_in_maxpooling, valid_in_max, valid_in_max1; 
  wire [3:0] valid_pipeline2D;
  wire [3:0] valid_pipeline_bias;

/// CON2D_1///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110001100111010111010111101),
      .k2(32'b00111110000100100001100001010011),
      .k3(32'b10111101101111100000100110111111),
      .k4(32'b00111110010001101110011111110111),
      .k5(32'b00111110000110101000010110111000),
      .k6(32'b00111101011001011001111101101101),
      .k7(32'b10111110001011011101110011101110),
      .k8(32'b10111110001111110000111000010000),
      .k9(32'b10111110001011000010000110111001)
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
      .k1(32'b00111110001110110110000101101110),
      .k2(32'b00111110001011010111010010001110),
      .k3(32'b00111101010001010000111010010111),
      .k4(32'b00111110000001110000000000011010),
      .k5(32'b00111100101111100000010001101010),
      .k6(32'b00111101010111101010001111111100),
      .k7(32'b10111110010001100100011001100101),
      .k8(32'b00111101101100101101000110010010),
      .k9(32'b10111100101011011001111110111110)
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
      .k1(32'b10111101100110110010100110111100),
      .k2(32'b00111101111111110100110111101000),
      .k3(32'b00111110000000100101100001001000),
      .k4(32'b00111101111111100011111111101001),
      .k5(32'b00111100100111001000011001111100),
      .k6(32'b10111101101000110110110011010000),
      .k7(32'b00111110001000100100011100110011),
      .k8(32'b10111100110110000001011011111010),
      .k9(32'b10111101000101110100001000100111)
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
      .k1(32'b10111101100101100100001000001001),
      .k2(32'b10111110001101100101000111110011),
      .k3(32'b10111101111111000110010101111111),
      .k4(32'b10111101100100010101011110110101),
      .k5(32'b10111101010001001010111101110000),
      .k6(32'b00111110001001101011000110001111),
      .k7(32'b00111110000001110011100011100100),
      .k8(32'b10111110000111100111001001101110),
      .k9(32'b00111100100100010000010010100101)
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
      .k1(32'b00111110010011101111011111001101),
      .k2(32'b10111110001010111001011010010100),
      .k3(32'b00111101000111101010010101010010),
      .k4(32'b10111101110011011110001101111110),
      .k5(32'b10111110001110010011010011011110),
      .k6(32'b10111101100001101011000101010100),
      .k7(32'b00111100110110101101111111011100),
      .k8(32'b00111101111001000010110011010001),
      .k9(32'b00111101011010011010000010010100)
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
      .k1(32'b10111101010110100001010010011010),
      .k2(32'b00111110001110100100010000000011),
      .k3(32'b10111101100000000011110010001101),
      .k4(32'b10111110001010111001001001101010),
      .k5(32'b00111101010010001100101000100000),
      .k6(32'b10111011111000111000100100000010),
      .k7(32'b00111110011010110011100111001101),
      .k8(32'b10111110001100000101101011100011),
      .k9(32'b00111110001010000110001101001111)
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
      .k1(32'b10111100000100011001111100001100),
      .k2(32'b00111110001010000010000010100111),
      .k3(32'b10111110000001100000101000100000),
      .k4(32'b00111101011010011100101100010110),
      .k5(32'b10111101101000001011100000001100),
      .k6(32'b10111101010111010101010011100100),
      .k7(32'b10111110000101000100000100100000),
      .k8(32'b10111100011000011111001111101100),
      .k9(32'b10111101011001111000101011100110)
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
      .k1(32'b10111110001111110011110110101111),
      .k2(32'b00111110010100110010110101111100),
      .k3(32'b00111110001000000000111100110001),
      .k4(32'b00111100111101110001110001001000),
      .k5(32'b10111101011011010110111001010100),
      .k6(32'b00111101001110110100000110111101),
      .k7(32'b10111101101111100011100110101101),
      .k8(32'b00111110001110010111100111010011),
      .k9(32'b00111110000110100110110001010111)
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
    .bias(32'b00111100101111100000101101101010)
)   op1(
    .i_pipeline_layer2(i_CORE_IP1[0]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*1-1:DATA_WIDTH*0])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling1(
    .i_data(i_CORE_IP2[DATA_WIDTH*1-1:DATA_WIDTH*0]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*1-1:DATA_WIDTH*0])
  );

/// CON2D_2///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100111010111110010010110000),
      .k2(32'b00111100111101110000001011000011),
      .k3(32'b00111101111010100100010010110000),
      .k4(32'b00111101110101010110011101101010),
      .k5(32'b00111101011001100010000110111111),
      .k6(32'b10111100110111111100111000110111),
      .k7(32'b10111101111010000100001111100011),
      .k8(32'b00111110001101010011100000000011),
      .k9(32'b10111100000000100010110100100001)
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
      .k1(32'b00111110001100000100010111111101),
      .k2(32'b00111110000100010001100111011111),
      .k3(32'b10111101100111010111001010000101),
      .k4(32'b00111110001000111001111101001011),
      .k5(32'b00111101001111100000010110100001),
      .k6(32'b10111101101100000100101101101101),
      .k7(32'b00111011111011000110111010101101),
      .k8(32'b00111101100011110010100110110001),
      .k9(32'b00111101011111011111000101010111)
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
      .k1(32'b00111110000010100000110101100010),
      .k2(32'b10111100000001011101000001000101),
      .k3(32'b10111101110110111111001101011001),
      .k4(32'b10111101001111100111001000110101),
      .k5(32'b10111101111101100010101011011010),
      .k6(32'b00111110001000000010010000011101),
      .k7(32'b00111101111111000011111010000101),
      .k8(32'b10111101011101101100000111110100),
      .k9(32'b10111110000101010110011010000011)
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
      .k1(32'b00111101001001101000011011000000),
      .k2(32'b10111110001100000000011011000011),
      .k3(32'b00111101011111010011011010111001),
      .k4(32'b10111101101101010110000111000011),
      .k5(32'b10111101011111010011100100011111),
      .k6(32'b10111101000101100011010001010010),
      .k7(32'b10111101000010110001100110011010),
      .k8(32'b10111110000110000110111111001101),
      .k9(32'b10111101110100001100010001011000)
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
      .k1(32'b10111101100110110110100001111011),
      .k2(32'b00111110001100010010101100100001),
      .k3(32'b00111110010010011101100011110010),
      .k4(32'b00111110010001011101111011111001),
      .k5(32'b10111011000010000001001000001001),
      .k6(32'b10111101100100111101001100000000),
      .k7(32'b00111011011110101001110011011000),
      .k8(32'b00111110000010001001011100010011),
      .k9(32'b00111101111100000101001100101011)
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
      .k1(32'b10111100001111000100100011101110),
      .k2(32'b00111101001101011010001101001001),
      .k3(32'b00111110001011110001110000010111),
      .k4(32'b00111101111000100001011010101000),
      .k5(32'b10111110001001100101000100011000),
      .k6(32'b00111110001101100101010011110010),
      .k7(32'b10111101111000000010010000000001),
      .k8(32'b10111110000011110100000000101111),
      .k9(32'b10111101101110010000101110100010)
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
      .k1(32'b00111110010010010000110010001101),
      .k2(32'b00111100111001001010111111010000),
      .k3(32'b10111101101101110001100110100011),
      .k4(32'b00111101110110101001011110111110),
      .k5(32'b10111110001111010101010011100110),
      .k6(32'b10111110000101101100011101010010),
      .k7(32'b00111101100001000110001111000001),
      .k8(32'b00111101111001010011011000000001),
      .k9(32'b00111011111001011101100110100010)
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
      .k1(32'b00111101101100101000011101001101),
      .k2(32'b10111101110000100010010011100101),
      .k3(32'b00111011110010011111111100010100),
      .k4(32'b10111101100110011101011000011010),
      .k5(32'b10111110010000100001011100110111),
      .k6(32'b10111101000111001000101101111010),
      .k7(32'b00111101111100000011011001010110),
      .k8(32'b10111100111100100001000001101101),
      .k9(32'b10111110010010100101000101100001)
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
    .bias(32'b00111011110010000101011010110010)
)   op2(
    .i_pipeline_layer2(i_CORE_IP1[1]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*2-1:DATA_WIDTH*1])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling2(
    .i_data(i_CORE_IP2[DATA_WIDTH*2-1:DATA_WIDTH*1]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*2-1:DATA_WIDTH*1])
  );

/// CON2D_3///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110001111101011011011010100),
      .k2(32'b10111110000011001010110111110101),
      .k3(32'b00111110001101101101011011001101),
      .k4(32'b00111110000001100110000110110010),
      .k5(32'b10111101111000100000111001101010),
      .k6(32'b00111011000101111000110000101000),
      .k7(32'b00111101111111010111010011100100),
      .k8(32'b00111101111101100000011001101011),
      .k9(32'b10111101010001110111110010100101)
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
      .k1(32'b10111101000001011010011000111010),
      .k2(32'b10111101010010111011100001011001),
      .k3(32'b00111101000111001110110100101001),
      .k4(32'b00111100110011110001011111011001),
      .k5(32'b00111110001011010000001010000100),
      .k6(32'b10111100100010110001100001001001),
      .k7(32'b00111101100000001101100110100010),
      .k8(32'b10111110000011100100000100110111),
      .k9(32'b00111110010110100000101111100100)
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
      .k1(32'b10111110000110011101101010110101),
      .k2(32'b10111101100001100000111100110110),
      .k3(32'b10111101010001110011111101011100),
      .k4(32'b10111101110110101111010011011010),
      .k5(32'b10111101111000001110000011000110),
      .k6(32'b00111101010011100101000110001011),
      .k7(32'b10111110001010000100000111100100),
      .k8(32'b00111110000000111000110001111011),
      .k9(32'b10111101100101000100010100101100)
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
      .k1(32'b00111101101001010101010111010101),
      .k2(32'b10111101100001110001011001000010),
      .k3(32'b10111101110111000011001001101111),
      .k4(32'b10111110001111010111000001011000),
      .k5(32'b00111101001100111000000010001110),
      .k6(32'b00111110001001001111001010010110),
      .k7(32'b10111100001000111100101111111101),
      .k8(32'b00111110010001101111111001110100),
      .k9(32'b10111110001000100011111111100100)
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
      .k1(32'b00111101111111011100111011010101),
      .k2(32'b00111100011001101101101001011111),
      .k3(32'b10111110000000100100111100110101),
      .k4(32'b10111101100001111111111000111100),
      .k5(32'b00111101110000111000100010111010),
      .k6(32'b00111110000010000001100101011011),
      .k7(32'b10111110010001000011110000110011),
      .k8(32'b00111101110110001001111100101011),
      .k9(32'b10111101000000111110000010000101)
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
      .k1(32'b00111110010000110111100011001010),
      .k2(32'b10111110001110011000010010011110),
      .k3(32'b00111101101011111000111010110001),
      .k4(32'b10111101010011111000000010110101),
      .k5(32'b10111101000100010101000010101110),
      .k6(32'b00111101110111010001010100000001),
      .k7(32'b00111110010010110101010010100101),
      .k8(32'b00111110001100101111010110011011),
      .k9(32'b10111101100100101010000011111000)
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
      .k1(32'b10111110000011100110001010011101),
      .k2(32'b00111110000011101010001101010001),
      .k3(32'b10111101000101111011111101001100),
      .k4(32'b00111110001110101110110111001101),
      .k5(32'b00111101101111000111000011110001),
      .k6(32'b00111101100011000111111010011100),
      .k7(32'b10111101000010100010110111100010),
      .k8(32'b10111011100101111100000100111010),
      .k9(32'b10111101000011101000100111000110)
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
      .k1(32'b00111110000010100101000100000011),
      .k2(32'b00111101111001010010000110111011),
      .k3(32'b00111011011101110101000101011011),
      .k4(32'b10111101110111111000111110000001),
      .k5(32'b00111011100110000011001110011111),
      .k6(32'b10111110001101110010001000100011),
      .k7(32'b10111101110100010100110000100100),
      .k8(32'b00111101110000100100110100110001),
      .k9(32'b10111110000011011111101001000111)
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
    .bias(32'b00111011000000100010000001010110)
)   op3(
    .i_pipeline_layer2(i_CORE_IP1[2]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*3-1:DATA_WIDTH*2])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling3(
    .i_data(i_CORE_IP2[DATA_WIDTH*3-1:DATA_WIDTH*2]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*3-1:DATA_WIDTH*2])
  );

/// CON2D_4///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101110100100001110111000101),
      .k2(32'b00111101101010100110100001011001),
      .k3(32'b10111101101001001000000100100001),
      .k4(32'b00111110010000110011100111110110),
      .k5(32'b00111010111100000100010101011101),
      .k6(32'b00111101101001000111010000000110),
      .k7(32'b00111110001001110110101111010101),
      .k8(32'b10111101000011111101111101000010),
      .k9(32'b10111100000111000111011010010000)
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
      .k1(32'b10111101110111001111000011000000),
      .k2(32'b10111101010011011100101100100001),
      .k3(32'b00111101010001011100010000110000),
      .k4(32'b00111100100001111101000001101000),
      .k5(32'b10111101101110010111010001101001),
      .k6(32'b10111101101000011101111111010001),
      .k7(32'b10111110011000110101000011101101),
      .k8(32'b10111100101110011100110111000010),
      .k9(32'b10111110000110110001011010010011)
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
      .k1(32'b00111101100010011010111010001011),
      .k2(32'b00111110010011101000011101100111),
      .k3(32'b10111110001010101010100010010110),
      .k4(32'b00111011011010100101100011111000),
      .k5(32'b10111101001001010110111110101110),
      .k6(32'b10111110010001001000100000001111),
      .k7(32'b00111100001000111000010010010011),
      .k8(32'b00111110000000110000100100100010),
      .k9(32'b00111110000100101111101001000000)
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
      .k1(32'b00111101101011101100101001010101),
      .k2(32'b00111110001111101111101001011000),
      .k3(32'b00111110001100001011101011101100),
      .k4(32'b00111101111011110000010001110011),
      .k5(32'b10111100110111000010010100111111),
      .k6(32'b10111101110111010000100100011101),
      .k7(32'b10111110010000000001001111000010),
      .k8(32'b10111101110111110100011000000111),
      .k9(32'b10111101010110100000111011110110)
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
      .k1(32'b10111110010100100010101111001110),
      .k2(32'b10111101101000011000000010001100),
      .k3(32'b00111100100110101000000100010101),
      .k4(32'b00111101011111111101010010011110),
      .k5(32'b10111101011110000110011111110001),
      .k6(32'b00111101101101100001010100010000),
      .k7(32'b00111110000011000000110101100101),
      .k8(32'b10111101101000011101110000011001),
      .k9(32'b10111110001001111110100100101000)
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
      .k1(32'b10111110001100001000001000001000),
      .k2(32'b00111101001111010011011010010001),
      .k3(32'b10111101100101000001100011000001),
      .k4(32'b10111110000000110110101010011000),
      .k5(32'b10111101111111000101111110011000),
      .k6(32'b00111101101001001111011110101001),
      .k7(32'b00111101001101100110110000101101),
      .k8(32'b10111101100001010111110101101110),
      .k9(32'b10111100111001010101001111111110)
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
      .k1(32'b00111100011010001001100011110111),
      .k2(32'b00111101001001000011010001011011),
      .k3(32'b00111110001110001010101000110010),
      .k4(32'b10111101100001110110100101101111),
      .k5(32'b10111101111110110000011101001001),
      .k6(32'b00111101110101001110100011101011),
      .k7(32'b00111110001100101010000010110111),
      .k8(32'b10111101111100101000010110011101),
      .k9(32'b00111100101110111011011010011011)
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
      .k1(32'b10111110000111001110011100101101),
      .k2(32'b10111100100100010001111000101110),
      .k3(32'b10111100010010111000110110111001),
      .k4(32'b10111110001001100101111100110111),
      .k5(32'b10111101101110101010110101010111),
      .k6(32'b00111101111000000000011100000001),
      .k7(32'b00111101110000110110110100010101),
      .k8(32'b00111110001111110011100010111010),
      .k9(32'b10111110001110011010010001000000)
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
    .bias(32'b10111100000101011111100110100111)
)   op4(
    .i_pipeline_layer2(i_CORE_IP1[3]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*4-1:DATA_WIDTH*3])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling4(
    .i_data(i_CORE_IP2[DATA_WIDTH*4-1:DATA_WIDTH*3]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*4-1:DATA_WIDTH*3])
  );

/// CON2D_5///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101110011000001001010111111),
      .k2(32'b00111110000000110111100110100101),
      .k3(32'b10111101010001100011111100011100),
      .k4(32'b10111101110100100010010010101101),
      .k5(32'b00111101100110011011001110100001),
      .k6(32'b00111101101101001101101101100000),
      .k7(32'b00111110000111100000010001001011),
      .k8(32'b10111101011110000110011101010101),
      .k9(32'b00111100110101100011001001111110)
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
      .k1(32'b10111110000001110010001011100100),
      .k2(32'b00111100010110001110100001001101),
      .k3(32'b10111101111011000011011011001110),
      .k4(32'b10111101110010100110011001010111),
      .k5(32'b00111110000011011001000110100000),
      .k6(32'b00111110001000101100010111100001),
      .k7(32'b00111110010011100100011010101101),
      .k8(32'b00111110010011110101000100001101),
      .k9(32'b10111110000000000011001010100111)
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
      .k1(32'b00111110010011111111100011110000),
      .k2(32'b10111110001010010100001111100010),
      .k3(32'b10111101000000101111111010001111),
      .k4(32'b10111110001111111000110110100111),
      .k5(32'b00111110000010011111000010101100),
      .k6(32'b10111110000111001111011111001111),
      .k7(32'b10111110001001011111011100000101),
      .k8(32'b00111110000101001111101100001100),
      .k9(32'b10111100111010111101011101000101)
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
      .k1(32'b10111110001100011011110011101011),
      .k2(32'b00111110000001101011110100010100),
      .k3(32'b00111101100010100110000010110011),
      .k4(32'b00111110000000011100010101101100),
      .k5(32'b00111100010001001001001100001001),
      .k6(32'b00111101111001110100000111101011),
      .k7(32'b10111101100001001010110100010110),
      .k8(32'b00111110000000001011011110111011),
      .k9(32'b00111101111101101010101100001100)
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
      .k1(32'b10111101110101101001101000111001),
      .k2(32'b00111101111110010001000000001101),
      .k3(32'b00111110001100000000000100001011),
      .k4(32'b10111101001001101111011111111001),
      .k5(32'b10111101000001100000111011110010),
      .k6(32'b10111101000100000011111111110101),
      .k7(32'b00111101111010011010100111111000),
      .k8(32'b00111101111111001000110000100101),
      .k9(32'b00111101000011111100110000111110)
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
      .k1(32'b00111101101100010000000010000111),
      .k2(32'b10111101010011000000000111100011),
      .k3(32'b00111101111100100011011110101001),
      .k4(32'b00111101100111000111011011100010),
      .k5(32'b10111101100100111100001111101110),
      .k6(32'b00111101011011011011011000001011),
      .k7(32'b00111110001100000000100100101110),
      .k8(32'b10111110001010001111011001100100),
      .k9(32'b10111101001011000100100111100011)
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
      .k1(32'b00111110000110100101011110010011),
      .k2(32'b00111101101001000111111010100011),
      .k3(32'b10111101111101111011010011011111),
      .k4(32'b10111101100111100001111110100000),
      .k5(32'b00111101110000011000000000001010),
      .k6(32'b00111101101111111010110011011001),
      .k7(32'b00111101000011110100101111010110),
      .k8(32'b10111110000001101110111101001001),
      .k9(32'b00111110001100000110000000100101)
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
      .k1(32'b00111101111100010001101010010000),
      .k2(32'b00111101000100000010001101001010),
      .k3(32'b10111110001011100010010111010100),
      .k4(32'b10111101110111100101101010101110),
      .k5(32'b10111110000010001011000001110011),
      .k6(32'b10111110001101010001011101001101),
      .k7(32'b00111100110000110001010000011011),
      .k8(32'b10111101111110001100011101101001),
      .k9(32'b10111110010001010011011110010010)
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
    .bias(32'b00111100000100111011101111101000)
)   op5(
    .i_pipeline_layer2(i_CORE_IP1[4]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*5-1:DATA_WIDTH*4])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling5(
    .i_data(i_CORE_IP2[DATA_WIDTH*5-1:DATA_WIDTH*4]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*5-1:DATA_WIDTH*4])
  );

/// CON2D_6///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111101110000001001011000),
      .k2(32'b00111110000000110100011001111011),
      .k3(32'b00111101100110100000001011100001),
      .k4(32'b00111101000101011000100111111100),
      .k5(32'b10111100110110011011111110001111),
      .k6(32'b10111101110100111011000100001111),
      .k7(32'b10111110000110011000010111000010),
      .k8(32'b00111101110100010001001000010110),
      .k9(32'b00111110001010101100111100000110)
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
      .k1(32'b10111100111011111101111101000001),
      .k2(32'b00111010010001111010101010111000),
      .k3(32'b10111110011000110100111011010010),
      .k4(32'b00111101110011010000100000110011),
      .k5(32'b00111110000011000101101010010111),
      .k6(32'b10111110010110010010101101000010),
      .k7(32'b00111110000110000110111000101111),
      .k8(32'b10111101111101000001110100011110),
      .k9(32'b10111110001111100100000001011111)
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
      .k1(32'b00111101000111111011110010011111),
      .k2(32'b10111101100011010101110000101000),
      .k3(32'b00111100111010101011001111001101),
      .k4(32'b00111110001001010011011111011100),
      .k5(32'b10111011001001001110110100010011),
      .k6(32'b00111100100110111100011001100011),
      .k7(32'b00111110001000100110011100110111),
      .k8(32'b00111101100011100100110000101010),
      .k9(32'b00111110001000110111010000100011)
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
      .k1(32'b00111110000010000101101101110011),
      .k2(32'b10111101100111010000001000110011),
      .k3(32'b00111101001011100010110000011110),
      .k4(32'b00111101100110011011100101010000),
      .k5(32'b00111101110011101101101011010000),
      .k6(32'b00111110001001011001101111100111),
      .k7(32'b10111101110100101000000010110111),
      .k8(32'b00111110010010100011110100010100),
      .k9(32'b10111001011111001100110000101101)
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
      .k1(32'b00111101100101011101101000010011),
      .k2(32'b10111110010100101000110011011111),
      .k3(32'b00111101011000000000101100111111),
      .k4(32'b00111100011001000000111110010010),
      .k5(32'b10111101110101110011110011000010),
      .k6(32'b00111101110011100011010101000110),
      .k7(32'b00111100000001100011111000100110),
      .k8(32'b10111100010001010111111010000001),
      .k9(32'b10111110000010100011010001011111)
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
      .k1(32'b10111110100001011000101011011001),
      .k2(32'b10111101010010011110101100100111),
      .k3(32'b10111110010100010101000011011110),
      .k4(32'b00111101100001000000011100110110),
      .k5(32'b10111110000000000011011001011010),
      .k6(32'b10111110010101101110110000111000),
      .k7(32'b00111101000101001101011010011111),
      .k8(32'b10111110000011111001110111101101),
      .k9(32'b10111101001001111101000001010011)
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
      .k1(32'b00111101101111011010101011110101),
      .k2(32'b10111101001000111110101011111001),
      .k3(32'b10111110010000001010111000011100),
      .k4(32'b10111101000010000001010010111100),
      .k5(32'b00111110001110101101110100101001),
      .k6(32'b00111100101110001101110010111100),
      .k7(32'b00111101111010000100011001100100),
      .k8(32'b00111110010011001111000111110000),
      .k9(32'b00111100100110010110010010010101)
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
      .k1(32'b00111110000010010001011001111100),
      .k2(32'b00111110001001110001001010010111),
      .k3(32'b00111101111010111011111111010110),
      .k4(32'b10111101100100000110010011000100),
      .k5(32'b10111101101110101000011100101011),
      .k6(32'b00111101111111011011101001110100),
      .k7(32'b00111011000101100110010100101110),
      .k8(32'b00111101001101011110101000100111),
      .k9(32'b00111100001101101010011111101000)
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
    .bias(32'b10111100000111011111100111010110)
)   op6(
    .i_pipeline_layer2(i_CORE_IP1[5]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*6-1:DATA_WIDTH*5])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling6(
    .i_data(i_CORE_IP2[DATA_WIDTH*6-1:DATA_WIDTH*5]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*6-1:DATA_WIDTH*5])
  );

/// CON2D_7///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000101100001100101101100),
      .k2(32'b10111110001001010100000011011111),
      .k3(32'b10111110000001111111111110101000),
      .k4(32'b00111110010111010011111000001010),
      .k5(32'b10111101100011111011101110101000),
      .k6(32'b00111110010001100000010110001000),
      .k7(32'b00111110010000110010011110110010),
      .k8(32'b00111110010101101100001110001000),
      .k9(32'b00111110010001100001101001111111)
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
      .k1(32'b10111101101111000100100010001101),
      .k2(32'b10111100100011010111110000011101),
      .k3(32'b10111101010110010101011100010001),
      .k4(32'b00111100000010010111101010000000),
      .k5(32'b00111101100000001010110011110001),
      .k6(32'b10111110010100100100010111100001),
      .k7(32'b00111101010000001100010000101111),
      .k8(32'b10111110001111011100111011101010),
      .k9(32'b10111101111110101011011111010110)
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
      .k1(32'b00111101110000010001100100110111),
      .k2(32'b00111101111100100000110110111010),
      .k3(32'b00111101010001100111111101111000),
      .k4(32'b10111101100101100100111111110000),
      .k5(32'b10111101101111101110100110001000),
      .k6(32'b00111100010010011000011011101000),
      .k7(32'b10111101100011010011101111101111),
      .k8(32'b10111101101111111100111110100001),
      .k9(32'b10111101100110110010000110001101)
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
      .k1(32'b10111110010010001000001111011101),
      .k2(32'b00111101001000101011100001101100),
      .k3(32'b00111110001100101010001111000011),
      .k4(32'b10111101001000100110110010001110),
      .k5(32'b10111110001000100101000101000101),
      .k6(32'b10111101110100001111101111110000),
      .k7(32'b10111101000001111011000011100010),
      .k8(32'b00111101001110101010100111101100),
      .k9(32'b00111101111010111010001110111010)
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
      .k1(32'b10111100011010100110110110100010),
      .k2(32'b00111110001101000100111010010110),
      .k3(32'b00111101111011010110101000000000),
      .k4(32'b10111100011000111010100000010101),
      .k5(32'b10111100001101011011110100101111),
      .k6(32'b00111110001011000000100101000000),
      .k7(32'b10111110001000100110001111011000),
      .k8(32'b10111101110001011001111101110001),
      .k9(32'b00111101001111010101001001001111)
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
      .k1(32'b10111110001011100100100111101001),
      .k2(32'b10111110001111101010000101001011),
      .k3(32'b00111101100010101110011000111001),
      .k4(32'b10111101111100011011110100110001),
      .k5(32'b00111110000111100001110111111110),
      .k6(32'b00111110001101010111100100101110),
      .k7(32'b00111101010011010001001110101001),
      .k8(32'b10111101000111011010111001000101),
      .k9(32'b00111100010110110000100100100010)
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
      .k1(32'b10111101010010111000111101101010),
      .k2(32'b00111101011100001000010001101110),
      .k3(32'b10111110001100000011101100111100),
      .k4(32'b10111101101111010101110101110010),
      .k5(32'b00111101110011110000000101010111),
      .k6(32'b10111101101010111011001101011000),
      .k7(32'b00111101011100001001011000110011),
      .k8(32'b10111110000101110011010001111110),
      .k9(32'b10111101101000101111101111010101)
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
      .k1(32'b10111100101010111110011111000100),
      .k2(32'b00111101100101100101101001001111),
      .k3(32'b10111101101000111011100100000010),
      .k4(32'b10111110000110110101101100011101),
      .k5(32'b00111110010011110000111011010011),
      .k6(32'b00111110010011111001011111100010),
      .k7(32'b10111101111100110000111101110100),
      .k8(32'b10111110000101011000011011110010),
      .k9(32'b00111101100001100110001101110011)
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
    .bias(32'b00111011101110010100000101001111)
)   op7(
    .i_pipeline_layer2(i_CORE_IP1[6]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*7-1:DATA_WIDTH*6])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling7(
    .i_data(i_CORE_IP2[DATA_WIDTH*7-1:DATA_WIDTH*6]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*7-1:DATA_WIDTH*6])
  );

/// CON2D_8///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101100011000011111100001000),
      .k2(32'b00111101111011000000111110000101),
      .k3(32'b10111110000000100001101110101100),
      .k4(32'b00111101110111110001110111111110),
      .k5(32'b00111101101001011001011000010001),
      .k6(32'b10111011100110011100000010001110),
      .k7(32'b10111101001101100001110001101010),
      .k8(32'b00111110000110100011100000101100),
      .k9(32'b00111110010000001000011100001111)
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
      .k1(32'b00111101100111011110111101110010),
      .k2(32'b10111110001001000111010110111110),
      .k3(32'b10111101111110110001100000101100),
      .k4(32'b00111110001100000001011110011110),
      .k5(32'b00111101010001001001100100111001),
      .k6(32'b10111110001010010100001010101001),
      .k7(32'b00111110001001111110111111110001),
      .k8(32'b00111100100110010010110100110000),
      .k9(32'b10111101101000101000101000111001)
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
      .k1(32'b00111101101101011000000010010101),
      .k2(32'b10111110010110001011110001100010),
      .k3(32'b10111101100000110000101110100111),
      .k4(32'b10111101010010111111010010101011),
      .k5(32'b00111101101010110100101100100011),
      .k6(32'b10111101010101100111011000001101),
      .k7(32'b00111110001110001000010011010101),
      .k8(32'b10111101111101101111011001000111),
      .k9(32'b00111110010000001111110101010110)
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
      .k1(32'b00111101000001001100001101010000),
      .k2(32'b10111110000110100000000100100011),
      .k3(32'b10111101111010101001100011000110),
      .k4(32'b00111110010000101100100100100010),
      .k5(32'b00111110000100001101100011100110),
      .k6(32'b00111110000011101111001011001111),
      .k7(32'b00111101110111000000011111000101),
      .k8(32'b00111101110000000111110010000101),
      .k9(32'b10111101110101010100100101010110)
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
      .k1(32'b00111100101001110011001100111111),
      .k2(32'b00111101010110010010000001110110),
      .k3(32'b10111101111101101110001100010000),
      .k4(32'b00111110001010101111011111111111),
      .k5(32'b00111101011100001010100110011011),
      .k6(32'b00111110000100000001110101110110),
      .k7(32'b10111110001001010110001100010001),
      .k8(32'b10111110001000100111001011010000),
      .k9(32'b00111101110100011011011110110010)
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
      .k1(32'b00111110001111000000001011001001),
      .k2(32'b10111110000001000010111110100001),
      .k3(32'b00111110010011101001000000001101),
      .k4(32'b00111110000111000011000001001001),
      .k5(32'b10111110001011000111011001111110),
      .k6(32'b00111100110000111011101101010101),
      .k7(32'b00111101111000010011100100101101),
      .k8(32'b00111101110010110010100010100100),
      .k9(32'b00111110011010001010101011100110)
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
      .k1(32'b00111101000010000111010101010000),
      .k2(32'b10111101001100001010001110101110),
      .k3(32'b10111110001110010001001100010100),
      .k4(32'b10111101001110111010110100010011),
      .k5(32'b00111101111001001000000001000100),
      .k6(32'b00111101100101111101110000011010),
      .k7(32'b10111101000001110101010001100000),
      .k8(32'b00111101001110101110010010110011),
      .k9(32'b00111101011110001100110111011000)
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
      .k1(32'b00111110001011001001011011001011),
      .k2(32'b00111101101010000101011101110110),
      .k3(32'b10111101001111110110110010010001),
      .k4(32'b00111100111100110010101011101001),
      .k5(32'b10111110010110000001011001010110),
      .k6(32'b10111110001101011111000100111010),
      .k7(32'b10111110001111001000100010100011),
      .k8(32'b00111101101000001110010100010111),
      .k9(32'b10111110010101001110110110001101)
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
    .bias(32'b10111100100111111000011101110100)
)   op8(
    .i_pipeline_layer2(i_CORE_IP1[7]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*8-1:DATA_WIDTH*7])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling8(
    .i_data(i_CORE_IP2[DATA_WIDTH*8-1:DATA_WIDTH*7]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*8-1:DATA_WIDTH*7])
  );

  control_layer2#(
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
      .valid_in_maxpooling(valid_in_maxpooling), 
      .valid_in_max(valid_in_max), 
      .valid_in_max1(valid_in_max1),
      .valid_out(valid_out)
    );
endmodule
