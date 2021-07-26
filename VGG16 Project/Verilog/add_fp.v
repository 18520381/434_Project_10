module Add_FP(s, a, b);

	output [31:0] s;
	input  [31:0] a, b;

	wire exchange = {1'b0, b[30:0]} > {1'b0, a[30:0]};	// b > a
	wire [31:0] fp_larger  = exchange ? b : a;
	wire [31:0] fp_smaller = exchange ? a : b;
	wire [7:0]  temp_exp   = fp_larger[30:23];

	wire larger_hidden_bit         = |fp_larger[30:23];
	wire smaller_hidden_bit        = |fp_smaller[30:23];
	wire [23:0] larger_frac_24bit  = {larger_hidden_bit,  fp_larger[22:0]};
	wire [23:0] smaller_frac_24bit = {smaller_hidden_bit, fp_smaller[22:0]};

	wire expo_larger_255   =  &fp_larger[30:23];
	wire expo_smaller_255  =  &fp_smaller[30:23];
	wire frac_larger_zero  = ~|fp_larger[22:0];
	wire frac_smaller_zero = ~|fp_smaller[22:0];
	wire is_nan_larger     = expo_larger_255  & ~frac_larger_zero;
	wire is_nan_smaller    = expo_smaller_255 & ~frac_smaller_zero;
	wire is_inf_larger     = expo_larger_255  &  frac_larger_zero;
	wire is_inf_smaller    = expo_smaller_255 &  frac_smaller_zero;

	wire s_sign   = exchange ? b[31] : a[31];
	wire is_inf_s = is_inf_larger | is_inf_smaller;
	wire is_nan_s = is_nan_larger | is_nan_smaller | (is_inf_larger & is_inf_smaller & (fp_larger[31] ^ fp_smaller[31]));

	wire [22:0] inf_nan_frac   = {is_nan_s, {22{1'b0}}};
	wire [7:0]  exp_diff       = fp_larger[30:23] - fp_smaller[30:23];
	wire        smaller_denorm = (|fp_larger[30:23]) & (~|fp_smaller[30:23]);
	wire [7:0]  shift_amount   = exp_diff - {{7{1'b0}}, smaller_denorm};

	wire [49:0] smaller_frac_50bit = (shift_amount < 26) ? {smaller_frac_24bit, {26{1'b0}}} >> shift_amount : {{26{1'b0}}, smaller_frac_24bit};
	wire [26:0] smaller_frac_27bit = {smaller_frac_50bit[49:24], |smaller_frac_50bit[23:0]};

	wire [27:0] aligned_larger_frac  = {1'b0, larger_frac_24bit, 3'b000};
	wire [27:0] aligned_smaller_frac = {1'b0, smaller_frac_27bit};

	wire        op_sub    = fp_larger[31] ^ fp_smaller[31];
	wire [27:0] calc_frac = op_sub ? aligned_larger_frac - aligned_smaller_frac : aligned_larger_frac + aligned_smaller_frac;

	wire [26:0] f4, f3, f2, f1, f0;
	wire [4:0]  leading_zeros;

	assign leading_zeros[4] = ~|calc_frac[26:11];
	assign f4 = leading_zeros[4] ? {calc_frac[10:0], 16'b0} : calc_frac[26:0];

	assign leading_zeros[3] = ~|f4[26:19];
	assign f3 = leading_zeros[3] ? {f4[18:0], 8'b0} : f4;

	assign leading_zeros[2] = ~|f3[26:23];
	assign f2 = leading_zeros[2] ? {f3[22:0], 4'b0} : f3;

	assign leading_zeros[1] = ~|f2[26:25];
	assign f1 = leading_zeros[1] ? {f2[24:0], 2'b0} : f2;

	assign leading_zeros[0] = ~f1[26];
	assign f0 = leading_zeros[0] ? {f1[25:0], 1'b0} : f1;

	reg [7:0]  exp_0;
	reg [26:0] frac_0;

	// always @ (*) begin
	// 	if (calc_frac[27]) begin
	// 		frac_0 <= calc_frac[27:1];
	// 		exp_0  <= temp_exp + 8'h1;
	// 	end else begin
	// 		if ((temp_exp > leading_zeros) && (f0[26])) begin
	// 			exp_0  <= temp_exp - leading_zeros;
	// 			frac_0 <= f0;
	// 		end else begin
	// 			exp_0  <= 8'h0;
	// 			frac_0 <= |temp_exp ? calc_frac[26:0] << (temp_exp - 8'h1) : calc_frac[26:0];
	// 		end
	// 	end
	// end

	wire normalised = (temp_exp > leading_zeros) & f0[26];
	always @ (*) begin
		casex ({normalised, calc_frac[27]})
			2'b00: begin
				exp_0  <= 8'h0;
				frac_0 <= |temp_exp ? calc_frac[26:0] << (temp_exp - 8'h1) : calc_frac[26:0];
			end
			2'b10: begin
				exp_0  <= temp_exp - leading_zeros;
				frac_0 <= f0;
			end
			2'bx1: begin
				exp_0  <= temp_exp + 8'h1;
				frac_0 <= calc_frac[27:1];
			end
		endcase
	end

	wire        round      = (frac_0[3] & frac_0[2]) | (frac_0[2] & frac_0[0]) | (frac_0[2] & frac_0[1]);
	wire [24:0] frac_round = {1'b0, frac_0[26:3]} + round;
	wire [7:0]  exponent   = exp_0 + frac_round[24];
	wire        overflow   = &exp_0 | &exponent;

	wire [31:0] final_inf_nan = {s_sign, 8'hff, inf_nan_frac};
	wire [31:0] final_normal  = {s_sign, exponent, frac_round[22:0]};

	assign s = |{overflow, is_nan_s, is_inf_s} ? final_inf_nan : final_normal;

endmodule
