module FC#(
    parameter DATA_WIDTH = 32,
    parameter k1  = 32'b01000000000000000000000000000000,
    parameter k2  = 32'b01000000000000000000000000000000,
    parameter k3  = 32'b01000000000000000000000000000000,
    parameter k4  = 32'b01000000000000000000000000000000,
    parameter k5  = 32'b01000000000000000000000000000000,
    parameter k6  = 32'b01000000000000000000000000000000,
    parameter k7  = 32'b01000000000000000000000000000000,
    parameter k8  = 32'b01000000000000000000000000000000,
    parameter k9  = 32'b01000000000000000000000000000000,
    parameter k10  = 32'b01000000000000000000000000000000,
    parameter k11  = 32'b01000000000000000000000000000000,
    parameter k12  = 32'b01000000000000000000000000000000,
    parameter k13  = 32'b01000000000000000000000000000000,
    parameter k14  = 32'b01000000000000000000000000000000,
    parameter k15  = 32'b01000000000000000000000000000000,
    parameter k16  = 32'b01000000000000000000000000000000,
    parameter k17  = 32'b01000000000000000000000000000000,
    parameter k18  = 32'b01000000000000000000000000000000,
    parameter k19  = 32'b01000000000000000000000000000000,
    parameter k20  = 32'b01000000000000000000000000000000,
    parameter k21  = 32'b01000000000000000000000000000000,
    parameter k22  = 32'b01000000000000000000000000000000,
    parameter k23  = 32'b01000000000000000000000000000000,
    parameter k24  = 32'b01000000000000000000000000000000,
    parameter k25  = 32'b01000000000000000000000000000000,
    parameter k26  = 32'b01000000000000000000000000000000,
    parameter k27  = 32'b01000000000000000000000000000000,
    parameter k28  = 32'b01000000000000000000000000000000,
    parameter k29  = 32'b01000000000000000000000000000000,
    parameter k30  = 32'b01000000000000000000000000000000,
    parameter k31  = 32'b01000000000000000000000000000000,
    parameter k32  = 32'b01000000000000000000000000000000,
    parameter bias  = 32'b01000000000000000000000000000000
)(
  input  [DATA_WIDTH*32-1:0] i_data,
  input         clk, rst, valid_in,
  input  [6:0] valid_pipeline_FC,
  output reg[DATA_WIDTH-1:0] o_data        
);

/////////////////// Mul1//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg1[0:31];
    wire [DATA_WIDTH-1:0] y1 [0:31];
    
    Mul m1(i_data[DATA_WIDTH*1-1:0], k1, y1[0]); 
    Mul m2(i_data[DATA_WIDTH*2-1:DATA_WIDTH*1], k2, y1[1]); 
    Mul m3(i_data[DATA_WIDTH*3-1:DATA_WIDTH*2], k3, y1[2]); 
    Mul m4(i_data[DATA_WIDTH*4-1:DATA_WIDTH*3], k4, y1[3]);
    Mul m5(i_data[DATA_WIDTH*5-1:DATA_WIDTH*4], k5, y1[4]); 
    Mul m6(i_data[DATA_WIDTH*6-1:DATA_WIDTH*5], k6, y1[5]); 
    Mul m7(i_data[DATA_WIDTH*7-1:DATA_WIDTH*6], k7, y1[6]); 
    Mul m8(i_data[DATA_WIDTH*8-1:DATA_WIDTH*7], k8, y1[7]); 
    Mul m9(i_data[DATA_WIDTH*9-1:DATA_WIDTH*8], k9, y1[8]); 
    Mul m10(i_data[DATA_WIDTH*10-1:DATA_WIDTH*9], k10, y1[9]); 
    Mul m11(i_data[DATA_WIDTH*11-1:DATA_WIDTH*10], k11, y1[10]); 
    Mul m12(i_data[DATA_WIDTH*12-1:DATA_WIDTH*11], k12, y1[11]); 
    Mul m13(i_data[DATA_WIDTH*13-1:DATA_WIDTH*12], k13, y1[12]); 
    Mul m14(i_data[DATA_WIDTH*14-1:DATA_WIDTH*13], k14, y1[13]); 
    Mul m15(i_data[DATA_WIDTH*15-1:DATA_WIDTH*14], k15, y1[14]); 
    Mul m16(i_data[DATA_WIDTH*16-1:DATA_WIDTH*15], k16, y1[15]); 
    Mul m17(i_data[DATA_WIDTH*17-1:DATA_WIDTH*16], k17, y1[16]); 
    Mul m18(i_data[DATA_WIDTH*18-1:DATA_WIDTH*17], k18, y1[17]); 
    Mul m19(i_data[DATA_WIDTH*19-1:DATA_WIDTH*18], k19, y1[18]); 
    Mul m20(i_data[DATA_WIDTH*20-1:DATA_WIDTH*19], k20, y1[19]); 
    Mul m21(i_data[DATA_WIDTH*21-1:DATA_WIDTH*20], k21, y1[20]); 
    Mul m22(i_data[DATA_WIDTH*22-1:DATA_WIDTH*21], k22, y1[21]); 
    Mul m23(i_data[DATA_WIDTH*23-1:DATA_WIDTH*22], k23, y1[22]); 
    Mul m24(i_data[DATA_WIDTH*24-1:DATA_WIDTH*23], k24, y1[23]); 
    Mul m25(i_data[DATA_WIDTH*25-1:DATA_WIDTH*24], k25, y1[24]); 
    Mul m26(i_data[DATA_WIDTH*26-1:DATA_WIDTH*25], k26, y1[25]); 
    Mul m27(i_data[DATA_WIDTH*27-1:DATA_WIDTH*26], k27, y1[26]); 
    Mul m28(i_data[DATA_WIDTH*28-1:DATA_WIDTH*27], k28, y1[27]); 
    Mul m29(i_data[DATA_WIDTH*29-1:DATA_WIDTH*28], k29, y1[28]); 
    Mul m30(i_data[DATA_WIDTH*30-1:DATA_WIDTH*29], k30, y1[29]); 
    Mul m31(i_data[DATA_WIDTH*31-1:DATA_WIDTH*30], k31, y1[30]);
    Mul m32(i_data[DATA_WIDTH*32-1:DATA_WIDTH*31], k32, y1[31]);
    
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
              reg1[9]   <= 32'd0;  
              reg1[10]   <= 32'd0; 
              reg1[11]   <= 32'd0; 
              reg1[12]   <= 32'd0; 
              reg1[13]   <= 32'd0; 
              reg1[14]   <= 32'd0; 
              reg1[15]   <= 32'd0; 
              reg1[16]   <= 32'd0; 
              reg1[17]   <= 32'd0;
              reg1[18]   <= 32'd0;  
              reg1[19]   <= 32'd0; 
              reg1[20]   <= 32'd0; 
              reg1[21]   <= 32'd0; 
              reg1[22]   <= 32'd0; 
              reg1[23]   <= 32'd0; 
              reg1[24]   <= 32'd0; 
              reg1[25]   <= 32'd0; 
              reg1[26]   <= 32'd0;
              reg1[27]   <= 32'd0; 
              reg1[28]   <= 32'd0; 
              reg1[29]   <= 32'd0; 
              reg1[30]   <= 32'd0; 
              reg1[31]   <= 32'd0; 
          end
        else if(valid_in)
          begin
              reg1[0] <= y1[0]; 
              reg1[1] <= y1[1]; 
              reg1[2] <= y1[2]; 
              reg1[3] <= y1[3]; 
              reg1[4] <= y1[4]; 
              reg1[5] <= y1[5]; 
              reg1[6] <= y1[6]; 
              reg1[7] <= y1[7]; 
              reg1[8] <= y1[8]; 
              reg1[9] <= y1[9]; 
              reg1[10] <= y1[10]; 
              reg1[11] <= y1[11]; 
              reg1[12] <= y1[12]; 
              reg1[13] <= y1[13]; 
              reg1[14] <= y1[14]; 
              reg1[15] <= y1[15]; 
              reg1[16] <= y1[16]; 
              reg1[17] <= y1[17]; 
              reg1[18] <= y1[18]; 
              reg1[19] <= y1[19]; 
              reg1[20] <= y1[20]; 
              reg1[21] <= y1[21]; 
              reg1[22] <= y1[22]; 
              reg1[23] <= y1[23]; 
              reg1[24] <= y1[24]; 
              reg1[25] <= y1[25]; 
              reg1[26] <= y1[26];  
              reg1[27] <= y1[27];  
              reg1[28] <= y1[28];            
              reg1[29] <= y1[29];             
              reg1[30] <= y1[30];              
              reg1[31] <= y1[31];
          end
    end    
    
  

/////////////////// ADDER2//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg2[0:15];
    wire [DATA_WIDTH-1:0] y2[0:15];
    genvar i;
    generate 
        for(i = 0; i < 32; i = i + 2) begin
            Add_FP add2(y2[i/2], reg1[i], reg1[i+1]);
        end
    endgenerate
   
    generate 
          for(i = 0; i < 16; i = i + 1) begin     
              always @(posedge clk or posedge rst) begin      
                 if(rst)
                      reg2[i] <= 32'd0;
                 else if (valid_pipeline_FC[0])
                      reg2[i] <= y2[i];
              end
        end
    endgenerate 
/////////////////// ADDER3//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg3[0:7];
    wire [DATA_WIDTH-1:0] y3[0:7];
    
    generate 
        for(i = 0; i < 16; i = i + 2) begin
            Add_FP addl11(y3[i/2], reg2[i], reg2[i+1]);
        end
    endgenerate
   
    generate 
          for(i = 0; i < 8; i = i + 1) begin     
              always @(posedge clk or posedge rst) begin      
                 if(rst)
                      reg3[i] <= 32'd0;
                 else if (valid_pipeline_FC[1])
                      reg3[i] <= y3[i];
              end
        end
    endgenerate 
/////////////////// ADDER4//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg4[0:3];
    wire [DATA_WIDTH-1:0] y4[0:3];
    
    generate 
        for(i = 0; i < 8; i = i + 2) begin
            Add_FP add4(y4[i/2], reg3[i], reg3[i+1]);
        end
    endgenerate
   
    generate 
          for(i = 0; i < 4; i = i + 1) begin     
              always @(posedge clk or posedge rst) begin      
                 if(rst)
                      reg4[i] <= 32'd0;
                 else if (valid_pipeline_FC[2])
                      reg4[i] <= y4[i];
              end
        end
    endgenerate 
/////////////////// ADDER5//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg5[0:1];
    wire [DATA_WIDTH-1:0] y5[0:1];
    
    generate 
        for(i = 0; i < 4; i = i + 2) begin
            Add_FP add5(y5[i/2], reg4[i], reg4[i+1]);
        end
    endgenerate
   
    generate 
          for(i = 0; i < 2; i = i + 1) begin     
              always @(posedge clk or posedge rst) begin      
                 if(rst)
                      reg5[i] <= 32'd0;
                 else if (valid_pipeline_FC[3])
                      reg5[i] <= y5[i];
              end
        end
    endgenerate 
/////////////////// ADDER6//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg6[0:1];
    wire [DATA_WIDTH-1:0] y6;
  
    Add_FP add6(y6, reg5[0], reg5[1]);
            
   always @(posedge clk or posedge rst) begin      
        if(rst)begin
            reg6[0] <= 32'd0;
            reg6[1] <= 32'd0;
        end
        else if (valid_pipeline_FC[4])begin
            reg6[0] <= y6;
            reg6[1] <= bias;
        end
  end
/////////////////// ADDER7//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg7;
    wire [DATA_WIDTH-1:0] y7;
  
    Add_FP add7(y7, reg6[0], reg6[1]);
            
   always @(posedge clk or posedge rst) begin      
        if(rst)
            reg7 <= 32'd0;   
        else if (valid_pipeline_FC[5])
            reg7 <= y7;
  end
/////////////////// ReLU//////////////////////////////////////////////////////////////////////
    wire [DATA_WIDTH-1:0] y8;
    
    ReLU relu(reg7, y8);
  
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            o_data <= 32'd0;
        end
        else if (valid_pipeline_FC[6])begin
            o_data <= y8;
        end
    end  
    
        
endmodule



