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
  input            valid_in, clk, rst, fifo_busy,
  output [DATA_WIDTH-1:0] o_data,
  output           valid_out, rd_req 
  //output reg  [7:0]       i, j,
  //output [DATA_DEPTH-1:0] i1, i2, i3, i4, i5, i6, i7, i8, i9, i_line,
  //output valid_in_op1,valid_in_op0             
);

  wire [DATA_WIDTH-1:0] i1, i2, i3, i4, i5, i6, i7, i8, i9, i_line;
  wire valid_in_op1, valid_in_op0, valid_in_op2; 
  reg En, padding_valid;

  and a1(valid_in_op0, valid_in, ~fifo_busy);
  or o1(valid_in_padding, valid_in_op0, padding_valid);
  and a2(valid_in_op2, valid_in_op0, ~En);
  
  assign rd_req = valid_in_op2;
  
  Mux_padding #(
        	.DATA_WIDTH(DATA_WIDTH)
  ) m0 (
      .i_data(i_data),
      .o_data(i_line),
      .select(En)
      //.clk(clk)
  );
  
  linebuff #(
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
         .i_data(i_line),
         .valid_in(valid_in_padding), 
         .clk(clk), 
         .rst(rst),
         .valid_out(valid_in_op1)             
  ); 
/*always @(*) begin
    if(valid_in_op1 == 1)
          valid_in_op2 <= 1;
 end*/
element#(
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
     .valid_in(valid_in_op1),
     .clk(clk), 
     .rst(rst),
     .o_data(o_data),
     .valid_out(valid_out)
  );
/////////////////// CONTROLL PADDING EN ///////////////////////////////////////////////////////////////////////
reg [7:0] i, j;
always @(negedge clk or posedge rst) 
  begin
      if(rst) begin
          i <=  8'd0;
          j <=  8'd0;
        end
      else if (valid_in_padding) begin
          i <= i + 1'd1;
          if(i == WIDTH) begin  
              i <= 1;
              j <= j + 1'b1;
              if(j == (WIDTH -1))
                  padding_valid <= 0;
            end
          else if((j == 0) || (j == (WIDTH -1)))  
              En <= 1'd1;  
          
          else if (i == WIDTH - 1)
              En <= 1'd1; 
          else  begin
              En <= 1'd0;
              padding_valid <= 1;
          end 
      end
  end

endmodule
                    
