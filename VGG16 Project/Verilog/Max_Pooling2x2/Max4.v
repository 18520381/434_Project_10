module Max4 #(
    parameter DATA_WIDTH = 32
  )(
    input [31:0] InA, InB, InC, InD,
    input valid_in, clk, rst,
    output reg[31:0] o_data,
    output reg valid_out 
  );
  

/////////// Stage1 ////////////////////////////////////////
    reg [DATA_WIDTH-1:0] reg1[1:0];
    reg valid_in1;
    wire [DATA_WIDTH-1:0] y1_0, y1_1;
    
    Max2 m1(InA, InB, y1_0);
    Max2 m2(InC, InD, y1_1);

    always @(posedge clk or posedge rst)
    begin
        if(rst)
          begin
              reg1[0]   <= 32'd0;
              reg1[1]   <= 32'd0;
              valid_in1 <= 1'd0;
          end
        else if(valid_in)
          begin
              reg1[0]   <= y1_0;  
              reg1[1]   <= y1_1;   
              valid_in1 <= valid_in;
          end
        else  valid_in1 <= 1'd0;
      end     
/////////// Stage2 ////////////////////////////////////////
    wire [DATA_WIDTH-1:0] y2_0;
    
    Max2 m3(reg1[0], reg1[1], y2_0);

    always @(posedge clk or posedge rst)
    begin
        if(rst)
          begin
              o_data    <= 32'd0;
              valid_out <= 1'd0;
          end
        else if(valid_in1)
          begin
              o_data    <= y2_0;     
              valid_out <= valid_in1;
          end
        else  valid_out <= 1'd0;  
    end  

                  
endmodule
    
