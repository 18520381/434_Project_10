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
