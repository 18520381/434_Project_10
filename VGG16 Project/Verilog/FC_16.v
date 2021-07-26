module FC_16#(
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
    parameter bias  = 32'b01000000000000000000000000000000
)(
  input  [DATA_WIDTH*16-1:0] i_data,
  input         clk, rst, valid_in,
  input  [4:0] valid_pipeline_FC,
  output reg[DATA_WIDTH-1:0] o_data        
);

/////////////////// Mul1//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg1[0:15];
    wire [DATA_WIDTH-1:0] y1 [0:15];
    
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
          end
    end    
    
  

/////////////////// ADDER2//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg2[0:7];
    wire [DATA_WIDTH-1:0] y2[0:7];
    genvar i;
    generate 
        for(i = 0; i < 16; i = i + 2) begin
            Add_FP add2(y2[i/2], reg1[i], reg1[i+1]);
        end
    endgenerate
   
    generate 
          for(i = 0; i < 8; i = i + 1) begin     
              always @(posedge clk or posedge rst) begin      
                 if(rst)
                      reg2[i] <= 32'd0;
                 else if (valid_pipeline_FC[0])
                      reg2[i] <= y2[i];
              end
        end
    endgenerate 
/////////////////// ADDER3//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg3[0:3];
    wire [DATA_WIDTH-1:0] y3[0:3];
    
    generate 
        for(i = 0; i < 8; i = i + 2) begin
            Add_FP add3(y3[i/2], reg2[i], reg2[i+1]);
        end
    endgenerate
   
    generate 
          for(i = 0; i < 4; i = i + 1) begin     
              always @(posedge clk or posedge rst) begin      
                 if(rst)
                      reg3[i] <= 32'd0;
                 else if (valid_pipeline_FC[1])
                      reg3[i] <= y3[i];
              end
        end
    endgenerate 
/////////////////// ADDER4//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg4[0:1];
    wire [DATA_WIDTH-1:0] y4[0:1];
    
    generate 
        for(i = 0; i < 4; i = i + 2) begin
            Add_FP add4(y4[i/2], reg3[i], reg3[i+1]);
        end
    endgenerate
   
    generate 
          for(i = 0; i < 2; i = i + 1) begin     
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
    wire [DATA_WIDTH-1:0] y5;
  
    Add_FP add6(y5, reg4[0], reg4[1]);
            
   always @(posedge clk or posedge rst) begin      
        if(rst)begin
            reg5[0] <= 32'd0;
            reg5[1] <= 32'd0;
        end
        else if (valid_pipeline_FC[3])begin
            reg5[0] <= y5;
            reg5[1] <= bias;
        end
  end
/////////////////// ADDER7//////////////////////////////////////////////////////////////////////
    wire [DATA_WIDTH-1:0] y6;
  
    Add_FP add7(y6, reg5[0], reg5[1]);
            
   always @(posedge clk or posedge rst) begin      
        if(rst)
            o_data <= 32'd0;   
        else if (valid_pipeline_FC[4])
            o_data <= y6;
  end

        
endmodule





