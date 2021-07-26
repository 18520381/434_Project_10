module pipeline_layer1#(
    parameter DATA_WIDTH = 32,
    parameter bias = 32'b01000000000000000000000000000000
)(
    input [DATA_WIDTH*3-1:0] i_pipeline_layer1,
    input clk, rst, valid_in_bias,
    input [1:0] valid_pipeline,
    output reg [DATA_WIDTH-1:0] o_data
);
  
  /////////////////// ADDER1//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg1[0:1];
    wire [DATA_WIDTH-1:0] y1_0;
    wire [DATA_WIDTH-1:0] y1_1;
    
    Add_FP a1(y1_0, i_pipeline_layer1[31:0], i_pipeline_layer1[63:32]);
    Add_FP a2(y1_1, i_pipeline_layer1[95:64], bias);  
    
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            reg1[0] <= 32'd0;
            reg1[1] <= 32'd0;
        end
        else if (valid_in_bias)begin
            reg1[0] <= y1_0;
            reg1[1] <= y1_1;
        end
    end        

/////////////////// ADDER2//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg2;
    wire [DATA_WIDTH-1:0] y2_0;
    
    Add_FP a3(y2_0, reg1[0], reg1[1]);
  
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            reg2 <= 32'd0;
        end
        else if (valid_pipeline[0])begin
            reg2 <= y2_0;
        end
    end  

/////////////////// ReLU//////////////////////////////////////////////////////////////////////
    wire [DATA_WIDTH-1:0] y3_0;
    
    ReLU relu(reg2, y3_0);
  
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            o_data <= 32'd0;
        end
        else if (valid_pipeline[1])begin
            o_data <= y3_0;
        end
    end      
endmodule



