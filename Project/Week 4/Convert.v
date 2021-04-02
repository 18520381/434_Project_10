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