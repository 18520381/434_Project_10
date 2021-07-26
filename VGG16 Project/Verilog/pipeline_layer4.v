
module pipeline_layer4#(
    parameter DATA_WIDTH = 32,
    parameter bias = 32'b01000000000000000000000000000000
)(
    input [DATA_WIDTH*16-1:0] i_pipeline_layer4,
    input clk, rst, valid_in_bias,
    input [4:0] valid_pipeline,
    output reg [DATA_WIDTH-1:0] o_data
);
  
  /////////////////// ADDER1//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg1[0:7];
    wire [DATA_WIDTH-1:0] y1 [0:7];
    genvar i;
    
    generate 
        for(i = 1; i < 16; i = i + 2) begin
            Add_FP add1(y1[(i-1)/2], i_pipeline_layer4[DATA_WIDTH*i-1:DATA_WIDTH*(i-1)], i_pipeline_layer4[DATA_WIDTH*(i+1)-1:DATA_WIDTH*i]);
        end
    endgenerate
   
    generate 
          for(i = 0; i < 8; i = i + 1) begin     
              always @(posedge clk or posedge rst) begin      
                 if(rst)
                      reg1[i] <= 32'd0;
                 else if (valid_in_bias)
                      reg1[i] <= y1[i];
              end
        end
    endgenerate       

/////////////////// ADDER2//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg2[0:3];
    wire [DATA_WIDTH-1:0] y2[0:3];
    
    generate 
        for(i = 0; i < 8; i = i + 2) begin
            Add_FP add2(y2[i/2], reg1[i], reg1[i+1]);
        end
    endgenerate
   
    generate 
          for(i = 0; i < 4; i = i + 1) begin     
              always @(posedge clk or posedge rst) begin      
                 if(rst)
                      reg2[i] <= 32'd0;
                 else if (valid_pipeline[0])
                      reg2[i] <= y2[i];
              end
        end
    endgenerate 
/////////////////// ADDER3//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg3[0:1];
    wire [DATA_WIDTH-1:0] y3[0:1];
    
    generate 
        for(i = 0; i < 4; i = i + 2) begin
            Add_FP add3(y3[i/2], reg2[i], reg2[i+1]);
        end
    endgenerate
   
    generate 
          for(i = 0; i < 2; i = i + 1) begin     
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
    wire [DATA_WIDTH-1:0] y4;
    
    Add_FP add4(y4, reg3[0], reg3[1]);
       
     always @(posedge clk or posedge rst) begin      
             if(rst)begin
                 reg4[0] <= 32'd0;
                 reg4[1] <= 32'd0;
              end
              else if (valid_pipeline[2]) begin
                 reg4[0] <= y4;
                 reg4[1] <= bias;
              end          
    end

/////////////////// ADDER5//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg5;
    wire [DATA_WIDTH-1:0] y5;
    
    Add_FP add5(y5, reg4[0], reg4[1]); 
          
    always @(posedge clk or posedge rst) begin      
        if(rst)
            reg5 <= 32'd0;
        else if (valid_pipeline[3])
            reg5 <= y5;
    end
/////////////////// ReLU//////////////////////////////////////////////////////////////////////
    wire [DATA_WIDTH-1:0] y6;
    
    ReLU relu(reg5, y6);
  
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            o_data <= 32'd0;
        end
        else if (valid_pipeline[4])begin
            o_data <= y6;
        end
    end  
    
        
endmodule






