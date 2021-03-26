# Convert RBG to Grayscales of an image (Verilog)
- Python program from the last week: [The repository](https://github.com/18520381/434_Project_10/tree/main/Project/Week%202)
### RGB to grayscales conservation:
Formular: L = 0.296 * Red + 0.585 * Green + 0.117 * Blue
![alt text](https://github.com/18520381/434_Project_10/blob/2b67cc709b54f53f75065c8e903ed8075dfb6a91/Project/Week%203/Untitled%20Diagram.png
)

### Convert R G B value to L value by Verilog 
```
module Convert(
    input clk, reset,
    input [23:0] RGB,

    output reg [7:0] L
);

    always @ (posedge clk or posedge reset) begin
        if (reset)
            L <= 0;
        else
            L <=    (RGB[7:0]   >> 2) + (RGB[7:0]   >> 5) + (RGB[7:0]   >> 6) +
                    (RGB[15:8]  >> 1) + (RGB[15:8]  >> 4) + (RGB[15:8]  >> 6) + 
		    (RGB[15:8]  >> 7) + (RGB[23:16] >> 4) + (RGB[23:16] >> 5) +
                    (RGB[23:16] >> 6) + (RGB[23:16] >> 7);
    end

endmodule
```
### Create params.v file 
```
parameter WIDTH = 100;
parameter HEIGHT = 100;
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
    initial begin
        $readmemb("RGB10k.txt", rom);
    end

    always @ clk
        #(t / 2) clk <= ~clk;

    Convert dut(
        .clk(clk),
        .reset(reset),
        .RGB(RGB),
        .L(L)
    );

    // Output ram
    reg  [7:0]             out_ram[0:DIM-1];
    wire [7:0]             din;
    reg  [$clog2(DIM)-1:0] addr;
    reg                    we_1, we_2;

    always @ (posedge clk or posedge reset) begin
        if (reset)
            we_2 <= 1'b0;
        else
            we_2 <= we_1;
    end

    always @ (posedge clk) begin
        if (we_2)
            out_ram[addr] <= din;
    end

    always @ (posedge clk or posedge reset) begin
        if (reset)
            addr <= 0;
        else if (we_2)
            addr <= (addr == (DIM - 1)) ? 0 : (addr + 1);
    end

    assign din = L;

    integer i;
    initial begin
        reset <= 1'b1;
        clk   <= 1'b1;
        we_1  <= 1'b0;
        #(t * 5);
        reset <= 1'b0;
        #2;

        for (i = 0; i < WIDTH * HEIGHT; i = i + 1) begin
            RGB <= rom[i];
            we_1 <= 1'b1;
            #t;
        end
        we_1 <= 1'b0;

        #(t * 10);

        $writememb("Gray.txt", out_ram);
        $finish;
    end

endmodule

```
### Make a auto file
```
import os
# Run RGB2Binary.py to convert RGB Image to Binary txt file
os.system('python3 /home/pc/Python/Convert_RGB_Binary.py')

# Compile module verilog and testbench
os.system('vlog /home/pc/FPGA/Convert.v /home/pc/FPGA/testbench11.v')

# Run simulation
os.system('vsim -c -do "run -all" testbench11')

# Convert Binary to Decimal and display result
os.system('python3 /home/pc/Python/Processing.py')
```
