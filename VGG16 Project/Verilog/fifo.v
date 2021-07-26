

module fifo #(
    parameter DATA_WIDTH = 32,
    parameter DEPTH = 8,
    parameter channel = 3
)(
    output [DATA_WIDTH*channel-1:0] data_out,
    output                  empty, full,
    input  [DATA_WIDTH*channel-1:0] data_in,
    input                   wr_req, rd_req, rst, clk
);

   localparam ADDR_WIDTH = $clog2(DEPTH);

////////////////// Front counter ///////////////////////////////////////////////////////
    reg [ADDR_WIDTH:0] rd_addr;

    always @ (posedge clk or posedge rst) begin
        if (rst) 
            rd_addr <= {ADDR_WIDTH+1{1'b0}};
        else if (rd_req) begin
             if (rd_addr[ADDR_WIDTH-1:0] == (DEPTH - 1)) begin
                rd_addr[ADDR_WIDTH-1:0] <= 0;
                rd_addr[ADDR_WIDTH] <= 1;
            end 
            else begin
                rd_addr[ADDR_WIDTH-1:0] <= rd_addr[ADDR_WIDTH-1:0] + 1;
                rd_addr[ADDR_WIDTH] <= 0;
            end
        end
    end
////////////////// Back counter ///////////////////////////////////////////////////////
    reg [ADDR_WIDTH:0] wr_addr;

    always @ (posedge clk or posedge rst) begin
        if (rst) 
            wr_addr <= {ADDR_WIDTH+1{1'b0}};
        else if (wr_req) begin
            if (wr_addr[ADDR_WIDTH-1:0] == (DEPTH - 1)) begin
                wr_addr[ADDR_WIDTH-1:0] <= 0;
                wr_addr[ADDR_WIDTH] <= 1;
            end 
            else begin
                wr_addr[ADDR_WIDTH-1:0] <= wr_addr[ADDR_WIDTH-1:0] + 1;
                wr_addr[ADDR_WIDTH] <= 0;
            end
        end
    end

////////////////// RAM ///////////////////////////////////////////////////////
    reg         [DATA_WIDTH*channel-1:0] RAM[0:DEPTH-1];
    reg         [DATA_WIDTH*3-1:0] reg_out;

    always @ (posedge clk) begin
        if (wr_req) begin
            RAM[wr_addr[ADDR_WIDTH-1:0]] <= data_in;
            reg_out <= RAM[rd_addr[ADDR_WIDTH-1:0]];
        end else begin
            reg_out <= RAM[rd_addr[ADDR_WIDTH-1:0]];
        end
    end


////////////////// Control full/empty ///////////////////////////////////////////////////////
    wire   addr_equal = (wr_addr[ADDR_WIDTH-1:0] == rd_addr[ADDR_WIDTH-1:0]);
    assign full  = addr_equal & (rd_addr[ADDR_WIDTH]  ^ wr_addr[ADDR_WIDTH]);
    assign empty = addr_equal & (rd_addr[ADDR_WIDTH] ~^ wr_addr[ADDR_WIDTH]);


    assign data_out = rd_req ? reg_out : {DATA_WIDTH*channel{1'b0}};

endmodule
