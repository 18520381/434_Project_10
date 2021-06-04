module Op1_con3d#(
    parameter DATA_WIDTH = 32,
    parameter bias = 32'b01000000000000000000000000000000
)(
    input [DATA_WIDTH-1:0] o_CORE_IP1, o_CORE_IP2, o_CORE_IP3,
    input valid_in_adder, clk, rst,
    output reg [DATA_WIDTH-1:0] o_data,
    output reg valid_out
);
  
  /////////////////// ADDER1//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg1[0:1];
    reg valid_in1;
    wire [DATA_WIDTH-1:0] y1_0;
    wire [DATA_WIDTH-1:0] y1_1;
    
    Add_Sub a1(o_CORE_IP1, o_CORE_IP2, 1'b0, y1_0);
    Add_Sub a2(o_CORE_IP3, bias      , 1'b0, y1_1);  
    
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            reg1[0] <= 32'd0;
            reg1[1] <= 32'd0;
            valid_in1 <= 1'd0;
        end
        else if (valid_in_adder)begin
            reg1[0] <= y1_0;
            reg1[1] <= y1_1;
            valid_in1 <= valid_in_adder;
        end
        else valid_in1 <= 1'd0;
    end        

/////////////////// ADDER2//////////////////////////////////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg2;
    reg valid_in2;
    wire [DATA_WIDTH-1:0] y2_0;
    
    Add_Sub a3(reg1[0], reg1[1], 1'b0, y2_0);
  
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            reg2 <= 32'd0;
            valid_in2 <= 1'd0;
        end
        else if (valid_in1)begin
            reg2 <= y2_0;
            valid_in2 <= valid_in1;
        end
        else valid_in2 <= 1'd0;
    end  

/////////////////// ReLU//////////////////////////////////////////////////////////////////////
    wire [DATA_WIDTH-1:0] y3_0;
    
    ReLU relu(reg2, y3_0);
  
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            o_data <= 32'd0;
            valid_out <= 1'd0;
        end
        else if (valid_in2)begin
            o_data <= y3_0;
            valid_out <= valid_in2;
        end
        else valid_out <= 1'd0;
    end      
endmodule