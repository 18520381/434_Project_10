`timescale 1ns/1ps

module MaxPooling_tb();
    reg [32-1:0] i_data;
    reg valid_in, clk, rst;
    wire [32-1:0] o_data;
    wire valid_out;
    
    parameter t = 10;
  
    always @ clk
        #(t / 2) clk <= ~clk;

    MaxPooling dut(i_data, valid_in, clk, rst, o_data, valid_out);
    
    integer i;
    initial begin
      clk <= 0;
      rst <= 1;
      valid_in <= 0;
      #t;
      rst <= 0;
      #(t/2);
      for(i = 0; i < 36 ; i = i + 1) begin
          valid_in <= 1;
          i_data <= i;
          #t;
      end
      
      valid_in <= 0;
      #(t*10);
      $finish;
    end
    
endmodule
      