# Sữa lỗi tuần trước , thêm value_in, value_out
###  Convert R G B value to L value by Verilog 
```
module Convert(
    input clk, reset,
    input [23:0] RGB,

    output reg [7:0] L
);
    reg [7:0] a,a1,a2,b,b1,b2,b3,c,c1,c2,c3,d,d1,d2,d3,d4,e,e1,e2,f;
    always @ (posedge clk or posedge reset) begin
        if (reset)
           	L = 0;
        else begin
		a  = RGB[7:0]   >> 2;
		a1 = RGB[7:0]   >> 5;
		a2 = RGB[7:0]   >> 6;
		b  = RGB[15:8]  >> 1;
		b1 = RGB[15:8]  >> 4;
		b2 = RGB[15:8]  >> 6;
		b3 = RGB[15:8]  >> 7;
		c  = RGB[23:16] >> 4;
		c1 = RGB[23:16] >> 5;
		c2 = RGB[23:16] >> 6;
		c3 = RGB[23:16] >> 7;	
		d  = a + a1;
		d1 = b + b1;
		d2 = b3 + b2;
		d3 = c1 + c;
		d4 = c3 + c2;
		e  = d + d1;
		e1 = d2 + d3;
		e2 = d4 + a2;
		f  = e + e1;
		L  = f + e2; 
	end
   end

endmodule
```
### Create binary file from testbench by Verilog
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
    reg                    value_in, value_out;
    initial begin
	if(value_in)
	        $readmemb("RGB.txt", rom);
    end

    always @ clk
        #(t / 2) clk <= ~clk;

    Convert dut(
        .clk(clk),
        .reset(reset),
        .RGB(RGB),
        .L(L)
    );

   //Addr RAM
    always @ (posedge clk or posedge reset) begin
        if (reset)
            value_out <= 1'b0;
        else
            value_out <= value_in;
    end

    always @ (posedge clk or posedge reset) begin
        if (reset)
            addr <= 0;
        else if (value_out)
            addr <= (addr == (DIM - 1)) ? 0 : (addr + 1);
    end	
    //Value RAM
    assign din = L;
    always @ (posedge clk) begin
        if (value_out)
            out_ram[addr] <= din;
    end

    integer i;
    initial begin
        reset <= 1'b1;
        clk   <= 1'b1;
        value_in  <= 1'b0;
        #(t * 5);
        reset <= 1'b0;
        #2;

        for (i = 0; i < WIDTH * HEIGHT; i = i + 1) begin
            RGB <= rom[i];
            value_in <= 1'b1;
            #t;
        end
        value_in <= 1'b0;

        #(t * 10);
	if(value_out)
        	$writememb("Gray.txt", out_ram);
        $finish;
    end

endmodule
```
