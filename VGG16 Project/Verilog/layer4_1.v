module layer4_1#(
    parameter DATA_WIDTH = 32,
    parameter WIDTH = 56
)(
  input  [DATA_WIDTH*16-1:0] i_data,
  input              clk, rst, valid_in,
  output [DATA_WIDTH*16-1:0] o_data,
  output             valid_out
);
  wire [DATA_WIDTH*16-1:0] i_CORE_IP1 [15:0];
  wire [DATA_WIDTH*16-1:0] i_CORE_IP2;
  wire padding_valid, valid_in_pipeline2D, valid_in_bias;
  wire [31:0] counter_col, counter_row;
  wire valid_in_maxpooling, valid_in_max, valid_in_max1; 
  wire [3:0] valid_pipeline2D;
  wire [4:0] valid_pipeline_bias;

/// CON2D_1///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000000000000100000011101),
      .k2(32'b00111101011010110101111110101101),
      .k3(32'b00111101110110010100011011100110),
      .k4(32'b10111101101001000111011100101100),
      .k5(32'b10111101001000011110001101000101),
      .k6(32'b10111101101101011111011010011000),
      .k7(32'b00111100100111111010011111110110),
      .k8(32'b10111101100100010000101110101010),
      .k9(32'b00111101111100111101100000010111)
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
      .k1(32'b00111011101100001001011100110101),
      .k2(32'b10111110000001110100100011100110),
      .k3(32'b10111101100011011001110000111100),
      .k4(32'b10111101111000010100001000000100),
      .k5(32'b00111101110100001010100100100111),
      .k6(32'b10111101011000100111110001000111),
      .k7(32'b10111101010111101001011000000001),
      .k8(32'b10111101101001000101101111010101),
      .k9(32'b10111011010101111101001100001010)
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
      .k1(32'b00111110000111011100111011010101),
      .k2(32'b00111101000111110110001010111111),
      .k3(32'b00111101100010010110110111011010),
      .k4(32'b10111101011111001110101101000100),
      .k5(32'b10111011110111101110110000011010),
      .k6(32'b10111101000100000110010110011001),
      .k7(32'b00111110000001010101100110111110),
      .k8(32'b00111101111111011101110000010001),
      .k9(32'b00111101100000100011111011001001)
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
      .k1(32'b10111101111011001111111111000111),
      .k2(32'b00111101111100011000111000001100),
      .k3(32'b00111101110101100100000111100111),
      .k4(32'b00111011010101110100101000100110),
      .k5(32'b10111101101001101010000110110110),
      .k6(32'b00111100001101111011010110110000),
      .k7(32'b00111101010001010011110010000000),
      .k8(32'b00111100111000010101010010101011),
      .k9(32'b10111101110101001101100011010011)
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
      .k1(32'b10111101000011010111110010100111),
      .k2(32'b10111101110110100001110010111100),
      .k3(32'b00111101001111000000110000101000),
      .k4(32'b00111101011011101111100001111011),
      .k5(32'b00111101111010100000000110001001),
      .k6(32'b00111100101110111101101111000100),
      .k7(32'b00111101011010000101110011011111),
      .k8(32'b10111100011000010011000000010001),
      .k9(32'b00111011001111111100011100111010)
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
      .k1(32'b10111101100001010110100000100001),
      .k2(32'b00111100101100011000001000100101),
      .k3(32'b00111101100111100010111101101010),
      .k4(32'b00111101000111110110101010010110),
      .k5(32'b00111101001110010101000010110010),
      .k6(32'b00111101100100001110000110001000),
      .k7(32'b10111101001110110001000001100100),
      .k8(32'b10111101011011010110101101011000),
      .k9(32'b00111101110101010111100101011100)
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
      .k1(32'b00111101100111110000110000111011),
      .k2(32'b00111101111100011110101100000010),
      .k3(32'b10111101111111101101010010100110),
      .k4(32'b10111101110100110110100011101111),
      .k5(32'b00111100111011010101011111101001),
      .k6(32'b10111101010111111011011100111111),
      .k7(32'b00111101011000000010101111001110),
      .k8(32'b00111101100101000110001001101101),
      .k9(32'b10111101110100001100100000001100)
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
      .k1(32'b10111101010010101000000101011100),
      .k2(32'b10111101101000110111000111010000),
      .k3(32'b00111101100001011111001010101001),
      .k4(32'b10111101100100001011001011000010),
      .k5(32'b10111110000001001010010100110001),
      .k6(32'b00111100100010100011111100100100),
      .k7(32'b00111101101100001110101011011111),
      .k8(32'b00111101111111011011001010001111),
      .k9(32'b10111101100011011011111000101011)
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000000001100001101101010),
      .k2(32'b00111101011001101111010111000000),
      .k3(32'b00111110000011011000111000011111),
      .k4(32'b00111100110001001100001000101001),
      .k5(32'b00111101010110110101111001101001),
      .k6(32'b10111100010111011111111000000000),
      .k7(32'b00111101010011000010000100101000),
      .k8(32'b00111101101000101111111111110111),
      .k9(32'b00111101100111000000011111101000)
  ) CON2D_9(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101100010100010001001011101),
      .k2(32'b00111101011111010010110001111111),
      .k3(32'b10111101010100010011011110111001),
      .k4(32'b00111101111000111100110000000110),
      .k5(32'b10111110000100101101001100100110),
      .k6(32'b00111100111001001101011101010101),
      .k7(32'b00111100111010101001000001100010),
      .k8(32'b10111101111101010110100111101111),
      .k9(32'b10111110000111000011011111001001)
  ) CON2D_10(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111100001101010111001111),
      .k2(32'b10111110000010011100010111100111),
      .k3(32'b10111101011010001011011101110001),
      .k4(32'b10111100110001110111000011100001),
      .k5(32'b00111101110010011100001101111100),
      .k6(32'b00111101100010110101011111010001),
      .k7(32'b00111101100110100111100111001000),
      .k8(32'b10111101010001101011110011111011),
      .k9(32'b00111101110110100011001100101000)
  ) CON2D_11(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100100001011010011010111110),
      .k2(32'b00111101111000010111010111111111),
      .k3(32'b00111101100100101000001110110110),
      .k4(32'b00111101011001100110010100100111),
      .k5(32'b10111011110011000011110100010001),
      .k6(32'b10111101110101100100010010011000),
      .k7(32'b00111101100111110000110100100101),
      .k8(32'b10111101111111101101010000110100),
      .k9(32'b00111110000000100001010000100011)
  ) CON2D_12(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101101010101101100100000100),
      .k2(32'b00111100101000110011110001101100),
      .k3(32'b00111101110010111000000011100110),
      .k4(32'b10111100110001010000001100100010),
      .k5(32'b00111101001111011101100010100011),
      .k6(32'b00111101111010000101000111011001),
      .k7(32'b00111101111001100100100101011000),
      .k8(32'b00111101101000111100100110101000),
      .k9(32'b10111110000001101111000011000100)
  ) CON2D_13(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101011011001110110010010),
      .k2(32'b00111101001000101010100000101101),
      .k3(32'b00111101111101000101001100111100),
      .k4(32'b00111101100001000000011101100111),
      .k5(32'b00111101001001100001000101100101),
      .k6(32'b10111101101011010011001001111100),
      .k7(32'b00111101100011111111011001101011),
      .k8(32'b10111110000010010100111101100100),
      .k9(32'b00111101010000111111111000010100)
  ) CON2D_14(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101101101111010101110111100),
      .k2(32'b10111101000110011111010111100100),
      .k3(32'b10111101101100111110110011101101),
      .k4(32'b10111110000011100101010111001011),
      .k5(32'b10111101101100011101010110110101),
      .k6(32'b00111101101111011111010010101011),
      .k7(32'b10111110000000100111110010001110),
      .k8(32'b10111101100000000100111100110011),
      .k9(32'b00111100100110001010100100111110)
  ) CON2D_15(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101110110010001110101001101),
      .k2(32'b00111110000100100000010111111001),
      .k3(32'b10111011100011111000110111000011),
      .k4(32'b00111101111110001010110111101100),
      .k5(32'b00111110000001111110111100100000),
      .k6(32'b10111011111011110101011011101010),
      .k7(32'b00111101111010100110000101100110),
      .k8(32'b10111101111011101110110100001011),
      .k9(32'b00111101111100111011100111001111)
  ) CON2D_16(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[0][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111100100001111111000000011001)
)   op1(
    .i_pipeline_layer4(i_CORE_IP1[0]), 
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
      .k1(32'b10111100001011011011000110010001),
      .k2(32'b10111101010101101111001001011101),
      .k3(32'b10111110000110001000100001100001),
      .k4(32'b00111101100111111001011010010001),
      .k5(32'b00111101000111000011111010000010),
      .k6(32'b10111101111101010111101011010010),
      .k7(32'b00111110000000000011111010010001),
      .k8(32'b10111101101100100000110111011000),
      .k9(32'b10111101001111010110011110010011)
  ) CON2D_17(
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
      .k1(32'b00111101111110100011111000010110),
      .k2(32'b10111101101010101001000000010011),
      .k3(32'b00111101111100111100111111100000),
      .k4(32'b10111101010000101010010100011001),
      .k5(32'b00111101011001110000110110111010),
      .k6(32'b10111101110001010001000010010100),
      .k7(32'b00111110000001111110100101011100),
      .k8(32'b00111110000010001100111110011111),
      .k9(32'b00111100011010001111111000110011)
  ) CON2D_18(
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
      .k1(32'b00111101111110100000101011110100),
      .k2(32'b00111101010011011100111110110010),
      .k3(32'b00111110000000010111101001100100),
      .k4(32'b00111101101101111101111101110111),
      .k5(32'b10111101000110001101001011101010),
      .k6(32'b10111110000010111001100000110001),
      .k7(32'b10111101001010101111011101010001),
      .k8(32'b00111101011011001110001110110110),
      .k9(32'b10111100110010010000011001001111)
  ) CON2D_19(
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
      .k1(32'b00111101110111110000011001101101),
      .k2(32'b10111101101011111010010001101000),
      .k3(32'b00111101100111100111101110101110),
      .k4(32'b10111100110101111100001011101111),
      .k5(32'b00111110000100101100001111100100),
      .k6(32'b10111110000010111011010101000001),
      .k7(32'b10111101111011000001010011111010),
      .k8(32'b10111101001111011000110110110110),
      .k9(32'b00111101111001001011010111000111)
  ) CON2D_20(
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
      .k1(32'b10111101100010111110101001011000),
      .k2(32'b00111101100101111011111110101101),
      .k3(32'b00111101001000000001001001010010),
      .k4(32'b10111101110101110010000111001000),
      .k5(32'b10111101001100111001110110010111),
      .k6(32'b10111101110001101100111111100110),
      .k7(32'b10111101010001100010111101110100),
      .k8(32'b00111101011001111001110101101110),
      .k9(32'b00111100111110011111110110101000)
  ) CON2D_21(
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
      .k1(32'b00111101010010100100001110100100),
      .k2(32'b00111100101101010001111110001100),
      .k3(32'b00111100111011010011000110101100),
      .k4(32'b00111110001100011010011001100100),
      .k5(32'b10111101001100110011110101011001),
      .k6(32'b00111101100101111101111110010010),
      .k7(32'b10111101101010010110100001100010),
      .k8(32'b00111101000000100101101001110010),
      .k9(32'b10111101100110111100101001111110)
  ) CON2D_22(
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
      .k1(32'b10111101100011111101011101000101),
      .k2(32'b10111100001101110111001011110100),
      .k3(32'b00111101110101100010110100010101),
      .k4(32'b00111110000101101001111010101111),
      .k5(32'b00111101101011001011111010010010),
      .k6(32'b00111101101010101101001110010111),
      .k7(32'b10111101111001100011011100100111),
      .k8(32'b00111101101001100011000001010011),
      .k9(32'b00111101110001011111101101010101)
  ) CON2D_23(
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
      .k1(32'b10111011100011000001001110100110),
      .k2(32'b00111100101010000110100001010101),
      .k3(32'b00111110000100000100010111111000),
      .k4(32'b10111101100101010110011010010101),
      .k5(32'b00111101100011011001010101101110),
      .k6(32'b10111110000010001001010000100001),
      .k7(32'b10111100001101010000010110110111),
      .k8(32'b00111101101111010110111000111001),
      .k9(32'b10111100100010100111001100010011)
  ) CON2D_24(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100111011111111100101100010),
      .k2(32'b00111101010101010111011110100010),
      .k3(32'b10111101111101010001101111111011),
      .k4(32'b10111100111001100000000001011011),
      .k5(32'b10111100111110110111100110100111),
      .k6(32'b10111100001010101111101010101000),
      .k7(32'b10111110000100101111101101011011),
      .k8(32'b10111011111000011001010100111000),
      .k9(32'b00111101110100010011110000101001)
  ) CON2D_25(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111110000011001011100100),
      .k2(32'b10111100101011000100000110111001),
      .k3(32'b00111100100011110000001110101010),
      .k4(32'b10111101101011100101110011111101),
      .k5(32'b00111101111101101010111111110101),
      .k6(32'b00111101111100011000001000101110),
      .k7(32'b10111101101110001111001100011110),
      .k8(32'b10111101010100001100010110110111),
      .k9(32'b10111110000011011111111111011000)
  ) CON2D_26(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101111111111110110111110001),
      .k2(32'b00111101000100000101100010100011),
      .k3(32'b10111101001100010101011111101110),
      .k4(32'b10111101100000001010010001000100),
      .k5(32'b10111101101011001000110010100010),
      .k6(32'b10111101110101110001110111011110),
      .k7(32'b10111101110100000111001011010011),
      .k8(32'b10111110000000110000011010000110),
      .k9(32'b10111101101111001010010011011100)
  ) CON2D_27(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101001011111011010011111110),
      .k2(32'b00111101101011011011000110111101),
      .k3(32'b10111100101101111111101010101010),
      .k4(32'b10111100111000000001000101011100),
      .k5(32'b10111110000100001100111111100101),
      .k6(32'b00111110000001010100101101011010),
      .k7(32'b00111101001001010101000010010001),
      .k8(32'b10111010011111010010001110000000),
      .k9(32'b10111101111011110110100000000000)
  ) CON2D_28(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101111111010111101011000101),
      .k2(32'b00111101010101110110011010100101),
      .k3(32'b00111101001011011010111110001001),
      .k4(32'b10111101111111100110100100011110),
      .k5(32'b00111101011101010011100111100100),
      .k6(32'b00111101011110011010011001100000),
      .k7(32'b10111101001010011010000101010000),
      .k8(32'b10111101101000011010000010001100),
      .k9(32'b10111101110111010111011100111010)
  ) CON2D_29(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000011110011100100110011),
      .k2(32'b00111100101011010101000101100011),
      .k3(32'b00111101110011001111011111111001),
      .k4(32'b10111011110010011110110111010010),
      .k5(32'b00111101100101001100011000000110),
      .k6(32'b00111101100110011011110001101010),
      .k7(32'b10111101001110010010111111010010),
      .k8(32'b10111101100111010111110011001000),
      .k9(32'b10111110000001010001010011100010)
  ) CON2D_30(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101101011010001000110011100),
      .k2(32'b00111011000000101111111111001110),
      .k3(32'b10111100101100000010100101100010),
      .k4(32'b00111101101011100101101011111101),
      .k5(32'b00111101110000101100011000100011),
      .k6(32'b10111101100001001110011100101110),
      .k7(32'b00111100100000011001001000011000),
      .k8(32'b10111110000010110001101000100001),
      .k9(32'b10111101110101110001110000100110)
  ) CON2D_31(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101001101000000000011110101),
      .k2(32'b00111100101010110101101001010010),
      .k3(32'b10111101101111001010110011101100),
      .k4(32'b10111101111010101111011111100101),
      .k5(32'b10111110000011001111100111011000),
      .k6(32'b10111101000110100110101010101010),
      .k7(32'b10111101110011000010011000010000),
      .k8(32'b00111110000001011010001100110110),
      .k9(32'b00111101110100111111101001110101)
  ) CON2D_32(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[1][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111100000000110000000100100101)
)   op2(
    .i_pipeline_layer4(i_CORE_IP1[1]), 
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
      .k1(32'b10111101100111011100001010101010),
      .k2(32'b00111110000010011011010011011110),
      .k3(32'b00111101100011100100100010100001),
      .k4(32'b10111101011111110001001101111110),
      .k5(32'b00111101011110001000101110100111),
      .k6(32'b00111101100111000001111100001111),
      .k7(32'b00111100100100011100001011101010),
      .k8(32'b10111011100111011110110010010111),
      .k9(32'b10111101110010000101110001111010)
  ) CON2D_33(
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
      .k1(32'b10111101100001100000111101000000),
      .k2(32'b10111101111001010010101101100011),
      .k3(32'b10111101111000000110101111101000),
      .k4(32'b10111101010111010001011000110111),
      .k5(32'b10111101101010000110011100110010),
      .k6(32'b10111101110100101111000010111110),
      .k7(32'b00111101101000111000100011011110),
      .k8(32'b00111101111000011110011100101110),
      .k9(32'b00111101111110111011110110110101)
  ) CON2D_34(
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
      .k1(32'b00111011101001010111110100000001),
      .k2(32'b00111100111010110110101111001001),
      .k3(32'b10111101101001011100000101101101),
      .k4(32'b00111101111111000001011000011000),
      .k5(32'b10111100111010011001111000001110),
      .k6(32'b10111011111101101000111010001011),
      .k7(32'b00111011100000111110010100101000),
      .k8(32'b10111101101101110011011001011011),
      .k9(32'b10111101000010010011010010010100)
  ) CON2D_35(
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
      .k1(32'b10111110000001100111001000111010),
      .k2(32'b10111101101100000111001110100111),
      .k3(32'b10111101101000000000001101101001),
      .k4(32'b10111101110101111011010101100001),
      .k5(32'b10111101000101100001011001110001),
      .k6(32'b00111101100111010111001001011111),
      .k7(32'b00111101000110011110110101110101),
      .k8(32'b00111100001101110100011001101111),
      .k9(32'b00111101100011011110011000111100)
  ) CON2D_36(
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
      .k1(32'b00111110000010110101001110100011),
      .k2(32'b10111101100011111000001110011001),
      .k3(32'b10111101110101100001011100011000),
      .k4(32'b10111101100000101100001011000000),
      .k5(32'b10111100000000000001000010001100),
      .k6(32'b10111110000001000000100000101100),
      .k7(32'b10111011110101000110000001010001),
      .k8(32'b10111101110110101011010100111001),
      .k9(32'b00111101001000000011101110011010)
  ) CON2D_37(
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
      .k1(32'b10111110000000111000011000111110),
      .k2(32'b10111101111110000111011011110100),
      .k3(32'b00111101111110101001011000100110),
      .k4(32'b00111101110101111111111010111011),
      .k5(32'b00111101101000100000011101111011),
      .k6(32'b10111101100001010111011101100001),
      .k7(32'b00111101001111111111100110110111),
      .k8(32'b10111101110100111011111101100100),
      .k9(32'b00111101100100010110011011000001)
  ) CON2D_38(
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
      .k1(32'b00111110000100101000110011001101),
      .k2(32'b00111101010000010000111000101111),
      .k3(32'b00111101101101001110111001101000),
      .k4(32'b10111101100011001101011110100000),
      .k5(32'b00111101010010101110000100100000),
      .k6(32'b00111100100010000101001000000110),
      .k7(32'b00111101101010100110000000111011),
      .k8(32'b10111101000111110111111010110110),
      .k9(32'b00111101110110010101110010110011)
  ) CON2D_39(
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
      .k1(32'b00111100100110000111110011100010),
      .k2(32'b10111010011010011101011111001000),
      .k3(32'b00111100110001110110010100101011),
      .k4(32'b00111110000101001100101111000101),
      .k5(32'b10111110000000000101001100011101),
      .k6(32'b10111101110100011010000010010001),
      .k7(32'b00111110000010011010110011000111),
      .k8(32'b00111011101001110010100111100110),
      .k9(32'b00111101101011001000001011110110)
  ) CON2D_40(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000011010110011100100111),
      .k2(32'b00111101001000011101101100100001),
      .k3(32'b00111101100111011010010111011101),
      .k4(32'b10111101010000001100101100010111),
      .k5(32'b00111110000101100001011011000110),
      .k6(32'b00111110000010000101001011011100),
      .k7(32'b00111101110001100010000000110000),
      .k8(32'b10111101101110101101000011010010),
      .k9(32'b10111101110101010110100011011010)
  ) CON2D_41(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000001011011101010001010),
      .k2(32'b10111101000110010110011101001010),
      .k3(32'b00111100100111001100111010111011),
      .k4(32'b10111101111110111111001011010001),
      .k5(32'b00111101110111010111001110100010),
      .k6(32'b00111101101000100001000110101111),
      .k7(32'b00111101101010111101110011110000),
      .k8(32'b00111110000000111100001010001000),
      .k9(32'b00111101000011110011011111101000)
  ) CON2D_42(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101000111110110010011101101),
      .k2(32'b10111101101001111000010011001011),
      .k3(32'b00111101101101110100110100110010),
      .k4(32'b00111101101101001000100110100010),
      .k5(32'b10111100101111010010110000100010),
      .k6(32'b00111100100000011000101100101100),
      .k7(32'b10111100110100111100001010100111),
      .k8(32'b10111100111010000110111010000011),
      .k9(32'b10111100101011010110110011010010)
  ) CON2D_43(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100001010011100100001001011),
      .k2(32'b10111101100010000010001101100111),
      .k3(32'b00111101100011001001110101100110),
      .k4(32'b10111101100111011000101110101010),
      .k5(32'b00111100110000110100000101100100),
      .k6(32'b10111101111111000111001010100000),
      .k7(32'b10111101111100011110001101010110),
      .k8(32'b00111101101010110000001011000101),
      .k9(32'b00111110000010101100010100001111)
  ) CON2D_44(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111011111011100110011100101010),
      .k2(32'b10111101100000011001010010101101),
      .k3(32'b00111110000001110100011100111000),
      .k4(32'b10111100110001100011010001100101),
      .k5(32'b00111101010101111100110110110001),
      .k6(32'b00111100111010100011101100011000),
      .k7(32'b10111101101010111011110101111010),
      .k8(32'b00111100001101101010101111101000),
      .k9(32'b10111101000110011110100011011110)
  ) CON2D_45(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000011000100101001110010),
      .k2(32'b10111101100110011011010011110111),
      .k3(32'b00111110000010011010111001010100),
      .k4(32'b00111110000011010001111101111100),
      .k5(32'b10111100010110101011100110101001),
      .k6(32'b00111101111101010100111000110010),
      .k7(32'b10111101001100101100100001001101),
      .k8(32'b00111101001100101011110010010000),
      .k9(32'b10111100111001100110110000110000)
  ) CON2D_46(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101011010010001001001101000),
      .k2(32'b10111100101111011011111110110110),
      .k3(32'b00111101100011011011110010100110),
      .k4(32'b10111101100100010101001110001101),
      .k5(32'b00111100100010101011110011111011),
      .k6(32'b10111011101000111110100001101100),
      .k7(32'b00111101100101000111110101010010),
      .k8(32'b00111101110111111100101101111100),
      .k9(32'b00111101110000111111001101110110)
  ) CON2D_47(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000010111100101100110000),
      .k2(32'b00111101110001111011111001111110),
      .k3(32'b10111100100000011100001010001101),
      .k4(32'b00111101111101000111111001000111),
      .k5(32'b10111101010111101001011000001010),
      .k6(32'b00111101100100101000000011111001),
      .k7(32'b00111100100011010110001101101110),
      .k8(32'b10111101100010111111101110111111),
      .k9(32'b10111101010100101000001111001000)
  ) CON2D_48(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[2][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111100000101110011000010000000)
)   op3(
    .i_pipeline_layer4(i_CORE_IP1[2]), 
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
      .k1(32'b10111101101000110110011011111000),
      .k2(32'b10111101001100101101011000000000),
      .k3(32'b00111101111111101110000110010000),
      .k4(32'b10111101010100000011010110000001),
      .k5(32'b00111101001101001100011100000010),
      .k6(32'b10111101110110011000100111110001),
      .k7(32'b00111101001000010110001000001011),
      .k8(32'b00111101111010110111100111010110),
      .k9(32'b10111100000101010110010100100010)
  ) CON2D_49(
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
      .k1(32'b10111100110011100110011011101010),
      .k2(32'b00111101011011011111000110000001),
      .k3(32'b00111101010100111111100001100000),
      .k4(32'b10111101000111110110010111100101),
      .k5(32'b10111101111000010000001000100110),
      .k6(32'b10111101111000000000100111100010),
      .k7(32'b00111000000100011001100101101111),
      .k8(32'b10111100101111100001011101000011),
      .k9(32'b10111110001000011001110011100010)
  ) CON2D_50(
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
      .k1(32'b10111110000000101010000100011000),
      .k2(32'b00111101100001111101000010110111),
      .k3(32'b00111101111111101000110000100011),
      .k4(32'b00111101110110000101001111001110),
      .k5(32'b10111101100111001001110111011101),
      .k6(32'b10111100100110100100110000010110),
      .k7(32'b10111101001101010000101110000100),
      .k8(32'b00111101110010001000000110001001),
      .k9(32'b00111101000000110111101011001011)
  ) CON2D_51(
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
      .k1(32'b00111101010011100010000100001100),
      .k2(32'b10111101101011100101100011110111),
      .k3(32'b10111100011101100011100110110101),
      .k4(32'b00111101010111001000100001000001),
      .k5(32'b10111101110011100110110010010110),
      .k6(32'b10111101100111101110110110110100),
      .k7(32'b00111101111110111111101011001011),
      .k8(32'b00111110000001011101000110000011),
      .k9(32'b10111101110100000100101001100011)
  ) CON2D_52(
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
      .k1(32'b10111010010011011111001101001010),
      .k2(32'b10111101001000111010010010110110),
      .k3(32'b00111101111001111011101000111111),
      .k4(32'b10111110000001111010101111000000),
      .k5(32'b00111101100111101110110010000111),
      .k6(32'b00111101000110111011101100101000),
      .k7(32'b10111110000001100001000001100100),
      .k8(32'b00111100100011000101000101000000),
      .k9(32'b10111101101001010001011000001101)
  ) CON2D_53(
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
      .k1(32'b00111101110111100011010011101110),
      .k2(32'b00111110000000010011000111010011),
      .k3(32'b00111011101100000111011010000110),
      .k4(32'b00111101110101110100100101111001),
      .k5(32'b10111101011010010110000000101111),
      .k6(32'b10111101011101100111110010011101),
      .k7(32'b00111101111011111110111101100101),
      .k8(32'b10111101001001011110010011001011),
      .k9(32'b00111101101100100110000010010000)
  ) CON2D_54(
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
      .k1(32'b10111101100010011011111100011001),
      .k2(32'b10111101111001100000100101101010),
      .k3(32'b10111101001101011110111001011000),
      .k4(32'b10111101010100101000000100011100),
      .k5(32'b00111101101111101100111100100100),
      .k6(32'b00111110000001000001010001011001),
      .k7(32'b10111101001111011010000101011111),
      .k8(32'b00111011000111100101101111000010),
      .k9(32'b10111100011001001111000010000101)
  ) CON2D_55(
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
      .k1(32'b10111101101111011010110011001101),
      .k2(32'b00111101110110101111000000110000),
      .k3(32'b00111011000101101110011101010100),
      .k4(32'b00111101110001111010000010000000),
      .k5(32'b00111101100001010000010000001110),
      .k6(32'b10111010000100000101010011111100),
      .k7(32'b10111101101111000011000110010110),
      .k8(32'b10111100100000111010101000101111),
      .k9(32'b10111101100101110101011111010101)
  ) CON2D_56(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101000100110110111010101011),
      .k2(32'b00111101001110111001001101010110),
      .k3(32'b10111010011111010111100100100100),
      .k4(32'b10111101101000100111001000000110),
      .k5(32'b00111010011010001110010010001111),
      .k6(32'b10111100110010000000011011100010),
      .k7(32'b00111101100100011001000110111001),
      .k8(32'b00111101110001110000001010101101),
      .k9(32'b00111100001111011001110011010110)
  ) CON2D_57(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000101100001111001000101),
      .k2(32'b00111100000111111000111011011100),
      .k3(32'b10111110000000010000110100110001),
      .k4(32'b10111101110011101001111010100111),
      .k5(32'b10111100001110101100111101111011),
      .k6(32'b10111100001111110101001010000010),
      .k7(32'b00111101111000011001111011111100),
      .k8(32'b10111101001011101000000001101101),
      .k9(32'b10111101101011100110100010100001)
  ) CON2D_58(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000100001111010000000001),
      .k2(32'b10111110000000011101000101111100),
      .k3(32'b00111110001000110001010100110111),
      .k4(32'b00111101101010100011011111011000),
      .k5(32'b10111101101101000010101000011100),
      .k6(32'b00111101100010110011100101001111),
      .k7(32'b00111101100110000010001100111001),
      .k8(32'b00111101101111111011111100100001),
      .k9(32'b00111101111110010010111000000000)
  ) CON2D_59(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000101011100011111001000),
      .k2(32'b00111101010111010111011100100000),
      .k3(32'b00111101100111110111100010011001),
      .k4(32'b10111101001100000110011111011010),
      .k5(32'b10111101000110010010000110100010),
      .k6(32'b10111101110110000000010000100100),
      .k7(32'b10111101100101011110100011010101),
      .k8(32'b10111101001010010111001111101011),
      .k9(32'b00111101111111111000000000010101)
  ) CON2D_60(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101011010011100100001010),
      .k2(32'b10111101011001101110100111011010),
      .k3(32'b00111101111100000000100110111100),
      .k4(32'b10111101110010101011100100111011),
      .k5(32'b00111101000000001000111100110000),
      .k6(32'b10111100000010111010011111111101),
      .k7(32'b00111110000001011100110010001000),
      .k8(32'b00111101111100101111001100011100),
      .k9(32'b10111100100111110100000010001110)
  ) CON2D_61(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101110101101001000111100),
      .k2(32'b00111100000010011011000010101111),
      .k3(32'b10111010111001011000010110101111),
      .k4(32'b10111101110011011011010011011111),
      .k5(32'b00111110000101110010011101001111),
      .k6(32'b10111101000011101011000111010011),
      .k7(32'b00111101111001111100000101101001),
      .k8(32'b10111101100000101000100000110011),
      .k9(32'b10111110000010111000111100101101)
  ) CON2D_62(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100011000001101000110110000),
      .k2(32'b10111101001011100000100010000010),
      .k3(32'b10111110000000011000000110110011),
      .k4(32'b00111011101111011000100110111101),
      .k5(32'b00111110000000001100011011010000),
      .k6(32'b10111101000111110000101011111100),
      .k7(32'b00111101111110111011110100000110),
      .k8(32'b10111101110010000001100010011000),
      .k9(32'b00111100101110101110110000001010)
  ) CON2D_63(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100011000001010001110011011),
      .k2(32'b10111101000111001100011000101001),
      .k3(32'b00111100110000000100111110001011),
      .k4(32'b00111110000011000011011011101000),
      .k5(32'b10111101100110111110011000100010),
      .k6(32'b00111101111010101011010001010010),
      .k7(32'b00111101001001100100101001001101),
      .k8(32'b00111100010111000110010001100110),
      .k9(32'b00111101110011001001011011100000)
  ) CON2D_64(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[3][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111011100111010000001110011011)
)   op4(
    .i_pipeline_layer4(i_CORE_IP1[3]), 
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
      .k1(32'b00111101000101111000001010011111),
      .k2(32'b00111100111100010000010001011011),
      .k3(32'b10111100101001000010001001000001),
      .k4(32'b00111101011000000110110101000100),
      .k5(32'b00111101110101110001001101110001),
      .k6(32'b10111101100110101001011000000001),
      .k7(32'b10111100100011011110001101000111),
      .k8(32'b10111101110100110100010101100000),
      .k9(32'b00111100100011111101000010101011)
  ) CON2D_65(
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
      .k1(32'b10111101000101000011010101101010),
      .k2(32'b00111101011110110011100111101101),
      .k3(32'b10111101110111100100010101100111),
      .k4(32'b10111110000111100111111111110110),
      .k5(32'b00111101110110110101100100101100),
      .k6(32'b00111101010010010100010111001001),
      .k7(32'b10111101000110100000111011110010),
      .k8(32'b00111010111110010100000111111111),
      .k9(32'b10111101110011111101111001100111)
  ) CON2D_66(
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
      .k1(32'b10111110000000100001110101010011),
      .k2(32'b10111101101100001000100111011011),
      .k3(32'b00111101100101110110100101110010),
      .k4(32'b10111101101101111100101111010010),
      .k5(32'b00111101111101100101010100111000),
      .k6(32'b00111101111111101100111111011010),
      .k7(32'b00111101111001010111000001111000),
      .k8(32'b00111101110101111011100101011001),
      .k9(32'b00111101100010111001000000110000)
  ) CON2D_67(
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
      .k1(32'b10111101010010010000010111111101),
      .k2(32'b10111100111101010111001011100010),
      .k3(32'b00111101100101110011010110110100),
      .k4(32'b00111110000001111110001001100100),
      .k5(32'b00111101001010110100101011101100),
      .k6(32'b10111100001100000100101000100110),
      .k7(32'b10111101110101001110100000100011),
      .k8(32'b00111101100011100001111001111011),
      .k9(32'b10111100111111011001101010110011)
  ) CON2D_68(
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
      .k1(32'b00111101101000001111010001101011),
      .k2(32'b10111101111111111101010100100001),
      .k3(32'b10111110000000001010101100110011),
      .k4(32'b10111100010010011000000110000101),
      .k5(32'b10111101100101011110001011011100),
      .k6(32'b10111101000110001110111000001001),
      .k7(32'b10111110000000000001100010010101),
      .k8(32'b10111101011000000100111001011111),
      .k9(32'b10111101100000111001100110111110)
  ) CON2D_69(
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
      .k1(32'b00111101000101101000101010011001),
      .k2(32'b00111100100000010001011100001100),
      .k3(32'b10111101111111011100100011001100),
      .k4(32'b10111101011010101100100001101101),
      .k5(32'b00111010001100101011000111010110),
      .k6(32'b00111101110111110010000010010101),
      .k7(32'b10111101110001100000110110111110),
      .k8(32'b00111100000011000010100101011111),
      .k9(32'b00111100101011110001000010111100)
  ) CON2D_70(
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
      .k1(32'b10111101110011000101010100011101),
      .k2(32'b10111101111001101111100100111010),
      .k3(32'b10111101110110111011101100011001),
      .k4(32'b00111101101000101010100101001110),
      .k5(32'b10111110001001101100110010111110),
      .k6(32'b10111100110100000100101000101111),
      .k7(32'b00111101111110110011111100100011),
      .k8(32'b00111101101101001110110100110101),
      .k9(32'b10111101111001111001010100110001)
  ) CON2D_71(
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
      .k1(32'b10111101101011100100100001110100),
      .k2(32'b00111100101110101010001001100010),
      .k3(32'b00111101110111000111100010111110),
      .k4(32'b00111101100100000111011001101101),
      .k5(32'b10111101111011000100010100011001),
      .k6(32'b00111101100110111010000001000101),
      .k7(32'b10111100100111100101111010111000),
      .k8(32'b00111010111111110010000010101111),
      .k9(32'b00111110000000101110101011101010)
  ) CON2D_72(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100101110110101011110011011),
      .k2(32'b10111101110100000001110010001101),
      .k3(32'b00111110000001000010110000001011),
      .k4(32'b00111100111010001001101110110100),
      .k5(32'b00111101000111100010100001000110),
      .k6(32'b10111101101011000010100111100001),
      .k7(32'b00111101100000001000100110010111),
      .k8(32'b00111101010101001010010011101111),
      .k9(32'b10111110000000101001011110000101)
  ) CON2D_73(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101010110100110111001001011),
      .k2(32'b10111101010001100001001111110000),
      .k3(32'b10111101010010100100110100100110),
      .k4(32'b10111101101100100011110101110011),
      .k5(32'b10111110000100111010100110001011),
      .k6(32'b10111101100000111111001010100001),
      .k7(32'b10111101000100010100110011110101),
      .k8(32'b00111011111100110001001011000100),
      .k9(32'b10111101001100111010101000101111)
  ) CON2D_74(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111001100000000011111100),
      .k2(32'b00111100111001000001111111011001),
      .k3(32'b10111101110001111010000111110000),
      .k4(32'b00111101100111101010001010101101),
      .k5(32'b10111101111011001011100101100011),
      .k6(32'b10111101100101101000101011100001),
      .k7(32'b10111101010110000010100001101000),
      .k8(32'b10111110000000010001000111001100),
      .k9(32'b10111011100001010111101010100001)
  ) CON2D_75(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101011010111001100001011110),
      .k2(32'b00111110000000110111001101101101),
      .k3(32'b10111101011100011000011111111011),
      .k4(32'b00111101110001111111111111001110),
      .k5(32'b10111101001111111010100001001111),
      .k6(32'b00111101100001010111100110000000),
      .k7(32'b00111101100111010110001011001010),
      .k8(32'b00111101101000010001100000000101),
      .k9(32'b00111110000001011100011100111101)
  ) CON2D_76(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101000010111111111011010111),
      .k2(32'b00111101111011100000001111111111),
      .k3(32'b10111101101000001011001011100100),
      .k4(32'b00111100100110010001000101010100),
      .k5(32'b00111101111100000110110111100101),
      .k6(32'b10111100111011101110001100000011),
      .k7(32'b10111101111110100010110111110110),
      .k8(32'b00111101010000011010001101001001),
      .k9(32'b00111101011011011110000101000111)
  ) CON2D_77(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100101111111100110110111101),
      .k2(32'b00111110000000010100110001100100),
      .k3(32'b00111101100100001011111100011011),
      .k4(32'b00111101111000000000001000101110),
      .k5(32'b10111011110101101001001001100111),
      .k6(32'b00111110000000111101010000001011),
      .k7(32'b00111110000110101110110110110010),
      .k8(32'b10111101100010011101011101000100),
      .k9(32'b00111100010111001000101101011010)
  ) CON2D_78(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101010001001110101000111101),
      .k2(32'b00111101011110100101010111011110),
      .k3(32'b10111011011100101000010100001000),
      .k4(32'b10111101000001010011101101100100),
      .k5(32'b10111010001110100000000011110110),
      .k6(32'b00111101101010001100010100011100),
      .k7(32'b10111101001000000010111111001110),
      .k8(32'b00111011110001000001000101011110),
      .k9(32'b10111101000000001001000101110100)
  ) CON2D_79(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111011100010101001100011101001),
      .k2(32'b10111101111110101001011011100010),
      .k3(32'b10111101001010100111101011100001),
      .k4(32'b00111101110010010011011111001110),
      .k5(32'b10111110000010111010011010000100),
      .k6(32'b10111110000001110111101010011101),
      .k7(32'b00111101100110111001110110010001),
      .k8(32'b10111100110010100101011111101100),
      .k9(32'b00111100000101001000011110101010)
  ) CON2D_80(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[4][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111011001110110111111001110101)
)   op5(
    .i_pipeline_layer4(i_CORE_IP1[4]), 
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
      .k1(32'b10111110000010100111011011100100),
      .k2(32'b10111101111111101000100110000010),
      .k3(32'b10111101001101010100100010000100),
      .k4(32'b00111100100010000111001101000100),
      .k5(32'b00111101000101101101000101011100),
      .k6(32'b10111101000100010001111000011011),
      .k7(32'b10111101101000010100110111110000),
      .k8(32'b00111100100101100100111010010001),
      .k9(32'b10111100110100100001011010010110)
  ) CON2D_81(
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
      .k1(32'b10111101100101100001101101101010),
      .k2(32'b00111101111111010000101000011010),
      .k3(32'b10111101100111010000111000100100),
      .k4(32'b00111101000111011101001011011101),
      .k5(32'b10111101101111001011001001111011),
      .k6(32'b10111101110100101001111111111000),
      .k7(32'b00111101001111100110111111000110),
      .k8(32'b00111101100011111111110001100110),
      .k9(32'b00111101010010111110101110110110)
  ) CON2D_82(
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
      .k1(32'b00111101000111010010110110000100),
      .k2(32'b10111110000011110101100110010010),
      .k3(32'b10111101010110000101010100101101),
      .k4(32'b10111101000111010011001101110100),
      .k5(32'b10111101001000111110110011100110),
      .k6(32'b00111100111000011100101001000101),
      .k7(32'b10111101000010001000010110100000),
      .k8(32'b00111110000001110001101111101001),
      .k9(32'b10110101110010001011101011111000)
  ) CON2D_83(
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
      .k1(32'b10111110000001100101100110011001),
      .k2(32'b00111101111001100100001111101000),
      .k3(32'b10111101101010101100000101101010),
      .k4(32'b10111101101110101001010101000110),
      .k5(32'b10111101100011000100011101001000),
      .k6(32'b10111101101110110100010011011111),
      .k7(32'b00111100100110000010011101110111),
      .k8(32'b10111110000100010000001111110000),
      .k9(32'b10111110000000111011010100111100)
  ) CON2D_84(
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
      .k1(32'b10111101000001110001111000111111),
      .k2(32'b10111101000111001101111011100110),
      .k3(32'b00111101110101010000110101010111),
      .k4(32'b10111101111000110001001100101000),
      .k5(32'b10111101111010110100011110110111),
      .k6(32'b00111101100111001011001110001001),
      .k7(32'b00111101100000111111110110110111),
      .k8(32'b10111110000000001101010011100000),
      .k9(32'b10111110000011111001101100010101)
  ) CON2D_85(
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
      .k1(32'b10111101101101000010011000001100),
      .k2(32'b00111101001101000011011101011011),
      .k3(32'b10111101010010101000101100010000),
      .k4(32'b10111101111110010011000001011111),
      .k5(32'b10111101111001111000101000011000),
      .k6(32'b00111100111000001100000011110110),
      .k7(32'b00111101110100101110011111011000),
      .k8(32'b00111110000010111001000110101011),
      .k9(32'b00111101101111101001110110101110)
  ) CON2D_86(
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
      .k1(32'b10111101011010001011100011101100),
      .k2(32'b00111101110010001111001000001001),
      .k3(32'b00111100101000010110111110001010),
      .k4(32'b00111101111011100110101010111001),
      .k5(32'b00111101010101001011011001010100),
      .k6(32'b00111101001001010101100010010100),
      .k7(32'b00111101110010101011001001011101),
      .k8(32'b10111101010010100101000010100000),
      .k9(32'b10111101100110110011110110100100)
  ) CON2D_87(
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
      .k1(32'b10111101010110100000010100111001),
      .k2(32'b10111101001101111010101110110001),
      .k3(32'b00111101101000111110001011010010),
      .k4(32'b10111100001110000000010101101010),
      .k5(32'b00111101101001010011101110000010),
      .k6(32'b00111101100100011101011100100011),
      .k7(32'b10111101110101100111101000011010),
      .k8(32'b10111101010101100001111011101000),
      .k9(32'b10111101001101001011111000011110)
  ) CON2D_88(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101101100010111000110110111),
      .k2(32'b00111101110100100111101110100110),
      .k3(32'b10111110000011111100111110010100),
      .k4(32'b00111100000110101110110000100100),
      .k5(32'b10111101000011000000011011010111),
      .k6(32'b10111101111000010000001001100000),
      .k7(32'b00111101010101000111001111010111),
      .k8(32'b10111101101011101000001011000111),
      .k9(32'b10111100111011100110001010101011)
  ) CON2D_89(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100110101110010100001001101),
      .k2(32'b10111100111001011100001100110010),
      .k3(32'b10111101001011000000100001001000),
      .k4(32'b00111100001101101000101101101000),
      .k5(32'b10111101011101010110100000000111),
      .k6(32'b00111101001000110000010110110110),
      .k7(32'b10111101010111110010011001100100),
      .k8(32'b00111110000110010011010110001101),
      .k9(32'b00111101011010100010010101010010)
  ) CON2D_90(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101110011100110011100111010),
      .k2(32'b00111101110100100011100010001101),
      .k3(32'b00111100110100101000001001011001),
      .k4(32'b00111101001101001000001101101100),
      .k5(32'b00111101111000100110010110000101),
      .k6(32'b00111100110110001001100100110011),
      .k7(32'b10111101110101011110101010111001),
      .k8(32'b00111101111110101110001101100010),
      .k9(32'b00111100000110101110001100011011)
  ) CON2D_91(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101100100001011101101101000),
      .k2(32'b00111100111001100110111101010110),
      .k3(32'b00111101101010001110111110011000),
      .k4(32'b10111101111010000110110000011011),
      .k5(32'b10111101011100011110010101111001),
      .k6(32'b00111010010111001010000000100010),
      .k7(32'b00111101110010001111101010001000),
      .k8(32'b10111101101110011111110110000111),
      .k9(32'b10111101110100010010100100010001)
  ) CON2D_92(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101011111100100010110011001),
      .k2(32'b00111110000011011111100110000101),
      .k3(32'b00111101100000010010110001010010),
      .k4(32'b00111110000010111011101100101101),
      .k5(32'b10111101110011111000011111111011),
      .k6(32'b00111101111100110110010110110101),
      .k7(32'b00111100110101110000101010110100),
      .k8(32'b00111101111110011011001101110001),
      .k9(32'b00111101101110110100111111001001)
  ) CON2D_93(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000001110010101110101101),
      .k2(32'b10111101010100011010010001110011),
      .k3(32'b10111110000011011000101110100111),
      .k4(32'b00111101111011111111110001001000),
      .k5(32'b10111101010011101101111100111100),
      .k6(32'b10111110000000000110001001100001),
      .k7(32'b10111101111101001100010110110011),
      .k8(32'b10111101100000110111010001011110),
      .k9(32'b00111101001111100111100011001101)
  ) CON2D_94(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101110111101100010010011000),
      .k2(32'b00111110000010111111110100010110),
      .k3(32'b10111110000010111010110011111011),
      .k4(32'b00111101110000010111100011011110),
      .k5(32'b00111101110010001111101111010001),
      .k6(32'b00111101111001000001100001101011),
      .k7(32'b10111110000000000001010101101011),
      .k8(32'b00111101111011001000000110100001),
      .k9(32'b00111101101010110010001100111000)
  ) CON2D_95(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101100001011011111011111110),
      .k2(32'b10111101101001011001000000100101),
      .k3(32'b10111101010001110110111010110001),
      .k4(32'b00111100010100000001011111100110),
      .k5(32'b00111110000001100101001011011110),
      .k6(32'b00111100011100001001010110010000),
      .k7(32'b10111101001001000101111000001010),
      .k8(32'b00111101101101110100011100010000),
      .k9(32'b00111101110000111000110011111111)
  ) CON2D_96(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[5][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111100000010100100110110000110)
)   op6(
    .i_pipeline_layer4(i_CORE_IP1[5]), 
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
      .k1(32'b00111101011100000001111000000010),
      .k2(32'b10111110000011000011000111001101),
      .k3(32'b10111101111011100110111010111110),
      .k4(32'b00111101011100101110111111101001),
      .k5(32'b10111101011010000011010110000100),
      .k6(32'b10111001001010110011001010101011),
      .k7(32'b00111100100010110100011100100100),
      .k8(32'b00111101111000111011000100101001),
      .k9(32'b00111101001101110100011110000111)
  ) CON2D_97(
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
      .k1(32'b00111101000100101111010101010110),
      .k2(32'b00111110000001000000011010101011),
      .k3(32'b00111101111100010110101100100100),
      .k4(32'b00111101010110000001110101100000),
      .k5(32'b00111011110001000000010000111101),
      .k6(32'b00111110000000111010000011101111),
      .k7(32'b00111101111000010010010000000100),
      .k8(32'b00111101111011110100010100000111),
      .k9(32'b00111101110011100001001110111110)
  ) CON2D_98(
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
      .k1(32'b10111110000001010111100101001110),
      .k2(32'b10111101100100011101011110000101),
      .k3(32'b10111101101000100001001001000001),
      .k4(32'b10111101111101010111011001111000),
      .k5(32'b00111100110000010001010100001111),
      .k6(32'b00111110000001101010110000110010),
      .k7(32'b10111101110110000110001101010001),
      .k8(32'b10111101110101101111110100100111),
      .k9(32'b10111101011001111101010011011000)
  ) CON2D_99(
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
      .k1(32'b00111101100000101011010011001000),
      .k2(32'b10111101010010111100101010101111),
      .k3(32'b10111101101111111110000001110010),
      .k4(32'b00111100001111011100011111101010),
      .k5(32'b00111100110110111001110111000110),
      .k6(32'b10111101000010101010001101101110),
      .k7(32'b10111101000010101011100000011110),
      .k8(32'b00111101101001011000100001000100),
      .k9(32'b00111110000000001100001000100011)
  ) CON2D_100(
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
      .k1(32'b00111100111001001010010111101110),
      .k2(32'b00111101001100101010100000011101),
      .k3(32'b10111110000000110000100000001100),
      .k4(32'b10111101110100111000011000111001),
      .k5(32'b10111110000011011000101010010100),
      .k6(32'b00111101111100110001100010100101),
      .k7(32'b10111101110010111000110101111011),
      .k8(32'b10111100010111111111101000001011),
      .k9(32'b10111011100000100000111101000000)
  ) CON2D_101(
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
      .k1(32'b10111101011111100000101001001110),
      .k2(32'b10111100010110010011101010001010),
      .k3(32'b00111101101011000100011001110010),
      .k4(32'b00111110000010011100010100110011),
      .k5(32'b00111101001101000111010100100100),
      .k6(32'b00111101001010100011101110010011),
      .k7(32'b10111011010010101010000011011110),
      .k8(32'b10111101100000111111100111111001),
      .k9(32'b10111101101001111111110010110010)
  ) CON2D_102(
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
      .k1(32'b10111100110111010110011000100101),
      .k2(32'b00111101011100111111100110110010),
      .k3(32'b00111110000010011111111111110111),
      .k4(32'b10111101111010011011001001101111),
      .k5(32'b00111100011011111001010000010010),
      .k6(32'b00111101000000011111001010111110),
      .k7(32'b00111011101101111011000001010100),
      .k8(32'b10111110000010111100010001010100),
      .k9(32'b00111101001110011100011010011111)
  ) CON2D_103(
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
      .k1(32'b10111101100100011000100011000010),
      .k2(32'b00111110000010110001011001001110),
      .k3(32'b10111101110111000101110011101011),
      .k4(32'b00111110000011011110110010000110),
      .k5(32'b00111101010010111000010101101111),
      .k6(32'b00111100001001101111110011000011),
      .k7(32'b00111101000000011001100010101011),
      .k8(32'b10111101000110010111100011110001),
      .k9(32'b00111101111110100010001000100111)
  ) CON2D_104(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000001100111010001101101),
      .k2(32'b10111100100000111010100001110011),
      .k3(32'b10111101101001011011101110100101),
      .k4(32'b00111101001100110110101000011110),
      .k5(32'b00111110000010000100000111011001),
      .k6(32'b00111100011000110110101000101011),
      .k7(32'b10111101011000010001111000100101),
      .k8(32'b00111110000000000101111001001000),
      .k9(32'b00111101111000100000010111110010)
  ) CON2D_105(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100000100000010111001001110),
      .k2(32'b10111101101000010101110110011001),
      .k3(32'b10111011111101010110011001101110),
      .k4(32'b10111101100000010001100111010110),
      .k5(32'b10111101001111010011010111011111),
      .k6(32'b10111110000010111110001100001111),
      .k7(32'b10111101000001000100101001001001),
      .k8(32'b10111101000110101001011011011001),
      .k9(32'b00111101011010011111000110010001)
  ) CON2D_106(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000001101001001011010100),
      .k2(32'b00111110000000110101101101101010),
      .k3(32'b10111100111010011111010010110111),
      .k4(32'b10111010100111001000000110000111),
      .k5(32'b00111100000001100100111000011110),
      .k6(32'b00111101111001100010100110111001),
      .k7(32'b10111100111010110111111011100011),
      .k8(32'b00111101111100011001110010011000),
      .k9(32'b00111110000001011101000111010110)
  ) CON2D_107(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101011000110110001111011000),
      .k2(32'b10111010110111100000110110011100),
      .k3(32'b10111101011011101011100100011011),
      .k4(32'b00111101100000101111011010111100),
      .k5(32'b00111010001110100001010100110010),
      .k6(32'b10111100011101011001100001111011),
      .k7(32'b10111101101101111110001111100010),
      .k8(32'b10111101110000100111101011010110),
      .k9(32'b10111101010111101101011111011010)
  ) CON2D_108(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101110100110111100001001011),
      .k2(32'b10111110000100101000100011110110),
      .k3(32'b00111100100111011101111101111011),
      .k4(32'b00111101000100010000000101001111),
      .k5(32'b00111101111010111110000110001100),
      .k6(32'b00111101111100001010100111000110),
      .k7(32'b00111101111100100101000001001100),
      .k8(32'b00111110000011100011010101010111),
      .k9(32'b10111101111110110010110101011011)
  ) CON2D_109(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101111000010110110101001001),
      .k2(32'b10111101110010010110100001001100),
      .k3(32'b10111110000110100110011110110001),
      .k4(32'b00111100101111101110110001111010),
      .k5(32'b10111100001001101110000010111001),
      .k6(32'b00111101001100000011001101111000),
      .k7(32'b10111110000100111111010101100001),
      .k8(32'b10111110000111111110100100111010),
      .k9(32'b10111100000111000110010000000111)
  ) CON2D_110(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000101001101010011100101),
      .k2(32'b00111100100000110111111011101100),
      .k3(32'b00111101110101111000001111101010),
      .k4(32'b10111101100111001111001110100110),
      .k5(32'b10111101101110100101000111011010),
      .k6(32'b00111101100000100110000011010101),
      .k7(32'b00111101101001101110101011100100),
      .k8(32'b10111101001110010010010111010111),
      .k9(32'b10111101011000010000100010001011)
  ) CON2D_111(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000010100010000011010011),
      .k2(32'b00111110000110010101001111000010),
      .k3(32'b00111101001010000010000100111011),
      .k4(32'b10111001001000010011110011111010),
      .k5(32'b00111100101000100110111101100000),
      .k6(32'b00111101100100011111110001111101),
      .k7(32'b00111101000010001011100101000001),
      .k8(32'b00111100110110111100101000011101),
      .k9(32'b00111101001110010110101110111100)
  ) CON2D_112(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[6][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111011110101011011100101010100)
)   op7(
    .i_pipeline_layer4(i_CORE_IP1[6]), 
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
      .k1(32'b10111100111101001101111100011000),
      .k2(32'b00111100110100001001010110000010),
      .k3(32'b00111101111110110111010011101000),
      .k4(32'b00111110000011111101101001010110),
      .k5(32'b00111101100000100101001110100000),
      .k6(32'b00111101101001011010101011010101),
      .k7(32'b10111101100101101100011111010100),
      .k8(32'b10111101001101010101111001000000),
      .k9(32'b10111101011000000011110000000000)
  ) CON2D_113(
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
      .k1(32'b10111100100011010000111101100010),
      .k2(32'b00111100010010011001010110001110),
      .k3(32'b10111100101010101001110011110010),
      .k4(32'b10111110000110100101010111100110),
      .k5(32'b10111101101011010100110000100100),
      .k6(32'b00111101111011111101111111010110),
      .k7(32'b10111110001000101100101010001111),
      .k8(32'b10111101101010110001110100010101),
      .k9(32'b10111101100011001011000111010001)
  ) CON2D_114(
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
      .k1(32'b10111011111000110011101100110010),
      .k2(32'b00111110000000100001110001001100),
      .k3(32'b00111101110101111010110101001001),
      .k4(32'b00111110000100010001101000000001),
      .k5(32'b00111100000100011101001001010000),
      .k6(32'b00111101100010010110010110100111),
      .k7(32'b00111101111110011000011110101100),
      .k8(32'b00111011100010010101100011111000),
      .k9(32'b00111101100001001011011001110001)
  ) CON2D_115(
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
      .k1(32'b00111101100110101100010001111110),
      .k2(32'b00111101101010000000011111110000),
      .k3(32'b00111101011110110111000110101101),
      .k4(32'b10111101101001100010011000010110),
      .k5(32'b00111101001110110011111010001001),
      .k6(32'b10111101001110010100111011000010),
      .k7(32'b00111101101101101110010111111110),
      .k8(32'b10111101001001111011001101111110),
      .k9(32'b10111101011011011000100101110010)
  ) CON2D_116(
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
      .k1(32'b00111100001110101001000101111000),
      .k2(32'b00111101110001101110010101001010),
      .k3(32'b00111101111001100110010110011011),
      .k4(32'b10111101110100001001000101000110),
      .k5(32'b00111101111000010001110111110010),
      .k6(32'b00111101001001100000110001001000),
      .k7(32'b00111110000100111011111100110000),
      .k8(32'b00111101011100010101000110011011),
      .k9(32'b00111110000010000001100110000100)
  ) CON2D_117(
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
      .k1(32'b00111101111000011000001100110000),
      .k2(32'b10111101100011000110010101110000),
      .k3(32'b00111101111101010101000010000111),
      .k4(32'b10111101110001011011011110111100),
      .k5(32'b10111110000010111001001010000111),
      .k6(32'b10111101110010011111000101111001),
      .k7(32'b10111101111000010110101000110001),
      .k8(32'b10111100111011100110001101111111),
      .k9(32'b10111101000011001011001001101101)
  ) CON2D_118(
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
      .k1(32'b00111101011000001011111001110110),
      .k2(32'b10111101001011100110001010100001),
      .k3(32'b10111101001100010100001110011010),
      .k4(32'b10111110000111101110101000000111),
      .k5(32'b10111110001000110010100110011010),
      .k6(32'b10111101011110110111111111011010),
      .k7(32'b00111101000001100010110111000011),
      .k8(32'b00111100111101101100000001101111),
      .k9(32'b10111101100111101111001101100111)
  ) CON2D_119(
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
      .k1(32'b10111101110111010011101000011111),
      .k2(32'b10111110000100010111010010111001),
      .k3(32'b10111101001110111011111111011001),
      .k4(32'b10111100010101111011011110100011),
      .k5(32'b10111100111010000000001011011010),
      .k6(32'b10111101100010111100100100100110),
      .k7(32'b00111101101011000000000110011101),
      .k8(32'b10111101100100010010011110101010),
      .k9(32'b10111100111011011111001000000100)
  ) CON2D_120(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101011011001100110101101100),
      .k2(32'b10111101110000101010011111101110),
      .k3(32'b00111010100001111000110101100010),
      .k4(32'b10111101001100010011111010001011),
      .k5(32'b10111110000010101010111001100101),
      .k6(32'b00111100001111011000000010011101),
      .k7(32'b10111110000010111101010101100111),
      .k8(32'b00111101011100110110110000001001),
      .k9(32'b10111110000001101000100100010011)
  ) CON2D_121(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101010100101100100100000),
      .k2(32'b10111100010010100111111110011011),
      .k3(32'b00111100111100011101100110001100),
      .k4(32'b10111101100010111010100110110010),
      .k5(32'b10111101111110011000101010001111),
      .k6(32'b00111101100001100000001111101111),
      .k7(32'b10111101100110000101011000101001),
      .k8(32'b00111100111111011001100111100101),
      .k9(32'b10111110000100110110110100000000)
  ) CON2D_122(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101101100011000000100101001),
      .k2(32'b10111101111101101110101100100010),
      .k3(32'b00111011010000000110111011111010),
      .k4(32'b00111101111101101010110100100000),
      .k5(32'b00111110000101010000011001001000),
      .k6(32'b10111101111001001111000000011001),
      .k7(32'b10111100101111101110110101011010),
      .k8(32'b10111101111100110110001111011101),
      .k9(32'b10111101000001111001100011001010)
  ) CON2D_123(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101101010100101000111100001),
      .k2(32'b00111101010011100010111000000100),
      .k3(32'b00111101101100100011110101001010),
      .k4(32'b00111101100101010001110000110011),
      .k5(32'b00111110000010111110101110100101),
      .k6(32'b10111110000101001111000100111101),
      .k7(32'b10111101110000001011111001110100),
      .k8(32'b10111101010011110111111110110001),
      .k9(32'b10111101011000110101100110100111)
  ) CON2D_124(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101110011000111100010110110),
      .k2(32'b10111101111010110000100001000001),
      .k3(32'b00111101001100110011001110001101),
      .k4(32'b00111100001100101100001100001000),
      .k5(32'b00111101100101001101001011011111),
      .k6(32'b00111101110101110000111111101011),
      .k7(32'b00111101100110100001110011000011),
      .k8(32'b10111101111000101100011111001010),
      .k9(32'b10111101101111111011010111001111)
  ) CON2D_125(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101001101111100111110111100),
      .k2(32'b00111101011111110000110011010101),
      .k3(32'b10111101110110101001110011111111),
      .k4(32'b10111101111110011010100101001101),
      .k5(32'b00111100111010101001010100001100),
      .k6(32'b10111110000101110100110000011011),
      .k7(32'b00111101011100000011000100000001),
      .k8(32'b00111101111010010001101000011001),
      .k9(32'b00111101110110101000110101000001)
  ) CON2D_126(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000001101000010101111011),
      .k2(32'b10111110000000110111000111010101),
      .k3(32'b00111101000101010111110111110101),
      .k4(32'b00111101111110000000101100001101),
      .k5(32'b00111101111110111011011000100111),
      .k6(32'b10111101100000111110011100000010),
      .k7(32'b10111101110111101010101010100110),
      .k8(32'b10111101010000000100011011110100),
      .k9(32'b10111100110110100011100001000000)
  ) CON2D_127(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100101000100001000110011010),
      .k2(32'b00111101101101101010011000001101),
      .k3(32'b00111011010101000010000011100111),
      .k4(32'b00111110000011011011001011010101),
      .k5(32'b00111101000101110011010010111110),
      .k6(32'b10111101101011000110111010110000),
      .k7(32'b00111101111110100000011100000111),
      .k8(32'b00111100100111110101011111111001),
      .k9(32'b10111101101011011101000110011111)
  ) CON2D_128(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[7][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111100000111001000000101101101)
)   op8(
    .i_pipeline_layer4(i_CORE_IP1[7]), 
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

/// CON2D_9///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101010101101011000001110110),
      .k2(32'b00111010100011110000010001110011),
      .k3(32'b10111101010100011110111000111011),
      .k4(32'b10111101101111010011011100010110),
      .k5(32'b00111100111000111100011110100010),
      .k6(32'b00111101100101011101100000000110),
      .k7(32'b10111101011110001001010000110111),
      .k8(32'b00111110000000010110100001010100),
      .k9(32'b00111101100111111001111010100101)
  ) CON2D_129(
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
      .k1(32'b00111110000010111101011011001110),
      .k2(32'b10111101110110000111111111011000),
      .k3(32'b10111101100010001011110110100011),
      .k4(32'b00111101100101000110111000111010),
      .k5(32'b10111101100111000011101000101111),
      .k6(32'b00111110000010101011001010010010),
      .k7(32'b00111101110010111100011111111110),
      .k8(32'b00111100110010101010110001011010),
      .k9(32'b10111101111101101010110110001010)
  ) CON2D_130(
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
      .k1(32'b10111110000000110101111000010010),
      .k2(32'b10111101011100100101101101111011),
      .k3(32'b00111110000000011001111000110111),
      .k4(32'b10111101010111111011000101000011),
      .k5(32'b00111101100111010010111110111010),
      .k6(32'b10111101011100011101111100101010),
      .k7(32'b10111101011011010101100000101111),
      .k8(32'b00111100010011010011001111101110),
      .k9(32'b00111101101011000001001101011000)
  ) CON2D_131(
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
      .k1(32'b10111100011111011101110011110001),
      .k2(32'b10111101110101110011101101001000),
      .k3(32'b00111101111101100111011110001010),
      .k4(32'b00111101110100110010110001110101),
      .k5(32'b10111100110011000011011010011111),
      .k6(32'b00111101110100100101010101000110),
      .k7(32'b00111110000000010011100110110111),
      .k8(32'b00111010001011000111100111100110),
      .k9(32'b00111101000000100110110000111100)
  ) CON2D_132(
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
      .k1(32'b00111101100001001110011100001101),
      .k2(32'b00111100100100001001011101101000),
      .k3(32'b00111101010010001001010100010011),
      .k4(32'b10111100001100001011110011100101),
      .k5(32'b10111101000100100110100101001111),
      .k6(32'b10111101001000111000001100000000),
      .k7(32'b10111101110100100010001101010010),
      .k8(32'b10111110000000001011101100110111),
      .k9(32'b00111101101001000011001011110111)
  ) CON2D_133(
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
      .k1(32'b10111100101001110000101110111101),
      .k2(32'b10111101100100101010001001010001),
      .k3(32'b00111101110011010011100001100100),
      .k4(32'b00111101111100010010010000100001),
      .k5(32'b00111110000010111101001100100011),
      .k6(32'b00111101000101000011111000101001),
      .k7(32'b00111110000111001110111100011011),
      .k8(32'b00111101100100001001110110010000),
      .k9(32'b10111101010000010101010001000000)
  ) CON2D_134(
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
      .k1(32'b00111101110001000001100110010010),
      .k2(32'b00111110001001001110111001011110),
      .k3(32'b10111100010101011011011001001100),
      .k4(32'b00111101000011110010000011011111),
      .k5(32'b00111101001001000110110100110100),
      .k6(32'b00111110001001100010011111111011),
      .k7(32'b10111101001101010110111100010111),
      .k8(32'b10111100000110100110001000001100),
      .k9(32'b00111101001001111010100001111101)
  ) CON2D_135(
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
      .k1(32'b10111100000111001100101010000011),
      .k2(32'b10111101111101110001001101100101),
      .k3(32'b00111100111111110000111011100101),
      .k4(32'b10111110001001100101100001000000),
      .k5(32'b00111100111111001110001011001000),
      .k6(32'b00111011110010011011110010101010),
      .k7(32'b10111101111110001000010000010001),
      .k8(32'b00111100000101010011101111100101),
      .k9(32'b10111101100101011110010100111100)
  ) CON2D_136(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111101111110011101110000),
      .k2(32'b10111100010101001000000000011101),
      .k3(32'b10111101001011100110000110011011),
      .k4(32'b10111101111001101100001001101110),
      .k5(32'b00111100100000001111110110010000),
      .k6(32'b10111101111001110100110100111101),
      .k7(32'b10111101101111000110010010001101),
      .k8(32'b10111101111100111111010111000001),
      .k9(32'b00111101111111000100110000101110)
  ) CON2D_137(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101001101011100011101011101),
      .k2(32'b10111101101010110111111111000001),
      .k3(32'b00111101111110110111001010101110),
      .k4(32'b00111101001110011110011110001010),
      .k5(32'b10111101110010111110010001110110),
      .k6(32'b10111100000011101111011110110101),
      .k7(32'b00111101010001010000001001101101),
      .k8(32'b10111101101010011100111001001001),
      .k9(32'b10111100111100101011010011111010)
  ) CON2D_138(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100011011111001011010101111),
      .k2(32'b00111101111011111000110101000001),
      .k3(32'b00111101001110100101010010110100),
      .k4(32'b10111110000001000011011000010000),
      .k5(32'b10111101100111000010010110010000),
      .k6(32'b00111101011010000000101011000010),
      .k7(32'b00111101110100011000100010001100),
      .k8(32'b00111010110111111011010111111000),
      .k9(32'b10111110000011110101111101000101)
  ) CON2D_139(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101100000110100000001001011),
      .k2(32'b10111110000010111101110110111001),
      .k3(32'b10111101111101000011001111000010),
      .k4(32'b00111101101001110100110011011110),
      .k5(32'b00111100100101000000101110110011),
      .k6(32'b10111011010111010111011101110110),
      .k7(32'b10111101101011111110111100000010),
      .k8(32'b10111101101110001110010001010010),
      .k9(32'b10111101010010000101111011110000)
  ) CON2D_140(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111111111010001011000011),
      .k2(32'b00111101001010011100111011101000),
      .k3(32'b00111101000001100110001100100000),
      .k4(32'b10111101101000001001110011011110),
      .k5(32'b00111101010111010011111001110001),
      .k6(32'b10111101101001100000110100010010),
      .k7(32'b00111101111111110010001111011011),
      .k8(32'b00111101101011011111001011101111),
      .k9(32'b10111101000111010110101111001010)
  ) CON2D_141(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111011001001100110111000),
      .k2(32'b00111101011000011010011001001111),
      .k3(32'b00111100011110011100011101010001),
      .k4(32'b10111100111101110111110100001010),
      .k5(32'b00111101100110001110011010000111),
      .k6(32'b00111101001000000101111000000111),
      .k7(32'b00111100100011100101001100001101),
      .k8(32'b10111110000011010001110010011100),
      .k9(32'b10111101111011100001100000100111)
  ) CON2D_142(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101111101101001110111101000),
      .k2(32'b00111101100000110010111111010001),
      .k3(32'b10111101110011100100000100011010),
      .k4(32'b00111100010101000100001001001011),
      .k5(32'b00111101110110111100110101100010),
      .k6(32'b00111110000010000001001110010000),
      .k7(32'b10111101100100110101100110110000),
      .k8(32'b00111101110101011110011010000111),
      .k9(32'b00111011110010011011100111100111)
  ) CON2D_143(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101100111110011011010001011),
      .k2(32'b00111101111111000010011011100101),
      .k3(32'b10111101101001101110001011010100),
      .k4(32'b00111101110001100000100001011110),
      .k5(32'b00111110000000111101011011110010),
      .k6(32'b00111101101010110100000100001101),
      .k7(32'b10111101100101011100100010010100),
      .k8(32'b00111110000001000101000101101100),
      .k9(32'b00111100111000010111011001000101)
  ) CON2D_144(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[8][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111100100010111101101100110100)
)   op9(
    .i_pipeline_layer4(i_CORE_IP1[8]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*9-1:DATA_WIDTH*8])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling9(
    .i_data(i_CORE_IP2[DATA_WIDTH*9-1:DATA_WIDTH*8]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

/// CON2D_10///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111010001000101100101100100000),
      .k2(32'b10111100110101010001110000010101),
      .k3(32'b10111101010001000010100010111010),
      .k4(32'b00111101101000111010110111011010),
      .k5(32'b00111101101010000100111001101101),
      .k6(32'b10111101010000110011001010001010),
      .k7(32'b00111110000101110101110110110001),
      .k8(32'b00111101100111001100111001111110),
      .k9(32'b00111101100100011010111111110010)
  ) CON2D_145(
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
      .k1(32'b00111101001010101110011010110101),
      .k2(32'b00111101101100110011000111011111),
      .k3(32'b00111101111000110101101001101101),
      .k4(32'b10111110000000011111111011111010),
      .k5(32'b00111101100000010101000010010010),
      .k6(32'b10111011001111110010001101101101),
      .k7(32'b00111100110110101011110010010001),
      .k8(32'b10111101110010100100100011000011),
      .k9(32'b10111101010001000101001101100000)
  ) CON2D_146(
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
      .k1(32'b00111101101000011000101010001010),
      .k2(32'b10111101001000010000101101001000),
      .k3(32'b00111101100010001101101011101101),
      .k4(32'b10111101010100101001110111100101),
      .k5(32'b00111101010100001010010111110010),
      .k6(32'b00111100110101000101110100111101),
      .k7(32'b10111101101010010011001011001011),
      .k8(32'b10111100110111011000010110110110),
      .k9(32'b00111100001001011111010000000110)
  ) CON2D_147(
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
      .k1(32'b00111011110101011111000001011010),
      .k2(32'b10111011110100110101010011010000),
      .k3(32'b10111101100000100101101101010011),
      .k4(32'b00111101101001000001010001000000),
      .k5(32'b00111101110011000100001110011011),
      .k6(32'b00111100110100000111101101011111),
      .k7(32'b00111100011011111010111011011100),
      .k8(32'b10111101001111000000110100100011),
      .k9(32'b00111101110101011001110000011111)
  ) CON2D_148(
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
      .k1(32'b00111110000010111110001010000111),
      .k2(32'b00111100011000100111111000000010),
      .k3(32'b10111110000001110100100011001010),
      .k4(32'b10111101101001101110010001101000),
      .k5(32'b00111110000100100011000101101101),
      .k6(32'b00111101111101101101111000100111),
      .k7(32'b10111101111011101000011010110001),
      .k8(32'b00111110000011001010100110011110),
      .k9(32'b10111101001001110100001011011011)
  ) CON2D_149(
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
      .k1(32'b00111100111011100110000010010001),
      .k2(32'b10111100100100100011000000010101),
      .k3(32'b00111110000001011011001100111010),
      .k4(32'b00111101001001001011110011010010),
      .k5(32'b00111101000001000101010011011110),
      .k6(32'b10111100101110100000100111101000),
      .k7(32'b10111110001000101101101101001101),
      .k8(32'b10111101100001110011000011011000),
      .k9(32'b00111101101011101111110111011011)
  ) CON2D_150(
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
      .k1(32'b00111101101010000000100110011001),
      .k2(32'b00111101110101000010001001000101),
      .k3(32'b00111110000011011100111011101011),
      .k4(32'b10111011111001100101000000100110),
      .k5(32'b00111101000110100110101101000000),
      .k6(32'b10111101001100110000010011010111),
      .k7(32'b10111101100101011010011100000010),
      .k8(32'b00111101010111101101011100110101),
      .k9(32'b00111101000011010000100111010101)
  ) CON2D_151(
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
      .k1(32'b00111101111101000101101110011000),
      .k2(32'b00111101000001111110111011100111),
      .k3(32'b10111100001000010110111011110011),
      .k4(32'b00111101100001011011001000010110),
      .k5(32'b10111101111010101010010100110000),
      .k6(32'b00111101011000111111010001111101),
      .k7(32'b00111101111010100101001001111000),
      .k8(32'b10111101001010011111001010100011),
      .k9(32'b10111101100100110011010010111110)
  ) CON2D_152(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000010101000000011000001),
      .k2(32'b00111101100100111111111111110100),
      .k3(32'b00111101111000000001000011100010),
      .k4(32'b10111101010000100001010110001110),
      .k5(32'b10111101100011100101001011101100),
      .k6(32'b10111101010011101010111011111110),
      .k7(32'b00111010110010000000110111011011),
      .k8(32'b00111110000001010101101000010001),
      .k9(32'b00111101100010010111101110110001)
  ) CON2D_153(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111100001100010000110011),
      .k2(32'b10111101111000101011000100000111),
      .k3(32'b10111101100110011001000011111100),
      .k4(32'b10111110000010001010011110101111),
      .k5(32'b10111101110101011101010000100110),
      .k6(32'b10111101111100100110001100010101),
      .k7(32'b00111101001001010101101110100111),
      .k8(32'b00111100001101111111101111111100),
      .k9(32'b10111100001011111010101101001000)
  ) CON2D_154(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101100011000100110010100110),
      .k2(32'b00111110000010001110100101011110),
      .k3(32'b00111101001100101011101101000110),
      .k4(32'b00111101111101011001001011110110),
      .k5(32'b00111101111101011110011101001110),
      .k6(32'b10111101110001101100001100010000),
      .k7(32'b00111101010001011111001011000110),
      .k8(32'b10111101101011000100001000001100),
      .k9(32'b00111101001110011011100100110111)
  ) CON2D_155(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111011100011000001001010100011),
      .k2(32'b00111110000011000000111010110001),
      .k3(32'b00111101011000000101100101001110),
      .k4(32'b00111101010001101011010110101001),
      .k5(32'b10111101100001101101101011011011),
      .k6(32'b10111101011101100000011101011001),
      .k7(32'b10111101011110001111011010111111),
      .k8(32'b10111101111111010100110010010000),
      .k9(32'b10111101001001111000000101000000)
  ) CON2D_156(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101101101110010100101011),
      .k2(32'b00111101101100010101011010010110),
      .k3(32'b00111101101010100100010011011010),
      .k4(32'b00111101110110011001011110101110),
      .k5(32'b10111110000010111110110011000101),
      .k6(32'b10111110000101001111110000100010),
      .k7(32'b00111101011010100100100100100000),
      .k8(32'b10111100111111000111101000100110),
      .k9(32'b00111101110100100100100010001001)
  ) CON2D_157(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100100000110011011110111000),
      .k2(32'b00111110000011011000110110101010),
      .k3(32'b10111101100001000100011000011000),
      .k4(32'b00111110000011111000111100010000),
      .k5(32'b10111101010000111111101111110001),
      .k6(32'b00111101100010011100010100101101),
      .k7(32'b10111101000010010110111101000111),
      .k8(32'b10111101100010100110001001001010),
      .k9(32'b10111100101001011010000001111000)
  ) CON2D_158(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100110110011111010110100111),
      .k2(32'b10111100110111111101101110011101),
      .k3(32'b00111101100110110001111010001001),
      .k4(32'b00111101110101001100011100010101),
      .k5(32'b10111101110001110011000011001010),
      .k6(32'b00111100111010011101001110100100),
      .k7(32'b10111100011010110001111000000010),
      .k8(32'b10111100000010100100111010110101),
      .k9(32'b10111101001010011010001111110100)
  ) CON2D_159(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000110010000110100010011),
      .k2(32'b00111100110100011111110010101101),
      .k3(32'b00111101110111010100101001110100),
      .k4(32'b10111101111111000000111101111100),
      .k5(32'b00111100110010101101100001011111),
      .k6(32'b10111011101110100010011111110111),
      .k7(32'b10111101111111100011101110000000),
      .k8(32'b10111101111011101111011101110011),
      .k9(32'b00111101100010011010111101011011)
  ) CON2D_160(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[9][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111011001110010001100001111010)
)   op10(
    .i_pipeline_layer4(i_CORE_IP1[9]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*10-1:DATA_WIDTH*9])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling10(
    .i_data(i_CORE_IP2[DATA_WIDTH*10-1:DATA_WIDTH*9]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

/// CON2D_11///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101110111001011111101100111),
      .k2(32'b00111101101101111000011001001010),
      .k3(32'b00111110000100110010001101100101),
      .k4(32'b10111100100001111101100011001110),
      .k5(32'b00111101101001110011000111110011),
      .k6(32'b10111101111001101011010101111110),
      .k7(32'b10111101101111111101001010100100),
      .k8(32'b00111101111000000100010101001011),
      .k9(32'b10111101100101010011011101001001)
  ) CON2D_161(
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
      .k1(32'b00111101101100001110111101110111),
      .k2(32'b00111101001110110110000011101011),
      .k3(32'b10111101010101100100111111110110),
      .k4(32'b10111100001110101011110010001000),
      .k5(32'b00111101100101100110010111111110),
      .k6(32'b10111101100101001000100001011111),
      .k7(32'b00111101101110001010011000011111),
      .k8(32'b10111110000010001011111000001001),
      .k9(32'b10111101111000111100010001101000)
  ) CON2D_162(
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
      .k1(32'b10111110000011110011010010100000),
      .k2(32'b10111101011111010000010010000101),
      .k3(32'b10111110000000001110010010101011),
      .k4(32'b00111100010110100111010011001101),
      .k5(32'b00111101111001110000111010101101),
      .k6(32'b00111100100111001110111101111111),
      .k7(32'b00111101101011100100010011100101),
      .k8(32'b10111101000011100010010001011100),
      .k9(32'b00111101111101001001001001111010)
  ) CON2D_163(
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
      .k1(32'b00111101001101010110011100101101),
      .k2(32'b00111101111000100001000101010000),
      .k3(32'b00111100111010001010000000011010),
      .k4(32'b00111101101010000111111101000010),
      .k5(32'b00111100110000100010101001011101),
      .k6(32'b10111100101110100001011100000000),
      .k7(32'b10111101110101110011111010001100),
      .k8(32'b10111101110010001001011011010101),
      .k9(32'b00111101101011000000101001000111)
  ) CON2D_164(
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
      .k1(32'b10111101011111011110010000100010),
      .k2(32'b10111100100101010010101101011110),
      .k3(32'b00111101011010111011111111111011),
      .k4(32'b00111100110101001010111011110111),
      .k5(32'b00111101101001001100001110100111),
      .k6(32'b10111101110101110110110000010011),
      .k7(32'b10111100100110000111111011011011),
      .k8(32'b00111100011000110001011110111000),
      .k9(32'b00111100111111000100111111110101)
  ) CON2D_165(
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
      .k1(32'b10111101101111001110111000110100),
      .k2(32'b00111101001010001110011100011101),
      .k3(32'b00111101110110100110011111101111),
      .k4(32'b10111110000011000011110001010100),
      .k5(32'b00111110000010011100010111001110),
      .k6(32'b00111011110111111111010111100110),
      .k7(32'b10111110000000001010011000110111),
      .k8(32'b10111101101110100011000000011000),
      .k9(32'b10111101111110001000000101011100)
  ) CON2D_166(
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
      .k1(32'b00111101100011010001101011000101),
      .k2(32'b00111101001111011100001100100110),
      .k3(32'b00111101101001011110111000101110),
      .k4(32'b00111101000100101111000110101100),
      .k5(32'b00111101110000110011110110010101),
      .k6(32'b10111101011010101001001101100100),
      .k7(32'b10111101010001000011101111011100),
      .k8(32'b10111110000100110000110110100000),
      .k9(32'b00111101010101111110101011101001)
  ) CON2D_167(
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
      .k1(32'b10111101000010011110101101111001),
      .k2(32'b10111101001110101100010110000100),
      .k3(32'b00111101000010001011001010010000),
      .k4(32'b10111101110001100000000100011011),
      .k5(32'b00111101100011101101111100101001),
      .k6(32'b00111101110111110100011010101011),
      .k7(32'b10111101110000110101100100110001),
      .k8(32'b00111101101100110100100011101000),
      .k9(32'b10111101101100011111100001110111)
  ) CON2D_168(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000000110000001000100000),
      .k2(32'b10111101010111001001101011101011),
      .k3(32'b10111101110111010000111100101101),
      .k4(32'b10111110001000011001001101101101),
      .k5(32'b10111110000001010100101011001110),
      .k6(32'b00111101110000000111001010010100),
      .k7(32'b00111101011000100010011010111010),
      .k8(32'b10111110000000001011001100010011),
      .k9(32'b10111101000010011101100111100001)
  ) CON2D_169(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111010111110111101011111),
      .k2(32'b00111011100110101100010110111010),
      .k3(32'b10111100011011110000101101011110),
      .k4(32'b10111101110011011010101101101010),
      .k5(32'b00111110000100001100001011000110),
      .k6(32'b00111110000010001001011001010111),
      .k7(32'b10111101011000110001100100100011),
      .k8(32'b10111010000110110101010100110111),
      .k9(32'b00111101110100100000011001111101)
  ) CON2D_170(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101000111100100100000011111),
      .k2(32'b10111101101010100101010111011101),
      .k3(32'b00111101001011110110100010010110),
      .k4(32'b10111100100000110000001110110100),
      .k5(32'b00111100110100111100010010000110),
      .k6(32'b10111101001100110001001011011100),
      .k7(32'b10111101010011100110010011011100),
      .k8(32'b00111110000100111111110100000010),
      .k9(32'b00111101101100101111011110110111)
  ) CON2D_171(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101001001001101111010100010),
      .k2(32'b10111101110000100110101001111010),
      .k3(32'b10111101110011111100010011101110),
      .k4(32'b10111100010101110111111011111111),
      .k5(32'b10111101111000000001110101111001),
      .k6(32'b00111101100001000100000000001111),
      .k7(32'b10111100101010010001001101000111),
      .k8(32'b00111101100100010001111001110010),
      .k9(32'b10111100101101100010110010011100)
  ) CON2D_172(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100011100011100110100001001),
      .k2(32'b00111101110111001011101101100100),
      .k3(32'b10111101001001101010011111001111),
      .k4(32'b00111101110100011000110110001101),
      .k5(32'b10111101110001000101101001000111),
      .k6(32'b10111101011000011010101001011110),
      .k7(32'b00111101010011011110001000110101),
      .k8(32'b00111101111110000110000100111010),
      .k9(32'b10111101111101100000010101100000)
  ) CON2D_173(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101000110101101010011101010),
      .k2(32'b00111101001100010110010010100101),
      .k3(32'b10111101001000101001000011011011),
      .k4(32'b10111100110011111111101110001101),
      .k5(32'b10111101100000100111000010111000),
      .k6(32'b10111101111001000110111001111101),
      .k7(32'b10111101101011111001001101110010),
      .k8(32'b10111101001111101110011111100110),
      .k9(32'b10111100101010010001100100111110)
  ) CON2D_174(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101110100111010011110000000),
      .k2(32'b10111101001110110100001100100010),
      .k3(32'b00111101110100110101001101101100),
      .k4(32'b00111101100100110011000101011011),
      .k5(32'b10111101101000100111100111011110),
      .k6(32'b10111101010111010101101011111101),
      .k7(32'b00111101111110100101001001101010),
      .k8(32'b00111110000011100111001101011101),
      .k9(32'b10111001110111001000010000000011)
  ) CON2D_175(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111011111111101100100110),
      .k2(32'b00111011011100101110101100101100),
      .k3(32'b10111100100100001100100100010110),
      .k4(32'b10111101110001010110110001111100),
      .k5(32'b00111101011010110010011110010101),
      .k6(32'b10111101001110100101011001001111),
      .k7(32'b00111101011010111011010000000100),
      .k8(32'b10111101000010011011001110000100),
      .k9(32'b00111110000001100111100100001000)
  ) CON2D_176(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[10][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111011111010101101000110001111)
)   op11(
    .i_pipeline_layer4(i_CORE_IP1[10]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*11-1:DATA_WIDTH*10])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling11(
    .i_data(i_CORE_IP2[DATA_WIDTH*11-1:DATA_WIDTH*10]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

/// CON2D_12///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101100101110000001010000000),
      .k2(32'b10111101001100001011101000111011),
      .k3(32'b10111100110101001100000110010011),
      .k4(32'b00111110000110001101110000000111),
      .k5(32'b10111101000010100111100101101010),
      .k6(32'b10111101010000110100000011111010),
      .k7(32'b10111101111011011000110000010010),
      .k8(32'b10111110000001001011110110001001),
      .k9(32'b10111100101010010010100011100001)
  ) CON2D_177(
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
      .k1(32'b00111101110111100010101110011011),
      .k2(32'b00111101110101101010100110011111),
      .k3(32'b10111100110000110000000111110101),
      .k4(32'b10111110000100101110100110110011),
      .k5(32'b00111110000100010110100111111001),
      .k6(32'b10111101011111101001100011000111),
      .k7(32'b00111011010101011001000111111011),
      .k8(32'b00111110000100111000101110000001),
      .k9(32'b10111101000110001110110010000011)
  ) CON2D_178(
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
      .k1(32'b00111101100000000011101110100110),
      .k2(32'b10111100110000100010100110011011),
      .k3(32'b10111101011101110100100111111110),
      .k4(32'b10111101111011011100110011111111),
      .k5(32'b00111101001101011111001001000101),
      .k6(32'b10111101110000101001010110111110),
      .k7(32'b00111110000010110110010111001001),
      .k8(32'b00111101101001000100100111101000),
      .k9(32'b10111100000111110100010100010011)
  ) CON2D_179(
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
      .k1(32'b10111110000111110010100111000101),
      .k2(32'b10111101000110011010110110111010),
      .k3(32'b00111101100100000100011111001001),
      .k4(32'b00111100111111101101100110101001),
      .k5(32'b00111101000010110110100100101110),
      .k6(32'b10111110001010000011110111111011),
      .k7(32'b10111101111011011101011010001010),
      .k8(32'b10111101110011110101100001010101),
      .k9(32'b10111101110111000100000000100000)
  ) CON2D_180(
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
      .k1(32'b10111101101101000111110011110111),
      .k2(32'b10111101100100100000101011000110),
      .k3(32'b00111100100000011011011110111011),
      .k4(32'b10111101101111101011000010000101),
      .k5(32'b00111100000100111110000001000101),
      .k6(32'b00111101000010001011101101110001),
      .k7(32'b10111100111010001001101001110000),
      .k8(32'b00111100111000111011011011101000),
      .k9(32'b00111101000110000000010001111101)
  ) CON2D_181(
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
      .k1(32'b00111101100001011010111000100101),
      .k2(32'b00111101000000101111110001110100),
      .k3(32'b00111101101011000101010111101111),
      .k4(32'b00111101001011011000010100100110),
      .k5(32'b00111110000001001111101111101001),
      .k6(32'b00111110000001011100111001100110),
      .k7(32'b00111101000001100101000001001111),
      .k8(32'b00111110000110011001000100110001),
      .k9(32'b00111100001000110011010010010100)
  ) CON2D_182(
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
      .k1(32'b10111101100000011110011101111001),
      .k2(32'b00111101000010100000100100011001),
      .k3(32'b00111110000010001011111111111100),
      .k4(32'b00111101111100011110100001011010),
      .k5(32'b10111101110101101001110010001111),
      .k6(32'b00111101111110110001111111000101),
      .k7(32'b10111110000001101000001000010101),
      .k8(32'b00111101111111001100101101111110),
      .k9(32'b10111101010001011111110101100110)
  ) CON2D_183(
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
      .k1(32'b10111101110011010110111000011010),
      .k2(32'b00111101101110010001111111000111),
      .k3(32'b00111100011001011001101110100110),
      .k4(32'b10111101000111101100101101000100),
      .k5(32'b00111101001010100110101111000101),
      .k6(32'b00111100100001111011011101000011),
      .k7(32'b00111101001101100110001010110101),
      .k8(32'b00111101111011110011111101011110),
      .k9(32'b10111101000010101100110011111110)
  ) CON2D_184(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101000100111111000011011101),
      .k2(32'b00111101011011110110000111010011),
      .k3(32'b10111011111101101101111101110111),
      .k4(32'b10111101100011101011000100110100),
      .k5(32'b10111100110100110001101110011010),
      .k6(32'b10111110000110111000110100010111),
      .k7(32'b10111011110101111011001101101001),
      .k8(32'b00111011100101000010000110101010),
      .k9(32'b00111101001011110111110101011100)
  ) CON2D_185(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100000101001100000110001100),
      .k2(32'b00111100101101000001001111000111),
      .k3(32'b00111100111011000101001000110101),
      .k4(32'b10111110000001110111100001010001),
      .k5(32'b00111101010100100010010100010000),
      .k6(32'b00111101001011001011010001001111),
      .k7(32'b10111101000011000010101000110010),
      .k8(32'b10111100100100011101011101101111),
      .k9(32'b00111011100000011111010111001110)
  ) CON2D_186(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111111110101010101001101),
      .k2(32'b10111101111000110100000011011101),
      .k3(32'b10111110000011110010010111001000),
      .k4(32'b10111100111011110010111000010010),
      .k5(32'b00111101011011001001101011100110),
      .k6(32'b10111101100101101010000010100001),
      .k7(32'b10111110000100001000000100101010),
      .k8(32'b10111101101011010010101101101100),
      .k9(32'b10111110000111101001100011100110)
  ) CON2D_187(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101110011001000010100110110),
      .k2(32'b00111101101011100101111001101110),
      .k3(32'b00111101111101100100100000011101),
      .k4(32'b10111101110001010010011010111001),
      .k5(32'b00111100101000010011110001001101),
      .k6(32'b10111101111111100110110001011011),
      .k7(32'b10111101100110001000001010100001),
      .k8(32'b10111101110110101011100100001011),
      .k9(32'b00111101100111000101000111010110)
  ) CON2D_188(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111100100110011001010011),
      .k2(32'b10111101111100001010100011010011),
      .k3(32'b00111101101101001111100001000011),
      .k4(32'b00111101100001110011110001110001),
      .k5(32'b00111101100011101101101001000101),
      .k6(32'b00111110000100100101101010110101),
      .k7(32'b10111100111010110011010111110110),
      .k8(32'b00111101110000001000011011101001),
      .k9(32'b00111100011010111111000101111101)
  ) CON2D_189(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101101001111000111100100101),
      .k2(32'b00111100101001010111110011010000),
      .k3(32'b00111101100011111001110110110011),
      .k4(32'b00111100100101110011001001000011),
      .k5(32'b10111110000100011000010011110111),
      .k6(32'b00111010001011011110001111111011),
      .k7(32'b10111101101001000111001000101011),
      .k8(32'b10111110001001000110000000110111),
      .k9(32'b10111101111101100001101101011011)
  ) CON2D_190(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100110100011101111100010000),
      .k2(32'b10111101000001110011111010000001),
      .k3(32'b00111100110110011011111010101100),
      .k4(32'b00111101101111110010000001011001),
      .k5(32'b00111100001101101011110111011000),
      .k6(32'b00111101011010001110001111001001),
      .k7(32'b00111101000111001100101100101100),
      .k8(32'b10111101111101111101000011101100),
      .k9(32'b00111101000001110110010011010000)
  ) CON2D_191(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111110010010101101000101),
      .k2(32'b00111101010010110100000101110001),
      .k3(32'b10111101111001000000110111110110),
      .k4(32'b10111100110011001111000111111110),
      .k5(32'b00111101001000011100001100001101),
      .k6(32'b00111101000011101011110010101100),
      .k7(32'b10111101010111111001101010101111),
      .k8(32'b00111101101011000110011000000110),
      .k9(32'b00111101101101001000001000000010)
  ) CON2D_192(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[11][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111100011101001011110011110111)
)   op12(
    .i_pipeline_layer4(i_CORE_IP1[11]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*12-1:DATA_WIDTH*11])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling12(
    .i_data(i_CORE_IP2[DATA_WIDTH*12-1:DATA_WIDTH*11]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

/// CON2D_13///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100010110111001101110001001),
      .k2(32'b10111101101001001110100010000001),
      .k3(32'b00111101000111011010000011110100),
      .k4(32'b00111101000111010100011001011001),
      .k5(32'b00111101101101100001100010011110),
      .k6(32'b00111101111111011010010101010101),
      .k7(32'b00111101101111000111101011111010),
      .k8(32'b10111101001001010011010001100001),
      .k9(32'b00111101111011000111110101111010)
  ) CON2D_193(
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
      .k1(32'b10111101100010010110100000001110),
      .k2(32'b00111011111111110011111110010001),
      .k3(32'b10111110000000001101110011101101),
      .k4(32'b00111101110110011100010001101101),
      .k5(32'b10111101010100001110101001110010),
      .k6(32'b00111101110101011001010000101110),
      .k7(32'b10111101110011001110001100000010),
      .k8(32'b10111101000000000100100000010110),
      .k9(32'b00111101100010011100101100100100)
  ) CON2D_194(
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
      .k1(32'b10111101100010000111000001000010),
      .k2(32'b10111101101101110101010000101011),
      .k3(32'b00111101001001010001111101001000),
      .k4(32'b10111101000000101111001100001011),
      .k5(32'b10111110000011110011100001111110),
      .k6(32'b10111101010001010101100111100101),
      .k7(32'b10111101000000000000010011101111),
      .k8(32'b10111011111001001111100111110011),
      .k9(32'b10111101001110001101101100010111)
  ) CON2D_195(
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
      .k1(32'b00111101101101100011111101000100),
      .k2(32'b00111100100010100100111011001110),
      .k3(32'b00111110000001100100100100000111),
      .k4(32'b00111101110010000111110100111010),
      .k5(32'b00111101111000110010111010100110),
      .k6(32'b00111110000010011101011001101010),
      .k7(32'b00111101100001010100100101100100),
      .k8(32'b10111100101000100100001110000001),
      .k9(32'b10111101110001011010100011000111)
  ) CON2D_196(
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
      .k1(32'b10111101100100010100111010111000),
      .k2(32'b10111101110001001000001101101110),
      .k3(32'b10111101111010000111001101010111),
      .k4(32'b10111101100010100101100001111111),
      .k5(32'b00111101111110010000010010010101),
      .k6(32'b10111110000011000111100101010101),
      .k7(32'b00111101000101000110101101000110),
      .k8(32'b10111100101010011111000100001000),
      .k9(32'b10111101011001110011100000001110)
  ) CON2D_197(
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
      .k1(32'b10111100101111000111010010001101),
      .k2(32'b10111101111110011110010110001101),
      .k3(32'b00111101001011001110111100101111),
      .k4(32'b00111101111010000110110100111010),
      .k5(32'b10111101101100101110110100101111),
      .k6(32'b00111010111100110010001001010100),
      .k7(32'b10111101100100011001011100101000),
      .k8(32'b10111000000110101100110110101100),
      .k9(32'b10111010110101010011110111011110)
  ) CON2D_198(
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
      .k1(32'b10111100111111000010100111011011),
      .k2(32'b00111101110111011101010011011111),
      .k3(32'b10111101110001010110111001011010),
      .k4(32'b00111101010001010010011010000101),
      .k5(32'b00111101100100101111010101100101),
      .k6(32'b00111011110110100000010000111101),
      .k7(32'b10111101110000101100001001000110),
      .k8(32'b00111100100101100111100101011000),
      .k9(32'b00111101110010001010011000100100)
  ) CON2D_199(
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
      .k1(32'b10111101110101101101001111000100),
      .k2(32'b00111101100000011010001111110101),
      .k3(32'b00111101111110000011011000101011),
      .k4(32'b10111100101101100010010111011011),
      .k5(32'b00111101000111010110110010000010),
      .k6(32'b10111101101111101000001000110111),
      .k7(32'b00111011011101001000011101000001),
      .k8(32'b10111101111001101111011101101100),
      .k9(32'b10111100001101101011110001010010)
  ) CON2D_200(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101111011100110000101001010),
      .k2(32'b10111101101100000100111000101001),
      .k3(32'b00111100011101000010110011110010),
      .k4(32'b10111101111101111010001110000110),
      .k5(32'b00111101110010100100100000101011),
      .k6(32'b10111101000100001100110110001110),
      .k7(32'b00111101101001101001000010111010),
      .k8(32'b00111101100000001101111000111011),
      .k9(32'b00111101010110000111000100110000)
  ) CON2D_201(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111110000100101111010111110001),
      .k2(32'b10111101010011010000111111000101),
      .k3(32'b10111101010110000010110000111100),
      .k4(32'b00111101011001110111010100100111),
      .k5(32'b10111101100101110010110010000101),
      .k6(32'b00111101110010001001000111000011),
      .k7(32'b10111101011010010010010100010010),
      .k8(32'b10111101100011011011101110000110),
      .k9(32'b10111101010001001010010010001000)
  ) CON2D_202(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100110001110001000001011100),
      .k2(32'b10111101100010101101001100010110),
      .k3(32'b00111101100011011000011011010001),
      .k4(32'b10111100100001110110000110101111),
      .k5(32'b10111101011011010110111001111101),
      .k6(32'b00111100100000110111100001110110),
      .k7(32'b00111100100111000011100100010011),
      .k8(32'b10111110000000011011110001001101),
      .k9(32'b00111100011000010011010001110011)
  ) CON2D_203(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101010001000000110101011000),
      .k2(32'b10111101100001100000111101011011),
      .k3(32'b10111110000100110101000111101111),
      .k4(32'b10111011111101010001100110101010),
      .k5(32'b00111101111111111101000011110001),
      .k6(32'b00111101110111111111000101100011),
      .k7(32'b10111101111111101111000001011000),
      .k8(32'b00111110000001100000010111110010),
      .k9(32'b10111100111011101110001001010101)
  ) CON2D_204(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101101001001001110110000),
      .k2(32'b10111101101100010111000100101010),
      .k3(32'b00111101101000110111110111110110),
      .k4(32'b00111101110000100101010110010010),
      .k5(32'b00111101111001010010100100011001),
      .k6(32'b00111101110010100010101100111100),
      .k7(32'b00111110000000010101011001001100),
      .k8(32'b10111101011110011011111000001111),
      .k9(32'b00111101111101111101001111010010)
  ) CON2D_205(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101110110101000011011000011),
      .k2(32'b10111101111011100011111101010010),
      .k3(32'b00111101100100101010101100001101),
      .k4(32'b10111100101100110000000100001111),
      .k5(32'b10111101111010101011110100010000),
      .k6(32'b00111010110001011110001111111110),
      .k7(32'b10111100101010011001001101111111),
      .k8(32'b10111101000111001101100101110110),
      .k9(32'b10111110000100101000101001001000)
  ) CON2D_206(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111011000001000110110000100010),
      .k2(32'b10111101100111010111001001110011),
      .k3(32'b00111101001010110110100101101010),
      .k4(32'b00111101100011001100011101011111),
      .k5(32'b10111011101010001010110111110000),
      .k6(32'b00111101110000010000011011001110),
      .k7(32'b10111110000100100111111111100100),
      .k8(32'b10111101100110111101010111110011),
      .k9(32'b10111101010101111000000101111000)
  ) CON2D_207(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000010010010100101110000),
      .k2(32'b10111101011001000010010010001111),
      .k3(32'b00111101001100110101100000100110),
      .k4(32'b10111100101010000111100110111101),
      .k5(32'b00111101110110111000111100101100),
      .k6(32'b00111101111011100100111110011010),
      .k7(32'b00111101000010101011011100101110),
      .k8(32'b00111011100000110101011110001000),
      .k9(32'b00111101001001111111011000010100)
  ) CON2D_208(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[12][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111100000001011100011100011111)
)   op13(
    .i_pipeline_layer4(i_CORE_IP1[12]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*13-1:DATA_WIDTH*12])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling13(
    .i_data(i_CORE_IP2[DATA_WIDTH*13-1:DATA_WIDTH*12]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

/// CON2D_14///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101010011100001100111101000),
      .k2(32'b00111101110110000110101000111011),
      .k3(32'b00111101101110000011100101010111),
      .k4(32'b00111110000100101001000110100111),
      .k5(32'b00111110000100110101010001000101),
      .k6(32'b10111100111101100000000111101000),
      .k7(32'b00111110000010100010011100000101),
      .k8(32'b00111110000101010001110111011000),
      .k9(32'b10111101001011111100011011110101)
  ) CON2D_209(
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
      .k1(32'b00111110000010111110100100100001),
      .k2(32'b00111101101110111010010111101110),
      .k3(32'b10111101100111111110010001101010),
      .k4(32'b10111110000001000001000011101111),
      .k5(32'b00111100000010000111110111100110),
      .k6(32'b10111110000100111000111100101100),
      .k7(32'b10111110000100110100111110000101),
      .k8(32'b10111110001001110111111010010010),
      .k9(32'b10111110000000001100101101011001)
  ) CON2D_210(
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
      .k1(32'b00111101100110100001101000010000),
      .k2(32'b00111101110100011000111000000110),
      .k3(32'b00111110000100001010101000000111),
      .k4(32'b00111101111110111000111111101101),
      .k5(32'b10111101101111111101011010000110),
      .k6(32'b10111101011010010110011111110100),
      .k7(32'b00111110000010001111100101100101),
      .k8(32'b10111101100011101111101100000111),
      .k9(32'b10111100011001011010011010011011)
  ) CON2D_211(
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
      .k1(32'b10111101101001110101100100110111),
      .k2(32'b10111101111110100111010110100110),
      .k3(32'b10111000110011011100000100010111),
      .k4(32'b10111100111011001101110100001100),
      .k5(32'b00111101100000110001111010000101),
      .k6(32'b00111110000010011100000111011000),
      .k7(32'b00111101111100111110110000110000),
      .k8(32'b00111100110110111101111111110101),
      .k9(32'b00111101100011011101001000000110)
  ) CON2D_212(
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
      .k1(32'b10111110000000110101011111001100),
      .k2(32'b00111101100110111000111011110101),
      .k3(32'b00111100101101101101011110000111),
      .k4(32'b00111101101011011110101111010011),
      .k5(32'b10111101111001111100001011110011),
      .k6(32'b10111100100000001100111011001000),
      .k7(32'b10111101100000101011100011100101),
      .k8(32'b00111101100010100000111000001100),
      .k9(32'b10111101010011010111100101100001)
  ) CON2D_213(
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
      .k1(32'b00111110001010000000110000110110),
      .k2(32'b10111101000110111001000011111001),
      .k3(32'b00111101100111100010111111111110),
      .k4(32'b10111101010011111111010010011111),
      .k5(32'b00111101101001011101001101001111),
      .k6(32'b00111110000001010010010110100100),
      .k7(32'b10111101000000110010000111000110),
      .k8(32'b10111101001101010110110111000110),
      .k9(32'b10111101010100010110111011010110)
  ) CON2D_214(
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
      .k1(32'b10111110000000111001011000001110),
      .k2(32'b10111101101111111110010111100100),
      .k3(32'b00111101101011100101010011100100),
      .k4(32'b10111101101111010011000110101001),
      .k5(32'b10111100010000000010100010001000),
      .k6(32'b00111101110101011011110100111000),
      .k7(32'b10111100101001110100001001111011),
      .k8(32'b10111101101010110100010010100110),
      .k9(32'b10111101101011000110111101111000)
  ) CON2D_215(
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
      .k1(32'b10111101001100001101010100101011),
      .k2(32'b10111101100001111101011001001000),
      .k3(32'b10111101101111000111011111111001),
      .k4(32'b10111101110010101011011011100001),
      .k5(32'b10111101000111101000111100100001),
      .k6(32'b00111101010011100100011011000000),
      .k7(32'b00111101001000100000101001110011),
      .k8(32'b00111101001010110101100110111110),
      .k9(32'b10111101010011000100011101111010)
  ) CON2D_216(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101110011010111011011110),
      .k2(32'b00111101111010111011101000001110),
      .k3(32'b00111101111100110111111111010110),
      .k4(32'b10111101001000100011001000011010),
      .k5(32'b00111101101110111101000111000101),
      .k6(32'b10111101011110001010100101101111),
      .k7(32'b10111101111011001110101000110000),
      .k8(32'b00111100101011001101011010111110),
      .k9(32'b10111101111111110100010000010011)
  ) CON2D_217(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101001010100100111101110111),
      .k2(32'b10111101011001111110101000011011),
      .k3(32'b10111101110010010101000000001010),
      .k4(32'b10111101001100100110001111000010),
      .k5(32'b00111101111110000000101000100000),
      .k6(32'b00111101100100010101110100010000),
      .k7(32'b00111110000011010000000111011011),
      .k8(32'b10111101001001010110011100011010),
      .k9(32'b10111110000001100101010111000010)
  ) CON2D_218(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101101101100000010001111011),
      .k2(32'b10111100101011111000001000110111),
      .k3(32'b10111101110001010001010011010000),
      .k4(32'b00111101100011011111101010001001),
      .k5(32'b10111101111000111100100110101001),
      .k6(32'b10111100011111111010110010101011),
      .k7(32'b10111101010111101101110000110010),
      .k8(32'b10111101111001000111011011000010),
      .k9(32'b00111110000100010010111000100110)
  ) CON2D_219(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101100100100101001111111111),
      .k2(32'b10111101111001110001111100001100),
      .k3(32'b00111100100101010010101100110010),
      .k4(32'b00111101101001000000010101111110),
      .k5(32'b10111100111010100100110111010010),
      .k6(32'b10111100011110111010001000011110),
      .k7(32'b10111101100110011000011010101100),
      .k8(32'b10111101000111100011100011010011),
      .k9(32'b10111101100101010011001001101001)
  ) CON2D_220(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101000111011011110101000111),
      .k2(32'b10111101111000110000010110001101),
      .k3(32'b10111101111001000010111100000110),
      .k4(32'b00111110000101001100100010101000),
      .k5(32'b00111100001010000101011101010001),
      .k6(32'b00111101011110110101100111110010),
      .k7(32'b00111100001010101111010101000110),
      .k8(32'b10111100100101000010000001011011),
      .k9(32'b10111100111100001110110100101110)
  ) CON2D_221(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101000111010110101100110101),
      .k2(32'b00111110000000010110111011011001),
      .k3(32'b10111101101100000010001111110100),
      .k4(32'b10111101110100010010100111110111),
      .k5(32'b10111110000010010001101101010110),
      .k6(32'b00111101100000111101110000001110),
      .k7(32'b10111101111000001010101111011100),
      .k8(32'b00111110000000010101101100001100),
      .k9(32'b10111110000101000110001001110110)
  ) CON2D_222(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101111000100000010010100010),
      .k2(32'b00111100110100101001101111101010),
      .k3(32'b10111101110110100010011011011001),
      .k4(32'b10111101010000011110100110000011),
      .k5(32'b10111101100010110100010111001001),
      .k6(32'b10111101110001011111100100011001),
      .k7(32'b10111100000110101110001110111111),
      .k8(32'b00111101110100110110011100101101),
      .k9(32'b00111101110010110010000001011111)
  ) CON2D_223(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101111001111101101100111000),
      .k2(32'b10111100100010111010100111101011),
      .k3(32'b00111101110001000011011010101001),
      .k4(32'b00111101100110101110011011111000),
      .k5(32'b10111011111101111101110110111010),
      .k6(32'b10111101110110000001101010010111),
      .k7(32'b10111101011110110011001100001010),
      .k8(32'b10111101010001110101010101101011),
      .k9(32'b10111101011100000111001011111001)
  ) CON2D_224(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[13][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b10111011010100011111001100110110)
)   op14(
    .i_pipeline_layer4(i_CORE_IP1[13]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*14-1:DATA_WIDTH*13])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling14(
    .i_data(i_CORE_IP2[DATA_WIDTH*14-1:DATA_WIDTH*13]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

/// CON2D_15///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100111010011000010011101000),
      .k2(32'b10111101110010111101101000011110),
      .k3(32'b00111101110111101000110010100001),
      .k4(32'b00111110000110000110111011011110),
      .k5(32'b00111101000011101000101110101110),
      .k6(32'b10111101100010010001001000010000),
      .k7(32'b00111101011011110111011100100101),
      .k8(32'b10111100110111100011110011100001),
      .k9(32'b00111011111011101011101010010101)
  ) CON2D_225(
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
      .k1(32'b10111110000101010001111011010001),
      .k2(32'b00111101101000000011111111110001),
      .k3(32'b00111101011111101000010111001101),
      .k4(32'b00111101000011010110111111111001),
      .k5(32'b00111110000000111101011000100011),
      .k6(32'b10111101010011011101001110111101),
      .k7(32'b10111101111011111011110010000101),
      .k8(32'b00111101110101011001110101110011),
      .k9(32'b10111101111111001001011001010000)
  ) CON2D_226(
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
      .k1(32'b10111101111100100110011001000010),
      .k2(32'b10111101010110111011010100010000),
      .k3(32'b10111101100000100001001111111010),
      .k4(32'b10111101110110000101010000101100),
      .k5(32'b00111101000000000000001101010010),
      .k6(32'b10111101100111011101110001001010),
      .k7(32'b10111101101110111001010110110000),
      .k8(32'b00111100100100001010111110110110),
      .k9(32'b00111101101101101101000101111101)
  ) CON2D_227(
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
      .k1(32'b00111101111101101011010010100011),
      .k2(32'b10111100110100011110011101110101),
      .k3(32'b00111110000100001110101010101010),
      .k4(32'b00111101001100000011101010011000),
      .k5(32'b00111110000001100010110101011000),
      .k6(32'b00111100111000110100111111001000),
      .k7(32'b00111101111000100101000111000001),
      .k8(32'b00111101100001000111110111111100),
      .k9(32'b10111110000000111100110011000100)
  ) CON2D_228(
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
      .k1(32'b00111110000011101110011000001000),
      .k2(32'b00111110000011010110100101000001),
      .k3(32'b00111101010101011011100101000110),
      .k4(32'b00111011111100011110011110000011),
      .k5(32'b10111101101010101010011110101011),
      .k6(32'b10111101001110110110010111100111),
      .k7(32'b10111101110101011110001011011111),
      .k8(32'b10111101111110001111011001101011),
      .k9(32'b10111101110110100000100000001000)
  ) CON2D_229(
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
      .k1(32'b10111101101011011010001010010011),
      .k2(32'b10111101001110111000111011110100),
      .k3(32'b00111110000010000101101011100101),
      .k4(32'b10111101001110001100100100100100),
      .k5(32'b00111011001010110101100101110110),
      .k6(32'b00111110000010011100111101101100),
      .k7(32'b00111101100101010010111011010100),
      .k8(32'b10111101010001101111110100111000),
      .k9(32'b00111101011101101001100110110000)
  ) CON2D_230(
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
      .k1(32'b10111101101100001011001110001010),
      .k2(32'b00111110000011110100100000011000),
      .k3(32'b00111100101100000010101010100001),
      .k4(32'b10111101110001101110001111110000),
      .k5(32'b00111101000010011001100001111111),
      .k6(32'b10111101000000111000001001100011),
      .k7(32'b00111101101101001010100011101001),
      .k8(32'b00111101111111011100100010101000),
      .k9(32'b00111101110100111000100000010101)
  ) CON2D_231(
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
      .k1(32'b10111101100101111100100010000100),
      .k2(32'b10111101100111100101111010101111),
      .k3(32'b10111101011101111110101011011100),
      .k4(32'b00111101101110000111001101011110),
      .k5(32'b10111101111101111011110101101010),
      .k6(32'b00111100100110100101101001010100),
      .k7(32'b00111100101010011010101001011010),
      .k8(32'b10111101100011001110000100001010),
      .k9(32'b00111101001101000000010001110101)
  ) CON2D_232(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101100100010100101000010000),
      .k2(32'b10111101010001010001110000101010),
      .k3(32'b10111101101010011011010000110000),
      .k4(32'b10111101110000000111000001010010),
      .k5(32'b00111101001111010000100111110011),
      .k6(32'b10111101010011010111000001111101),
      .k7(32'b00111101011100110001011100100001),
      .k8(32'b10111101111100111000110111101001),
      .k9(32'b00111101110110110010000001100111)
  ) CON2D_233(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111010010111000100010011),
      .k2(32'b10111101111011010001000111101010),
      .k3(32'b00111110000110000011111001101101),
      .k4(32'b00111101001100101111110010000011),
      .k5(32'b10111101111111000000101011101000),
      .k6(32'b00111101100111011101010110100111),
      .k7(32'b00111101110000000100000011011000),
      .k8(32'b00111101001001011000010110001110),
      .k9(32'b10111101010001101110100011010001)
  ) CON2D_234(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101100011100011001011100000),
      .k2(32'b00111101111101101001101011000110),
      .k3(32'b10111101011111101010000101100011),
      .k4(32'b00111101100101110010101100000111),
      .k5(32'b10111100001001001000010010010001),
      .k6(32'b10111101001000101111001010111100),
      .k7(32'b10111100000100101000101010010000),
      .k8(32'b00111101100110001000011101111101),
      .k9(32'b10111101111110000100001110110001)
  ) CON2D_235(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110000111100000101101100111),
      .k2(32'b00111101101101110000011000101110),
      .k3(32'b10111101110000011011110101000100),
      .k4(32'b00111101000111100100101001011010),
      .k5(32'b00111101111011110001110001110011),
      .k6(32'b10111101100110010100000010100000),
      .k7(32'b10111110000010110000100001100111),
      .k8(32'b10111101001101110100100100010110),
      .k9(32'b10111101110000000000110101000111)
  ) CON2D_236(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100101001100100110000011000),
      .k2(32'b00111101101001101101000011010000),
      .k3(32'b10111101110001000001000010111000),
      .k4(32'b00111100101001110100001101000110),
      .k5(32'b00111101001000110110111110010101),
      .k6(32'b00111101001110110101001001101101),
      .k7(32'b00111101110001111011000101110010),
      .k8(32'b00111101110100101101111101110101),
      .k9(32'b10111011001001100111111110011000)
  ) CON2D_237(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101111111101101100001010111),
      .k2(32'b00111100010111010011011100100000),
      .k3(32'b00111101101010011000001110110101),
      .k4(32'b10111101001010111010100010000011),
      .k5(32'b10111101001011010111001001100011),
      .k6(32'b00111110000100100011110011100101),
      .k7(32'b00111100111100110100010111100111),
      .k8(32'b10111110000000000111110111100011),
      .k9(32'b00111101011011001101101010010010)
  ) CON2D_238(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111000000011101001100001),
      .k2(32'b00111101111100101111000010110110),
      .k3(32'b00111101100011110000101101111001),
      .k4(32'b10111101100010111001100001000110),
      .k5(32'b00111101111100110110011111000100),
      .k6(32'b00111101100011111101111001000010),
      .k7(32'b10111101111011110000001010101110),
      .k8(32'b10111101101111110110101010111101),
      .k9(32'b10111101101001010100001101001111)
  ) CON2D_239(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111001111000000001000101),
      .k2(32'b10111101110010000111011001000010),
      .k3(32'b10111101110110011000010100100101),
      .k4(32'b10111101000010011001100101110001),
      .k5(32'b00111110000001101101110010101010),
      .k6(32'b10111101001100110011100010110001),
      .k7(32'b00111101100100101110110101011000),
      .k8(32'b10111100100001111101010011011101),
      .k9(32'b00111100111000111101011111110111)
  ) CON2D_240(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[14][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111100001100000011010110111111)
)   op15(
    .i_pipeline_layer4(i_CORE_IP1[14]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*15-1:DATA_WIDTH*14])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling15(
    .i_data(i_CORE_IP2[DATA_WIDTH*15-1:DATA_WIDTH*14]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

/// CON2D_16///////////////////
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101100000111010001011110010),
      .k2(32'b00111101100001000111000101101101),
      .k3(32'b10111101001101100111010001111100),
      .k4(32'b00111110000011010111100010110011),
      .k5(32'b00111101110001011001100100111010),
      .k6(32'b10111101101101011001101011110110),
      .k7(32'b10111101110110110111100000101101),
      .k8(32'b10111101011000100000001101100100),
      .k9(32'b10111011110100010010100011111100)
  ) CON2D_241(
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
      .k1(32'b10111101110111100110100111000001),
      .k2(32'b00111101100100101001001111010110),
      .k3(32'b10111011101001011101010011111110),
      .k4(32'b00111101110110001111011110010100),
      .k5(32'b10111110000001010000000101100110),
      .k6(32'b00111101010100011110011010110011),
      .k7(32'b10111101111001011100101001101011),
      .k8(32'b10111100001001110111101101110010),
      .k9(32'b10111110000110010101110110001110)
  ) CON2D_242(
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
      .k1(32'b00111101010100100100000110100011),
      .k2(32'b00111101101001100100100011010111),
      .k3(32'b10111100010001011100011000000101),
      .k4(32'b10111110000011001000001111001101),
      .k5(32'b10111101101110000101010000011000),
      .k6(32'b00111101110010010011101110011110),
      .k7(32'b00111011110100000010011001100011),
      .k8(32'b00111101011111000100000110010111),
      .k9(32'b10111100110000100111110011101100)
  ) CON2D_243(
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
      .k1(32'b00111101110010101111101100101001),
      .k2(32'b00111101111111010000010100101010),
      .k3(32'b10111100111100101001011101111010),
      .k4(32'b00111101010010100000100110001111),
      .k5(32'b10111101101001000101110001000110),
      .k6(32'b00111101011111010010110011111011),
      .k7(32'b10111101011011110101000101010000),
      .k8(32'b10111100111000010010011110011110),
      .k9(32'b10111101111011101100101101101101)
  ) CON2D_244(
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
      .k1(32'b00111101110100100010011010001010),
      .k2(32'b10111101000011010110000101000001),
      .k3(32'b10111100111101011001000101101001),
      .k4(32'b10111110000010001010111000110101),
      .k5(32'b00111101111010001100101001100110),
      .k6(32'b10111110000000010100000010010111),
      .k7(32'b10111100100100100000100010011111),
      .k8(32'b00111100110000000011001000111011),
      .k9(32'b00111101101001011010010111010100)
  ) CON2D_245(
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
      .k1(32'b10111101110100010011111011111110),
      .k2(32'b00111011011111101011011101011011),
      .k3(32'b00111101100010100010011111100111),
      .k4(32'b10111101111101001111011100010010),
      .k5(32'b00111101110000110100001001111100),
      .k6(32'b00111101100000100101100111001011),
      .k7(32'b10111110001000000010000110100001),
      .k8(32'b00111101100000010001100111100010),
      .k9(32'b10111100100000110100010110101100)
  ) CON2D_246(
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
      .k1(32'b10111011111101011110000010010000),
      .k2(32'b00111110000010100111001100110111),
      .k3(32'b00111110000000101010111000001101),
      .k4(32'b10111011001101000111110001010110),
      .k5(32'b00111101110111110011010011111101),
      .k6(32'b00111110000000111011111001111000),
      .k7(32'b10111110000011010010001111011100),
      .k8(32'b10111101001001010010101010111010),
      .k9(32'b00111101011001000011100001010010)
  ) CON2D_247(
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
      .k1(32'b00111110000000110001100000111100),
      .k2(32'b10111101101010100111000010010100),
      .k3(32'b00111101000110011100101000111010),
      .k4(32'b00111110000010010011100110010101),
      .k5(32'b00111101101111101000101011110101),
      .k6(32'b00111011010110011000101110100111),
      .k7(32'b00111110000000001001010001011000),
      .k8(32'b10111101100111010101000010101001),
      .k9(32'b00111101110100011010011001010100)
  ) CON2D_248(
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

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101000101010000110101000100),
      .k2(32'b10111101111010111111111101011000),
      .k3(32'b10111100011011011010010011110011),
      .k4(32'b00111101111101001101110110001011),
      .k5(32'b00111110000101000001110100100001),
      .k6(32'b10111011101001010101110011001100),
      .k7(32'b10111101111101010001111001010011),
      .k8(32'b10111101101000010110011001010010),
      .k9(32'b10111100101010111100011101111101)
  ) CON2D_249(
      .i_data(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*9-1:DATA_WIDTH*8])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111100001110101101101110111010),
      .k2(32'b00111101101000111011011110001111),
      .k3(32'b10111101111010111111110100000111),
      .k4(32'b00111101101101000110010111000010),
      .k5(32'b00111101100111100010001000111010),
      .k6(32'b00111101011101000101000001000011),
      .k7(32'b00111101100111111111110010110101),
      .k8(32'b00111100100011100101111101101000),
      .k9(32'b10111101100010010111011001110101)
  ) CON2D_250(
      .i_data(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*10-1:DATA_WIDTH*9])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101101110100111111011011111),
      .k2(32'b10111101101010001101110111000011),
      .k3(32'b00111100100001001001011010111111),
      .k4(32'b10111011000100100011101111111111),
      .k5(32'b10111011001101011001011000110010),
      .k6(32'b10111110000001011011100100110000),
      .k7(32'b10111101110010111011100101011100),
      .k8(32'b10111101100000001110110011110011),
      .k9(32'b10111100100101001111111011111101)
  ) CON2D_251(
      .i_data(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*11-1:DATA_WIDTH*10])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101011100110100101110001001),
      .k2(32'b00111101001001101111101111000010),
      .k3(32'b00111101011011101011101001001001),
      .k4(32'b00111101111101101001001000100011),
      .k5(32'b00111101111100100000101100110110),
      .k6(32'b00111101011000001001101001011010),
      .k7(32'b10111110000000100010010110001011),
      .k8(32'b10111100011000011111011011001100),
      .k9(32'b00111100100110101011101010101100)
  ) CON2D_252(
      .i_data(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*12-1:DATA_WIDTH*11])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101111001000111100001011101),
      .k2(32'b10111110000010000101100100001101),
      .k3(32'b00111101100111110100111010100100),
      .k4(32'b00111101101011001001100001100100),
      .k5(32'b00111110000100011100111011011010),
      .k6(32'b00111110000100001101100111100111),
      .k7(32'b10111101011100110111110010111011),
      .k8(32'b10111101001001011100010010000001),
      .k9(32'b10111101110010010110001010111001)
  ) CON2D_253(
      .i_data(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*13-1:DATA_WIDTH*12])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111101100110111111111100011101),
      .k2(32'b00111100101010111001111010100100),
      .k3(32'b00111100101001011001000011001110),
      .k4(32'b10111101100111001100011011100000),
      .k5(32'b10111010011100001111000011000110),
      .k6(32'b00111101010110110001100100000011),
      .k7(32'b10111101000010011111100011100100),
      .k8(32'b00111011100101001100111011010100),
      .k9(32'b10111101011101001001111100100100)
  ) CON2D_254(
      .i_data(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*14-1:DATA_WIDTH*13])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100110100000000010111101110),
      .k2(32'b00111011101011001100110101100001),
      .k3(32'b00111101110000111011011010101011),
      .k4(32'b00111100101111100111110001111011),
      .k5(32'b10111100111100100011110111110000),
      .k6(32'b00111100111111010101110011000010),
      .k7(32'b10111101100100110100001100001100),
      .k8(32'b00111101100101001101010110010000),
      .k9(32'b10111110000011110000111110011000)
  ) CON2D_255(
      .i_data(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*15-1:DATA_WIDTH*14])
  );

  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111100011111110010101000000110),
      .k2(32'b10111101100011110110110100001111),
      .k3(32'b10111101101000101100000010110111),
      .k4(32'b00111101101101111010100101011011),
      .k5(32'b10111101110001110100001010000001),
      .k6(32'b10111101110101000001111001000111),
      .k7(32'b10111101100111100101101001100011),
      .k8(32'b10111101110110010101010111010010),
      .k9(32'b00111101001110000101000011100100)
  ) CON2D_256(
      .i_data(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15]),
      .clk(clk), 
      .rst(rst), 
      .valid_in(padding_valid),
      .valid_in_pipeline2D(valid_in_pipeline2D),
      .counter_col(counter_col),
      .counter_row(counter_row),
      .valid_pipeline2D(valid_pipeline2D),
      .o_data(i_CORE_IP1[15][DATA_WIDTH*16-1:DATA_WIDTH*15])
  );


pipeline_layer4#(
    .DATA_WIDTH(DATA_WIDTH),
    .bias(32'b00111011111001111110101110000100)
)   op16(
    .i_pipeline_layer4(i_CORE_IP1[15]), 
    .clk(clk),
    .rst(rst),
    .valid_in_bias(valid_in_bias),
    .valid_pipeline(valid_pipeline_bias),
    .o_data(i_CORE_IP2[DATA_WIDTH*16-1:DATA_WIDTH*15])
);

  MaxPooling #(
    .DATA_WIDTH(DATA_WIDTH),
    .WIDTH(WIDTH)
  ) maxpooling16(
    .i_data(i_CORE_IP2[DATA_WIDTH*16-1:DATA_WIDTH*15]),
    .valid_in(valid_in_maxpooling), 
    .valid_in_max(valid_in_max), 
    .valid_in_max1(valid_in_max1), 
    .clk(clk), 
    .rst(rst),
    .o_data(o_data[DATA_WIDTH*16-1:DATA_WIDTH*15])
  );

  control_layer4#(
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
