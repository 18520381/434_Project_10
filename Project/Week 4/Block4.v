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
