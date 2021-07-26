
module lineMax#(
  parameter DATA_WIDTH = 32,
  parameter WIDTH = 5
)(
  output [DATA_WIDTH-1:0] o_data0,o_data1,o_data2,o_data3,
  input  [DATA_WIDTH-1:0] i_data,
  input            valid_in, clk, rst          
);
  
  parameter DIN = WIDTH + 2;
  reg [DATA_WIDTH-1:0] regs[0:DIN-1];

  genvar i;
  generate 
      for (i=0; i < DIN; i = i + 1)begin
          always @(posedge clk) begin
              if (valid_in)begin
                  if(i == 0)
                      regs[i] <= i_data;    
                  else
                      regs[i] <= regs[i-1];
              end
         end
     end
  endgenerate
  
  
          assign o_data0 = regs[DIN-1];
          assign o_data1 = regs[DIN-2];
          assign o_data2 = regs[1];
          assign o_data3 = regs[0];

endmodule
                    


