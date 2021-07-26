
module Max2 #(
    parameter DATA_WIDTH = 32
  )(
    input [31:0] InA, InB,
    output [31:0] o_data
  );

    assign o_data = (InA > InB)? InA : InB;
endmodule
    