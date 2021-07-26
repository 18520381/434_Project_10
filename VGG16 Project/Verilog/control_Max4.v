module control_Max4 (
    input valid_in, clk, rst,
    output reg valid_out, valid_in1 
  );

    always @(posedge clk or posedge rst) 
    begin
        if(rst)begin
            valid_in1 <= 1'd0;
            valid_out <= 1'd0;
        end
        else begin
            valid_in1 <= valid_in;
            valid_out <= valid_in1;
        end
    end        

endmodule




