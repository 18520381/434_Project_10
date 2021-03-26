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