
module pipeline_layer6#(
    parameter DATA_WIDTH = 32,
    parameter bias = 32'b01000000000000000000000000000000
)(
    input [DATA_WIDTH*32-1:0] i_pipeline_layer6,
    input clk, rst, valid_in_bias,
    input [5:0] valid_pipeline,
    output reg [DATA_WIDTH-1:0] o_data
);
  
  /////////////////// ADDER1//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg1[0:15];
    wire [DATA_WIDTH-1:0] y1 [0:15];
    genvar i;
    
    generate 
        for(i = 1; i < 32; i = i + 2) begin
            Add_FP add1(y1[(i-1)/2], i_pipeline_layer6[DATA_WIDTH*i-1:DATA_WIDTH*(i-1)], i_pipeline_layer6[DATA_WIDTH*(i+1)-1:DATA_WIDTH*i]);
        end
    endgenerate
   
    generate 
          for(i = 0; i < 16; i = i + 1) begin     
              always @(posedge clk or posedge rst) begin      
                 if(rst)
                      reg1[i] <= 32'd0;
                 else if (valid_in_bias)
                      reg1[i] <= y1[i];
              end
        end
    endgenerate       

/////////////////// ADDER2//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg2[0:7];
    wire [DATA_WIDTH-1:0] y2[0:7];
    
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
                 else if (valid_pipeline[0])
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
                 else if (valid_pipeline[1])
                      reg3[i] <= y3[i];
              end
        end
    endgenerate 
/////////////////// ADDER4//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg4[0:1];
    wire [DATA_WIDTH-1:0] y4[0:1];
    
    Add_FP add4(y4[0], reg3[0], reg3[1]);
    Add_FP add41(y4[1], reg3[2], reg3[3]);
   
    always @(posedge clk or posedge rst) begin      
             if(rst)begin
                 reg4[0] <= 32'd0;
                 reg4[1] <= 32'd0;
              end
              else if (valid_pipeline[2]) begin
                 reg4[0] <= y4[0];
                 reg4[1] <= y4[1];
              end          
    end

/////////////////// ADDER5//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg5[0:1];
    wire [DATA_WIDTH-1:0] y5;
    
    Add_FP add5(y5, reg4[0], reg4[1]);
       
     always @(posedge clk or posedge rst) begin      
             if(rst)begin
                 reg5[0] <= 32'd0;
                 reg5[1] <= 32'd0;
              end
              else if (valid_pipeline[3]) begin
                 reg5[0] <= y5;
                 reg5[1] <= bias;
              end          
    end

/////////////////// ADDER6//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg6;
    wire [DATA_WIDTH-1:0] y6;
    
    Add_FP add6(y6, reg5[0], reg5[1]); 
          
    always @(posedge clk or posedge rst) begin      
        if(rst)
            reg6 <= 32'd0;
        else if (valid_pipeline[4])
            reg6 <= y6;
    end
/////////////////// ReLU//////////////////////////////////////////////////////////////////////
    wire [DATA_WIDTH-1:0] y7;
    
    ReLU relu(reg6, y7);
  
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            o_data <= 32'd0;
        end
        else if (valid_pipeline[5])begin
            o_data <= y7;
        end
    end  
    
        
endmodule







