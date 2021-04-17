# Fix pipeline error

## Testbench
```
`timescale 1ns/1ps

module testbench11;

    `include "params.v"
    parameter DIM = WIDTH * HEIGHT;
    parameter t = 10;

    reg         clk, reset;
    reg  [23:0] RGB;
    wire [7:0]  L;

    reg [23:0] rom[0:DIM-1];

    // Output ram
    reg  [7:0]             out_ram[0:DIM-1];
    wire [7:0]             din;
    reg  [$clog2(DIM)-1:0] addr;
    reg                    w1, w2;
    reg [7:0]              out;
    initial begin
	        $readmemb("RGB.txt", rom);
    end

    always @ clk
        #(t / 2) clk <= ~clk;

    Convert dut(
        .clk(clk),
        .rst(reset),
        .RGB(RGB),
        .L(L)
    );

   //Addr RAM
    always @ (posedge clk or posedge reset) begin
        if (reset)
            w2 <= 1'b0;
        else 
            w2 <= w1;
    end

    always @ (posedge clk or posedge reset) begin
        if (reset)
            addr <= 0;
        else if (w2)
            addr <= (addr == (DIM - 1)) ? 0 : (addr + 1);
    end	
    //Value RAM
    assign din = L;
    always @ (posedge clk) begin
        if (w2)
            out_ram[addr] <= din;
    end

    integer i;
    initial begin
        reset <= 1'b1;
        clk   <= 1'b1;
        w1  <= 1'b0;
        #(t * 5);
        reset <= 1'b0;
        #2;

        for (i = 0; i < WIDTH * HEIGHT; i = i + 1) begin
            RGB <= rom[i];
	    if(i==4)
          	 w1 <= 1'b1;
            #t;
        end
	#(t*5);
         w1 <= 1'b0;

        #(t * 5);
        $writememb("Gray.txt", out_ram);
        $finish;
    end

endmodule

```
## Convert
```
module Convert(
   	 input clk, rst,
   	 input [23:0] RGB,

   	 output reg [7:0] L
);
   	wire [7:0] o [10:0];
	wire [7:0] o1 [4:0];
	wire [7:0] o2 [2:0];
	wire [7:0] o3, o4;
	reg [7:0] reg1[10:0];
	reg [7:0] reg2[4:0];
	reg [7:0] reg3[2:0];
	reg [7:0] reg4;

 	  Block1 a(RGB[7:0],RGB[15:8],RGB[23:16],o[0],o[1],o[2],o[3],o[4],o[5],o[6],o[7],o[8],o[9],o[10],clk,rst);
 	  Block2 b(o[0],o[1],o[3],o[4],o[5],o[6],o[7],o[8],o[9],o[10],o1[0],o1[1],o1[2],o1[3],o1[4],clk,rst);
	  Block3 c(o1[0],o1[1],o1[2],o1[3],o1[4],o[2],o2[0],o2[1],o2[2],clk,rst);
	  Block4 d(o2[0],o2[1],o3 , clk, rst);
	  Block4 e(o3, o2[2], o4 ,clk, rst);
assign 	L  = o4;
endmodule

```
