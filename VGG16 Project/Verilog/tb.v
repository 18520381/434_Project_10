
`timescale 100ns/1ps
module tb();
  reg clk,valid_in;
  reg [31:0] i_data;
  wire [31:0] o_data0,o_data1,o_data2,o_data3,o_data4,o_data5,o_data6,o_data7,o_data8;
  wire valid_out;
  wire [4:0] j,k;
  parameter t = 10;
  
  always @ clk
        #(t / 2) clk <= ~clk;
        
  linebuff dut(o_data0,o_data1,o_data2,o_data3,o_data4,o_data5,o_data6,o_data7,o_data8,i_data,valid_in,clk,valid_out,j,k);
  integer i;
  initial begin
    clk <= 0; 
    valid_in <= 0; 
    #2;
    
    for ( i = 0; i < 25; i = i + 1)begin
        valid_in <= 1;
        i_data <= i;
         #t;
      end
    /*  for ( i = 8; i < 150; i = i + 1)begin
        valid_out <= 1
        valid_in <= 1;
        i_data <= i;  
        #t;
      end
    for ( i = 8; i < 150; i = i + 1)begin
      if(i%2== 0)begin
        value_out <= 1;
        value_in <= 0; 
        #t;
      end
      if(i%2== 1)begin
        value_out <= 0;
        value_in <= 1;
        i_data <= i; 
        #t;
      end
    end*/
    valid_in <= 0;
    #(t*2);
    $finish;
  end 
endmodule      
