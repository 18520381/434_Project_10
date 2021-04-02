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
