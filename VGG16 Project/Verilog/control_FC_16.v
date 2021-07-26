module control_FC_16(
    input valid_in_FC, clk, rst,
    output reg valid_out,
    output reg [4:0] valid_in_FC1
);
    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            valid_in_FC1[0] <= 1'd0;
            valid_in_FC1[1] <= 1'd0;
            valid_in_FC1[2] <= 1'd0;
            valid_in_FC1[3] <= 1'd0;
            valid_in_FC1[4] <= 1'd0;
            valid_out       <= 1'd0;
        end
        else begin
            valid_in_FC1[0] <= valid_in_FC;
            valid_in_FC1[1] <= valid_in_FC1[0];
            valid_in_FC1[2] <= valid_in_FC1[1];
            valid_in_FC1[3] <= valid_in_FC1[2];
            valid_in_FC1[4] <= valid_in_FC1[3];
            valid_out       <= valid_in_FC1[4];
        end
    end        


endmodule
















