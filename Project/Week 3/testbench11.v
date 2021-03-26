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