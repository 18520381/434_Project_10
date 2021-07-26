module Mul(a, b, s);

    output [31:0] s;
    input  [31:0] a, b;

    wire exp_a_zero  = ~|a[30:23];
    wire exp_b_zero  = ~|b[30:23];
    wire exp_a_255   =  &a[30:23];
    wire exp_b_255   =  &b[30:23];
    wire frac_a_zero = ~|a[22:0];
    wire frac_b_zero = ~|b[22:0];

    wire is_inf_a  = exp_a_255  &  frac_a_zero;
    wire is_inf_b  = exp_b_255  &  frac_b_zero;
    wire is_nan_a  = exp_a_255  & ~frac_a_zero;
    wire is_nan_b  = exp_b_255  & ~frac_b_zero;
    wire is_zero_a = exp_a_zero &  frac_a_zero;
    wire is_zero_b = exp_b_zero &  frac_b_zero;

    wire is_inf_s  = is_inf_a | is_inf_b;
    wire is_nan_s  = is_nan_a | is_nan_b | (is_inf_a & is_zero_b) | (is_zero_a & is_inf_b);
    
    wire [22:0] inf_nan_frac = {is_nan_s, {22{1'b0}}};
    wire [9:0]  exp_10_tmp   = {2'b00, a[30:23]} + {2'b00, b[30:23]};
    wire [9:0]  bias         = 10'd127 - {{8{1'b0}}, exp_a_zero & exp_b_zero, exp_a_zero ^ exp_b_zero};
    wire [9:0]  exp_10       = exp_10_tmp - bias;

    wire a_hidden_bit = ~exp_a_zero;
    wire b_hidden_bit = ~exp_b_zero;

    wire [23:0] a_frac_24bit = {a_hidden_bit, a[22:0]};
    wire [23:0] b_frac_24bit = {b_hidden_bit, b[22:0]};

    wire [47:0] z = a_frac_24bit * b_frac_24bit;

    // Normalization
    wire [46:0] z5, z4, z3, z2, z1, z0;
    wire [5:0]  leading_zeros;

    assign leading_zeros[5] = ~|z[46:15];
    assign z5 = leading_zeros[5] ? {z[14:0], {32{1'b0}}} : z[46:0];
    
    assign leading_zeros[4] = ~|z5[46:31];
    assign z4 = leading_zeros[4] ? {z5[30:0], {16{1'b0}}} : z5;

    assign leading_zeros[3] = ~|z4[46:39];
    assign z3 = leading_zeros[3] ? {z4[38:0], {8{1'b0}}} : z4;

    assign leading_zeros[2] = ~|z3[46:43];
    assign z2 = leading_zeros[2] ? {z3[42:0], {4{1'b0}}} : z3;

    assign leading_zeros[1] = ~|z2[46:45];
    assign z1 = leading_zeros[1] ? {z2[44:0], 2'b00} : z2;

    assign leading_zeros[0] = ~z1[46];
    assign z0 = leading_zeros[0] ? {z1[45:0], 1'b0} : z1;

    reg  [46:0] frac_0;  // temporary fraction
    reg  [9:0]  exp_0;   // temporary fraction

    // always @ (*) begin
    //     if (z[47] && !exp_10_aligned[9]) begin
    //         exp_0  <= exp_10_aligned;
    //         frac_0 <= z[47:1];
    //     end else if (!exp_10[9] && (exp_10[8:0] > leading_zeros) && z0[46]) begin
    //         exp_0  <= exp_10 - leading_zeros;
    //         frac_0 <= z0;
    //     end else begin
    //         exp_0  <= {10{1'b0}};
    //         frac_0 <= (~exp_10_aligned[9] & |exp_10_aligned) ? z_aligned[46:0] << (exp_10_aligned - 10'h1) : z_aligned[46:0] >> (10'h1 - exp_10_aligned);
    //     end
	// end

    wire [46:0] z_aligned      = z[47] ? z[47:1] : z[46:0];
    wire [9:0]  exp_10_aligned = exp_10 + z[47];

    wire s_2 = ~exp_10[9] & (exp_10[8:0] > leading_zeros) & z0[46]; // normalised
    wire s_1 = z[47] & ~exp_10_aligned[9];                          // 11.xxxxxxx...
    wire s_0 = ~exp_10_aligned[9] & |exp_10_aligned;

    always @ (*) begin
        casex ({s_2, s_1, s_0})
            3'bx1x: begin
                exp_0  <= exp_10_aligned;
                frac_0 <= z_aligned;
            end
            3'b10x: begin
                exp_0  <= exp_10 - leading_zeros;
                frac_0 <= z0;
            end
            3'b000: begin
                exp_0  <= {10{1'b0}};
                frac_0 <= z_aligned >> (10'h1 - exp_10_aligned);
            end
            3'b001: begin
                exp_0  <= {10{1'b0}};
                frac_0 <= z_aligned << (exp_10_aligned - 10'h1);
            end
        endcase
    end

    // always @ (*) begin
    //     casex ({s_1, s_0})
    //         2'bx1: begin
    //             exp_0  <= exp_10_aligned;
    //             frac_0 <= z_aligned;
    //         end
    //         2'b10: begin
    //             exp_0  <= exp_10 - leading_zeros;
    //             frac_0 <= z0;
    //         end
    //         2'b00: begin
    //             exp_0  <= {10{1'b0}};
    //             frac_0 <= (~exp_10_aligned[9] & |exp_10_aligned) ? z_aligned << (exp_10_aligned - 10'h1) : z_aligned >> (10'h1 - exp_10_aligned);
    //         end
    //     endcase
    // end

	wire [26:0] frac   = {frac_0[46:21], |frac_0[20:0]};
	wire        s_sign = a[31] ^ b[31];
	wire        round  = (frac[3] & frac[2]) | (frac[2] & frac[0]) | (frac[2] & frac[1]);
    
	wire [24:0] frac_round = {1'b0, frac[26:3]} + round;
	wire [9:0]  exp_1      = exp_0 + (&frac[26:3] & round);
	wire        overflow   = (exp_0 >= 10'h0ff) | (&exp_0[7:1] & &frac[26:3] & round);

    wire [31:0] final_inf_nan = {s_sign, 8'hff, inf_nan_frac};
    wire [31:0] final_normal  = {s_sign, exp_1[7:0], frac_round[22:0]};

    assign s = |{overflow, is_nan_s, is_inf_s} ? final_inf_nan : final_normal;

endmodule