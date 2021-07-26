module Max9 #(
    parameter DATA_WIDTH = 32
  )(
    input [31:0] i1, i2, i3, i4, i5, i6, i7, i8, i9,
    input valid_in, 
    input [2:0] valid_in1, 
    input clk, rst,
    output reg[31:0] o_data
  );
  

/////////// Stage1 ////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg1[3:0];
    wire [DATA_WIDTH-1:0] y1[3:0];
    
    Max2 m1(i1, i2, y1[0]);
    Max2 m2(i3, i4, y1[1]);
    Max2 m3(i5, i6, y1[2]);
    Max2 m4(i7, i8, y1[3]);

    always @(posedge clk or posedge rst)
    begin
        if(rst)
          begin
              reg1[0]   <= 32'd0;
              reg1[1]   <= 32'd0;
              reg1[2]   <= 32'd0;
              reg1[3]   <= 32'd0;
          end
        else if(valid_in)
          begin
              reg1[0]   <= y1[0];  
              reg1[1]   <= y1[1]; 
              reg1[2]   <= y1[2];  
              reg1[3]   <= y1[3];  
          end
      end     
/////////// Stage2 ////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg2[1:0];
    wire [DATA_WIDTH-1:0] y2[1:0];
    
    Max2 m5(reg1[0], reg1[1], y2[0]);
    Max2 m6(reg1[2], reg1[3], y2[1]);

    always @(posedge clk or posedge rst)
    begin
        if(rst)
          begin
              reg2[0]   <= 32'd0;
              reg2[1]   <= 32'd0;
          end
        else if(valid_in1[0])
          begin
              reg2[0]   <= y2[0];  
              reg2[1]   <= y2[1];   
          end
      end     
/////////// Stage3 ////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg3[1:0];
    wire [DATA_WIDTH-1:0] y3;
    
    Max2 m7(reg2[0], reg2[1], y3);

    always @(posedge clk or posedge rst)
    begin
        if(rst)
          begin
              reg3[0]   <= 32'd0;
              reg3[1]   <= 32'd0;
          end
        else if(valid_in1[1])
          begin
              reg3[0]   <= y3;  
              reg3[1]   <= i9;   
          end
      end   
/////////// Stage4 ////////////////////////////////////////
    wire [DATA_WIDTH-1:0] y4;
    
    Max2 m8(reg3[0], reg3[1], y4);

    always @(posedge clk or posedge rst)
    begin
        if(rst)
          begin
              o_data   <= 32'd0;
          end
        else if(valid_in1[2])
          begin
              o_data   <= y4;    
          end
      end   

                  
endmodule
    



