module control_pipeline_layer1(
    input valid_in_bias, clk, rst,
    output reg valid_out,
    output reg [1:0] valid_pipeline
);
  
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            valid_pipeline[0] <= 1'd0;
            valid_pipeline[1] <= 1'd0;
            valid_out <= 1'd0;
        end
        else begin
            valid_pipeline[0] <= valid_in_bias;
            valid_pipeline[1] <= valid_pipeline[0];
            valid_out <= valid_pipeline[1];
        end
    end        


endmodule





