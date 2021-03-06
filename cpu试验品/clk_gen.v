`include "CLK/x_s3e_dcm.v"
`include "header/firstglobal.h"
module clk_gen(
	input wire				clk_ref,
	input wire				reset_sw,
	output wire				clk,
	output wire				clk_,
	output wire				chip_reset
);
	wire					dcm_reset;
	wire					locked_;
	assign dcm_reset		= (reset_sw == `RESET_ENABLE)? `RESET_ENABLE : `RESET_DISABLE;									//
	assign chip_reset		= ((reset_sw == `RESET_ENABLE)||(locked_ == `DISABLE_))? `RESET_ENABLE : `RESET_DISABLE;			//
	
	x_s3e_dcm x_s3e_dcm0(
		.CLKIN_IN	(clk_ref),
		.RST_IN		(dcm_reset),
		.CLK0_OUT	(clk),
		.CLK180_OUT (clk_),
		.LOCKED_OUT	(locked_)
	);
	
	
endmodule