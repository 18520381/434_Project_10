`timescale 1ns/1ps
module layer1_tb();
  
  parameter DATA_WIDTH = 32; 
  reg  [DATA_WIDTH*3-1:0] i_data;
  reg              clk, rst, wr_req_FIFO_IN;
  wire  [DATA_WIDTH-1:0] o_data0, o_data1, o_data2, o_data3;
  wire         valid_out;
  

  parameter WIDTH = 112;
  parameter t = 10;
  localparam DIM = (WIDTH)*(WIDTH);
  //localparam DOUT = ((WIDTH)/2)*((WIDTH)/2);
  
  always @(*) 
      #(t/2) clk <= ~clk;
      
  layer1 dut(i_data,clk, rst, wr_req_FIFO_IN, o_data0, o_data1, o_data2, o_data3, valid_out);
  
  reg [95:0] rom[0:DIM-1];
  initial begin
      $readmemb("Lenna_conv.txt", rom);
  end
     // Output ram
    reg  [31:0]            out_ram0[0:DIM-1];
    reg  [31:0]            out_ram1[0:DIM-1];
    reg  [31:0]            out_ram2[0:DIM-1];
    reg  [31:0]            out_ram3[0:DIM-1];
    wire [31:0]             din0, din1, din2, din3;
    reg  [$clog2(DIM)-1:0] addr;


    always @ (posedge clk) begin
        if (valid_out)
            out_ram0[addr] <= din0;
            out_ram1[addr] <= din1;
            out_ram2[addr] <= din2;
            out_ram3[addr] <= din3;
    end

    always @ (posedge clk or posedge rst) begin
        if (rst)
            addr <= 0;
        else if (valid_out)
            addr <= (addr == (DIM - 1)) ? 0 : (addr + 1);
    end

    assign din0 = o_data0;
    assign din1 = o_data1;
    assign din2 = o_data2;
    assign din3 = o_data3;
  integer i;
  initial begin
    clk <= 0;
    rst <= 1;
    wr_req_FIFO_IN <= 0;
    #t;
    rst <= 0;
    #5;
    for (i = 0; i < DIM; i = i + 1) begin
            i_data <= rom[i];
            wr_req_FIFO_IN <= 1'b1;
            #t;
     end
     wr_req_FIFO_IN <= 1'b0;
     #(t*1000);
     
     $writememb("Lenna_convert.txt", out_ram0);
     $writememb("Lenna_convert1.txt", out_ram1);
     $writememb("Lenna_convert2.txt", out_ram2);
     $writememb("Lenna_convert3.txt", out_ram3);
     $finish;
   end
endmodule
      
  
