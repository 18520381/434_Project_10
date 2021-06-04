module Conv3d#(
    parameter DATA_WIDTH = 32,
    parameter WIDTH = 32,  
    parameter DEPTH = 900 ////fifo
   /* parameter k1  = 32'b01000000000000000000000000000000,
    parameter k2  = 32'b01000000000000000000000000000000,
    parameter k3  = 32'b01000000000000000000000000000000,
    parameter k4  = 32'b01000000000000000000000000000000,
    parameter k5  = 32'b01000000000000000000000000000000,
    parameter k6  = 32'b01000000000000000000000000000000,
    parameter k7  = 32'b01000000000000000000000000000000,
    parameter k8  = 32'b01000000000000000000000000000000,
    parameter k9  = 32'b01000000000000000000000000000000,
    parameter bias = 32'b01000000000000000000000000000000*/
)(
  input  [DATA_WIDTH*3-1:0] i_data,
  input              clk, rst, wr_req_FIFO_IN,
  output [DATA_WIDTH-1:0] o_data,
  output             valid_out 
  //output reg  [7:0]       i, j,
  //output [DATA_DEPTH-1:0] i1, i2, i3, i4, i5, i6, i7, i8, i9, i_line,
  //output valid_in_op1,valid_in_op0             
);
  wire [DATA_WIDTH*3-1:0] o_fifo_in;
  wire empty_FIFO_IN, rd_req_FIFO_IN, valid_in_adder; 
  wire [DATA_WIDTH-1:0]  o_CORE_IP1, o_CORE_IP2, o_CORE_IP3;
  
  fifo #(
      .DATA_WIDTH(DATA_WIDTH),
      .DEPTH(DEPTH)
  ) FIFO_IN(
      .data_out(o_fifo_in),
      .empty(empty_FIFO_IN), 
      .full(),
      .data_in(i_data),
      .wr_req(wr_req_FIFO_IN), 
      .rd_req(rd_req_FIFO_IN), 
      .rst(rst), 
      .clk(clk)
  );
  
  Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b10111101011110110101010010111110),
      .k2(32'b10111101101001101010111000111111),
      .k3(32'b10111101100001010110101100001000),
      .k4(32'b10111110101111000000010010110011),
      .k5(32'b10111110111010000011000101010011),   
      .k6(32'b10111110110011101000100001000110),     
      .k7(32'b10111110101100110011111111100010),     
      .k8(32'b10111110111110000101010111100001),     
      .k9(32'b10111110110101100100011111000110)
  ) CON2D_1(
      .i_data(o_fifo_in[31:0]),
      .valid_in(~empty_FIFO_IN), 
      .clk(clk), 
      .rst(rst), 
      .fifo_busy(1'b0),
      .o_data(o_CORE_IP1),
      .valid_out(valid_in_adder), 
      .rd_req(rd_req_FIFO_IN)
  );
  
  
  
   Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110101111110011011100010001),
      .k2(32'b00111110111000010101000101110011),
      .k3(32'b00111110110100010010110100100000),
      .k4(32'b00111101000111100110111110111100),
      .k5(32'b00111101001001100110110111110101),   
      .k6(32'b00111101010011011010000011111111),     
      .k7(32'b10111110100001100100010110010111),     
      .k8(32'b10111110101010010100110110001001),     
      .k9(32'b10111110100100100000100101010111)
  ) CON2D_2(
      .i_data(o_fifo_in[63:32]),
      .valid_in(~empty_FIFO_IN), 
      .clk(clk), 
      .rst(rst), 
      .fifo_busy(1'b0),
      .o_data(o_CORE_IP2),
      .valid_out(), 
      .rd_req(rd_req_FIFO_IN)
  );
  
  
   Con2D #(
      .DATA_WIDTH(DATA_WIDTH),
      .WIDTH(WIDTH),
      .k1(32'b00111110110110111110001110010001),
      .k2(32'b00111111000011001110010110101011),
      .k3(32'b00111110111101011100010010010100),
      .k4(32'b00111110100011001010111010100011),
      .k5(32'b00111110101100010000010010110110),   
      .k6(32'b00111110100111101111011011100000),     
      .k7(32'b10111101011010110110001110111110),     
      .k8(32'b10111101011100000010101100101010),     
      .k9(32'b10111101010100000101111011010100)
  ) CON2D_3(
      .i_data(o_fifo_in[95:64]),
      .valid_in(~empty_FIFO_IN), 
      .clk(clk), 
      .rst(rst), 
      .fifo_busy(1'b0),
      .o_data(o_CORE_IP3),
      .valid_out(), 
      .rd_req(rd_req_FIFO_IN)
  );
  
  
  Op1_con3d#(
      .DATA_WIDTH(DATA_WIDTH),
      .bias(32'b00111111001110111111101011111010)
  )   op1(
      .o_CORE_IP1(o_CORE_IP1), 
      .o_CORE_IP2(o_CORE_IP2), 
      .o_CORE_IP3(o_CORE_IP3),
      .valid_in_adder(valid_in_adder), 
      .clk(clk), 
      .rst(rst),
      .o_data(o_data),
      .valid_out(valid_out)
  );
  

endmodule
                    


