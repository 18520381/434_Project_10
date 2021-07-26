`define f2r(z) ({z[31], z[30], {3{~z[30]}}, z[29:23], z[22:0], {29{1'b0}}})
`define r2f(z) ({z[63], z[62], z[58:52], z[51:29]})
module Softmax(
    input clk, rst, valid_in,
    input [31:0] i0, i1,
    output [31:0] o0, o1,
    output reg valid_out
    );


  
/////////////////// 1 //////////////////////////////////////////////////////////////////////
    reg [63:0] reg1[0:1];
    reg s1;
    always @ (posedge clk or posedge rst)begin
        if (rst == 1)begin
            reg1[0] <= 0;
            reg1[1] <= 0;
            s1 <= 0;
        end
        else if(valid_in == 1)begin
            reg1[0] <= `f2r(i0);
            reg1[1] <= `f2r(i1);
            s1 <= valid_in;
        end
        else begin
            s1 <= 0;
        end
    end
/////////////////// 2 //////////////////////////////////////////////////////////////////////
    real r0, r1;
    reg s2;
    always @ (posedge clk or posedge rst)begin
        if (rst == 1)begin
            r0 <= 0;
            r1 <= 0;
        end
        else if(s1 == 1)begin
            r0 <= 2.71828182846**$bitstoreal(reg1[0]);
            r1 <= 2.71828182846**$bitstoreal(reg1[1]);
            s2 <= s1;
        end
        else begin
            s2 <= 0;
        end
    end
/////////////////// 3 /////////////////////////////////////////////
    real r0_next, r1_next, r_sum;
    reg s3;
    always @ (posedge clk or posedge rst)begin
        if (rst == 1)begin
            r_sum <= 0;
            s3 <= 0;
            r0_next <= 0;
            r1_next <= 0;
        end
        else if(s2 == 1)begin
            r_sum <= r0 + r1;
            r0_next <= r0;
            r1_next <= r1;
            s3 <= s2;
        end
        else begin
            s3 <= 0;
        end
    end
  /////////////////// 4 /////////////////////////////////////////////
  reg[63:0] reg4[0:1];
    always @ (posedge clk or posedge rst)begin
        if (rst == 1)begin
            reg4[0] <= 0;
            reg4[1] <= 0;
            valid_out <= 0;
        end
        else if(s3 == 1)begin
            reg4[0] <= $realtobits(r0_next/r_sum);
            reg4[1] <= $realtobits(r1_next/r_sum);
            valid_out <= s3;
        end
        else begin
            valid_out <= 0;
        end
    end
    
    
    assign o0= `r2f(reg4[0]); 
    assign o1= `r2f(reg4[1]);
endmodule