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