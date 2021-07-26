module pipeline2D#(
    parameter DATA_WIDTH = 32,
    parameter k1  = 32'b01000000000000000000000000000000,
    parameter k2  = 32'b01000000000000000000000000000000,
    parameter k3  = 32'b01000000000000000000000000000000,
    parameter k4  = 32'b01000000000000000000000000000000,
    parameter k5  = 32'b01000000000000000000000000000000,
    parameter k6  = 32'b01000000000000000000000000000000,
    parameter k7  = 32'b01000000000000000000000000000000,
    parameter k8  = 32'b01000000000000000000000000000000,
    parameter k9  = 32'b01000000000000000000000000000000
)(  
    input [DATA_WIDTH-1:0] i1, i2, i3, i4, i5, i6, i7, i8, i9,
    input clk, rst, valid_in,
    input [3:0] valid_pipeline2D,
    output reg[DATA_WIDTH-1:0] o_data
);
/////////// Stage1 ////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg1[8:0];
    wire [DATA_WIDTH-1:0] y1_0;
    wire [DATA_WIDTH-1:0] y1_1; 
    wire [DATA_WIDTH-1:0] y1_2;
    wire [DATA_WIDTH-1:0] y1_3;
    wire [DATA_WIDTH-1:0] y1_4;
    wire [DATA_WIDTH-1:0] y1_5;
    wire [DATA_WIDTH-1:0] y1_6;
    wire [DATA_WIDTH-1:0] y1_7;
    wire [DATA_WIDTH-1:0] y1_8;
    
     Mul m1(i1, k1, y1_0);
     Mul m2(i2, k2, y1_1);
     Mul m3(i3, k3, y1_2);
     Mul m4(i4, k4, y1_3);
     Mul m5(i5, k5, y1_4);
     Mul m6(i6, k6, y1_5);
     Mul m7(i7, k7, y1_6);
     Mul m8(i8, k8, y1_7);
     Mul m9(i9, k9, y1_8);
     
    always @(posedge clk or posedge rst)
    begin
        if(rst)
          begin
              reg1[0]   <= 32'd0;  
              reg1[1]   <= 32'd0; 
              reg1[2]   <= 32'd0; 
              reg1[3]   <= 32'd0; 
              reg1[4]   <= 32'd0; 
              reg1[5]   <= 32'd0; 
              reg1[6]   <= 32'd0; 
              reg1[7]   <= 32'd0; 
              reg1[8]   <= 32'd0;
          end
        else if(valid_in)
          begin
              reg1[0]   <= y1_0;  
              reg1[1]   <= y1_1; 
              reg1[2]   <= y1_2; 
              reg1[3]   <= y1_3; 
              reg1[4]   <= y1_4; 
              reg1[5]   <= y1_5; 
              reg1[6]   <= y1_6; 
              reg1[7]   <= y1_7; 
              reg1[8]   <= y1_8; 
          end
    end  
/////////// Stage2 ////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg2[4:0];
    wire [DATA_WIDTH-1:0] y2_0;
    wire [DATA_WIDTH-1:0] y2_1;
    wire [DATA_WIDTH-1:0] y2_2;
    wire [DATA_WIDTH-1:0] y2_3;
    
    Add_FP a1(y2_0, reg1[0], reg1[1]);
    Add_FP a2(y2_1, reg1[2], reg1[3]);
    Add_FP a3(y2_2, reg1[4], reg1[5]);
    Add_FP a4(y2_3, reg1[6], reg1[7]);
    
    always @(posedge clk or posedge rst)
    begin
        if(rst)
          begin
              reg2[0]   <= 32'd0;  
              reg2[1]   <= 32'd0; 
              reg2[2]   <= 32'd0; 
              reg2[3]   <= 32'd0; 
              reg2[4]   <= 32'd0;
          end
        else if(valid_pipeline2D[0])
          begin
              reg2[0]   <= y2_0;  
              reg2[1]   <= y2_1; 
              reg2[2]   <= y2_2; 
              reg2[3]   <= y2_3; 
              reg2[4]   <= reg1[8];  
          end 
    end            
/////////// Stage3 ////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg3[2:0];
    wire [DATA_WIDTH-1:0] y3_0;
    wire [DATA_WIDTH-1:0] y3_1;
    
    Add_FP a6(y3_0, reg2[0], reg2[1]);
    Add_FP a7(y3_1, reg2[2], reg2[3]);

    always @(posedge clk or posedge rst)
    begin
        if(rst)
          begin
              reg3[0]   <= 32'd0;
              reg3[1]   <= 32'd0;
              reg3[2]   <= 32'd0;
          end
        else if(valid_pipeline2D[1])
          begin
              reg3[0]   <= y3_0;  
              reg3[1]   <= y3_1; 
              reg3[2]   <= reg2[4];   
          end
      end               
/////////// Stage4 ////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg4[1:0];
    wire [DATA_WIDTH-1:0] y4_0;
    
    Add_FP a8(y4_0, reg3[0], reg3[1]);

    always @(posedge clk or posedge rst)
    begin
        if(rst)
          begin
              reg4[0]   <= 32'd0;
              reg4[1]   <= 32'd0;
          end
        else if(valid_pipeline2D[2])
          begin
              reg4[0]   <= y4_0;  
              reg4[1]   <= reg3[2];   
          end
      end     
/////////// Stage5 ////////////////////////////////////////
    wire [DATA_WIDTH-1:0] y5_0;
    
    Add_FP a9(y5_0, reg4[0], reg4[1]);

    always @(posedge clk or posedge rst)
    begin
        if(rst)
          begin
              o_data      <= 32'd0;
          end
        else if(valid_pipeline2D[3])
          begin
              o_data      <= y5_0;     
          end
      end  

                  
endmodule



