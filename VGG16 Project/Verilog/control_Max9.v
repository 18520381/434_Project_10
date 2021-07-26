module control_Max9 (
    input valid_in, clk, rst,
    output reg valid_out, 
    output reg[2:0] valid_in1 
  );

    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            valid_in1[0] <= 1'd0;
            valid_in1[1] <= 1'd0;
            valid_in1[2] <= 1'd0;
            valid_out <= 1'd0;
        end
        else begin
            valid_in1[0] <= valid_in;
            valid_in1[1] <= valid_in1[0];
            valid_in1[2] <= valid_in1[1];
            valid_out <= valid_in1[2];
        end
    end        

endmodule






