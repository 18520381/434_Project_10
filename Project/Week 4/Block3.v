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
