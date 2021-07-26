
module pipeline_layer2#(
    parameter DATA_WIDTH = 32,
    parameter bias = 32'b01000000000000000000000000000000
)(
    input [DATA_WIDTH*8-1:0] i_pipeline_layer2,
    input clk, rst, valid_in_bias,
    input [3:0] valid_pipeline,
    output reg [DATA_WIDTH-1:0] o_data
);
  
  /////////////////// ADDER1//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg1[0:3];
    wire [DATA_WIDTH-1:0] y1 [0:3];
    
    Add_FP a1(y1[0], i_pipeline_layer2[DATA_WIDTH*1-1:DATA_WIDTH*0], i_pipeline_layer2[DATA_WIDTH*2-1:DATA_WIDTH*1]);
    Add_FP a2(y1[1], i_pipeline_layer2[DATA_WIDTH*3-1:DATA_WIDTH*2], i_pipeline_layer2[DATA_WIDTH*4-1:DATA_WIDTH*3]);
    Add_FP a3(y1[2], i_pipeline_layer2[DATA_WIDTH*5-1:DATA_WIDTH*4], i_pipeline_layer2[DATA_WIDTH*6-1:DATA_WIDTH*5]);
    Add_FP a4(y1[3], i_pipeline_layer2[DATA_WIDTH*7-1:DATA_WIDTH*6], i_pipeline_layer2[DATA_WIDTH*8-1:DATA_WIDTH*7]);

   
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            reg1[0] <= 32'd0;
            reg1[1] <= 32'd0;
            reg1[2] <= 32'd0;
            reg1[3] <= 32'd0;
        end
        else if (valid_in_bias)begin
            reg1[0] <= y1[0];
            reg1[1] <= y1[1];
            reg1[2] <= y1[2];
            reg1[3] <= y1[3];
        end
    end       

/////////////////// ADDER2//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg2[0:1];
    wire [DATA_WIDTH-1:0] y2[0:1];
    
    Add_FP a5(y2[0], reg1[0], reg1[1]);
    Add_FP a6(y2[1], reg1[2], reg1[3]);
   
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            reg2[0] <= 32'd0;
            reg2[1] <= 32'd0;
        end
        else if (valid_pipeline[0])begin
            reg2[0] <= y2[0];
            reg2[1] <= y2[1];
        end
    end   
/////////////////// ADDER3//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg3[0:1];
    wire [DATA_WIDTH-1:0] y3;
    
     Add_FP add3(y3, reg2[0], reg2[1]);
            
   always @(posedge clk or posedge rst) begin      
        if(rst)begin
            reg3[0] <= 32'd0;
            reg3[1] <= 32'd0;
        end
        else if (valid_pipeline[1])begin
            reg3[0] <= y3;
            reg3[1] <= bias;
        end
  end 
/////////////////// ADDER4//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg4;
    wire [DATA_WIDTH-1:0] y4;
    
  Add_FP add4(y4, reg3[0], reg3[1]);
            
   always @(posedge clk or posedge rst) begin      
        if(rst)begin
            reg4 <= 32'd0;
        end
        else if (valid_pipeline[2])begin
            reg4 <= y4;
        end
  end

/////////////////// ReLU//////////////////////////////////////////////////////////////////////
    wire [DATA_WIDTH-1:0] y5;
    
    ReLU relu(reg4, y5);
  
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            o_data <= 32'd0;
        end
        else if (valid_pipeline[3])begin
            o_data <= y5;
        end
    end  
        
endmodule


