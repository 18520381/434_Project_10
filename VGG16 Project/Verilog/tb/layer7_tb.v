`timescale 1ns/1ps
module layer7_tb();
  
  parameter DATA_WIDTH = 32; 
  reg  [DATA_WIDTH*32-1:0] i_data;
  reg              clk, rst, valid_in;
  wire  [DATA_WIDTH*32-1:0] o_data;
  wire         valid_out;
  

  parameter WIDTH = 28;
  parameter t = 10;
  localparam DIM = WIDTH*WIDTH;
  localparam DOUT = (WIDTH/2)*(WIDTH/2);
  
  always @(*) 
      #(t/2) clk <= ~clk;
      
  layer7_1 dut(i_data, clk, rst, valid_in, o_data, valid_out);
  
  reg [DATA_WIDTH*32-1:0] rom[0:DIM-1];
  initial begin
      $readmemb("input_layer7.txt", rom);
  end
     // Output ram
    reg  [DATA_WIDTH*32-1:0]    out_ram[0:DOUT-1];
    wire [DATA_WIDTH*32-1:0]    din;
    reg  [$clog2(DOUT)-1:0]     addr;


    always @ (posedge clk) begin
        if (valid_out)
            out_ram[addr] <= din;
    end

    always @ (posedge clk or posedge rst) begin
        if (rst)
            addr <= 0;
        else if (valid_out)
            addr <= (addr == (DOUT - 1)) ? 0 : (addr + 1);
    end

    assign din = o_data;
  integer i;
  initial begin
    clk <= 0;
    rst <= 1;
    valid_in <= 0;
    #t;
    rst <= 0;
    #5;
    for (i = 0; i < DIM; i = i + 1) begin
            i_data <= rom[i];
            valid_in <= 1'b1;
            #t;
     end
     valid_in <= 1'b0;
     #(t*1000);
     
     $writememb("input_layer8.txt", out_ram);
     $finish;
   end
endmodule
      
  











