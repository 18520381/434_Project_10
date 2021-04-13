

# Fix the issue from last week
Project from the last week [The repository](https://github.com/18520381/434_Project_10/tree/main/Project/Week%203)

## Directory tree
![alt text](https://github.com/18520381/434_Project_10/blob/81089d3cb4ccd3f1d2c72b2a34269367f7b30b5c/Project/Week%204/Tree.png)

## RGB to grayscales conservation and diagram:
Formular: L = 0.281 * Red + 0.563 * Green + 0.094 * Blue 
![alt text](https://github.com/18520381/434_Project_10/blob/0c2d6752ed176ddb03e03317913f25833b17c153/Project/Week%204/Untitled%20Diagram(1).png)

## Convert to pipeline 

Problem: Chạy ra kết quả nhưng khi add vô file.txt thì lại bị xxxxxxx 

###  Convert R G B value to L value by Verilog 
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
    	always @(posedge clk)begin
	//reg1
		reg1[0] <= o[0];
		reg1[1] <= o[1];
		reg1[2] <= o[2];
		reg1[3] <= o[3];
		reg1[4] <= o[4];
		reg1[5] <= o[5];
		reg1[6] <= o[6];
		reg1[7] <= o[7];
		reg1[8] <= o[8];
		reg1[9] <= o[9];
		reg1[10] <= o[10];
	//reg2
		reg2[0] <= o1[0];
		reg2[1] <= o1[1];
		reg2[2] <= o1[2];
		reg2[3] <= o1[3];
		reg2[4] <= o1[4];
	// reg3
		reg3[0] <= o2[0];
		reg3[1] <= o2[1];
		reg3[2] <= o2[2];
	// reg4
		reg4    <= o3;
	// out
		L      <= o4;
	end

 	  Block1 a(RGB[7:0],RGB[15:8],RGB[23:16],o[0],o[1],o[2],o[3],o[4],o[5],o[6],o[7],o[8],o[9],o[10],clk,rst);
 	  Block2 b(reg1[0],reg1[1],reg1[3],reg1[4],reg1[5],reg1[6],reg1[7],reg1[8],reg1[9],reg1[10],o1[0],o1[1],o1[2],o1[3],o1[4],clk,rst);
	  Block3 c(reg2[0],reg2[1],reg2[2],reg2[3],reg2[4],reg1[2],o2[0],o2[1],o2[2],clk,rst);
	  Block4 d(reg3[0],reg3[1],o3 , clk, rst);
	  Block4 e(reg4, reg3[2], o4 ,clk, rst);
endmodule
```
```
module Block1(R,G,B, out1, out2,out3,out4,out5,out6,out7,out8,out9,out10,out11, clk,rst);
	input [7:0] R, G ,B;
	input clk, rst;
	output reg [7:0] out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11;
	always @(posedge clk or posedge rst)begin
		if(rst) begin
			out1 <= 0;
			out2 <= 0;
			out3 <= 0;
			out4 <= 0;
			out5 <= 0;
			out6 <= 0;
			out7 <= 0;
			out8 <= 0;
			out9 <= 0;
			out10 <= 0;
			out11 <= 0;
		end
		else begin
			out1 <= R >> 2;
			out2 <= R >> 5;
			out3 <= R >> 6;
			out4 <= G >> 1;
			out5 <= G >> 4;
			out6 <= G >> 6;
			out7 <= G >> 7;
			out8 <= B >> 4;
			out9 <= B >> 5;
			out10 <= B >> 6;
			out11 <= B >> 7;	
		end
	end
endmodule

```
```
module Block2(out1,out2,out4,out5,out6,out7,out8,out9,out10,out11,a,b,c,d,e,clk,rst);
	input [7:0]  out1,out2,out4,out5,out6,out7,out8,out9,out10,out11;
	input rst, clk;
	output reg [7:0] a , b, c, d, e;
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			a <= 0;
			b <= 0;
			c <= 0;
			d <= 0;
			e <= 0;
		end
		else begin
			a <= out1 + out2;
			b <= out4 + out5;
			c <= out6 + out7;
			d <= out8 + out9;
			e <= out10 + out11;
		end

	end
endmodule
```
```
module Block3(a,b,c,d,e,f,d0,d1,d2,clk,rst);
	input [7:0] a,b,c,d,e,f;
	input clk,rst;
	output reg [7:0] d0 ,d1,d2;
	always @(posedge clk or posedge rst)begin
		if(rst) begin
			d0 <= 0;
			d1 <= 0;
			d2 <= 0;
		end
		else begin
			d0 <= a + b;
			d1 <= c + d;
			d2 <= e + f;
		end
	end
endmodule
```
```
module Block4(d0,d1,q,clk,rst);
	input [7:0] d0,d1;
	input clk,rst;
	output reg [7:0] q;
	always @(posedge clk or posedge rst)begin
		if(rst) 
			q <= 0;
		else 
			q <= d0 + d1;
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
		if(i==10)
          	  value_in <= 1'b1;
            #t;
        end
	#(t * 11);
        value_in <= 1'b0;

        #(t * 20);
        $writememb("Gray.txt", out_ram);
        $finish;
    end

endmodule

```
