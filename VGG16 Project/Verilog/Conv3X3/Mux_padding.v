module Mux_padding#(
    parameter DATA_WIDTH = 32
)(
    input [DATA_WIDTH-1:0] i_data,
    output [DATA_WIDTH-1:0] o_data,
    input select
);

    assign o_data = select ? {DATA_WIDTH{1'b0}} : i_data;

endmodule
