module linebuff#(
  parameter BIT = 32,
  parameter WIDTH = 5
)(
  output reg[BIT-1:0] o_data0,o_data1,o_data2,o_data3,o_data4,o_data5,o_data6,o_data7,o_data8,
  input  [BIT-1:0] i_data,
  input            valid_in, clk,
  output  reg      valid_out,
  output [4:0] a,b              
);
  parameter DIN = WIDTH*2 + 3;
  reg [BIT-1:0] regs[0:DIN-1];

  integer k = 0;
  integer j = 0 ;
  always @(negedge clk)begin
      if(k == DIN)begin
          valid_out <= 1;
          j = j + 1;
          k = k - 1; 
      end    
      if(j == (WIDTH - 1))begin
          k = k - 1;
          j = 0;
          valid_out <= 0;
      end
  end   
  genvar i;
  generate 
      for (i=0; i < DIN; i = i + 1)begin
          always @(posedge clk) begin
              if (valid_in)begin
                  if(i == 0)begin
                      regs[i] <= i_data;
                      k = k + 1;
                  end    
                  else
                      regs[i] <= regs[i-1];
              end
         end
     end
  endgenerate
  assign b = k;
  assign a = j;
  always @(posedge clk) begin
      if(valid_out)begin
          o_data0 <= regs[DIN-1];
          o_data1 <= regs[DIN-2];
          o_data2 <= regs[DIN-3];
          o_data3 <= regs[DIN-WIDTH-1];
          o_data4 <= regs[DIN-WIDTH-2];
          o_data5 <= regs[DIN-WIDTH-3];
          o_data6 <= regs[2];
          o_data7 <= regs[1];
          o_data8 <= regs[0];
      end     
  end

endmodule
                    