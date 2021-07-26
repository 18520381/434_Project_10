module control_pipeline2D(  
    input clk, rst, valid_in,
    output reg valid_out ,
    output reg [3:0] valid_pipeline2D
);
    always @(posedge clk or posedge rst)
    begin
        if(rst)
          begin
              valid_pipeline2D[0] <= 1'd0;
              valid_pipeline2D[1] <= 1'd0;
              valid_pipeline2D[2] <= 1'd0;
              valid_pipeline2D[3] <= 1'd0;
              valid_out <= 1'd0;
          end
        else 
          begin
              valid_pipeline2D[0] <= valid_in;
              valid_pipeline2D[1] <= valid_pipeline2D[0];
              valid_pipeline2D[2] <= valid_pipeline2D[1];
              valid_pipeline2D[3] <= valid_pipeline2D[2];
              valid_out <= valid_pipeline2D[3];
          end
    end  

endmodule




