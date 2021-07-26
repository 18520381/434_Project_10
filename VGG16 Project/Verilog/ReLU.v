module ReLU(
    input [31:0] i_data,
    output reg[31:0] o_data
);
    always @(*)
    begin
        if(i_data[31])
            o_data <= 32'd0;
        else
            o_data <= i_data;     
    end
endmodule


