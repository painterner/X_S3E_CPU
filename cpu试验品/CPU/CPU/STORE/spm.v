//`include "header/firstglobal.h"
//`include "header/spm.h"
`include "CPU/STORE/x_s3e_dpram.v"
module spm(
	input wire			clk,

	input wire	[`SpmAddrBus]	if_spm_addr,
	input wire			if_spm_as_,
	input wire			if_spm_rw,
	output wire	[`WordAddrBus]	if_spm_rd_addr,
	input wire	[`WordAddrBus]	if_spm_wr_addr,
		
	input wire	[`SpmAddrBus]	mem_spm_addr,
	input wire			mem_spm_as_,
	input wire			mem_spm_rw,
	output wire	[`WordAddrBus]	mem_spm_rd_addr,
	input wire	[`WordAddrBus]	mem_spm_wr_addr
	
);
	
	reg			wea;
	reg			web;

	always @ * begin
		if((if_spm_as_ == `ENABLE_)&&(if_spm_rw == `WRITE))
			wea	= `MEM_ENABLE;
		else 
			wea	= `MEM_DISABLE;
		
		if((mem_spm_as_== `ENABLE_)&&(mem_spm_rw== `WRITE))
			web	= `MEM_ENABLE;
		else 
			web	= `MEM_DISABLE;
	
	end


	x_s3e_dpram x_s3e_dpram0(
		.clka	(clk),
		.addra	(if_spm_addr),
		.dina	(if_spm_wr_data),
		.wea	(wea),
		.douta	(if_spm_rd_data),
		
		.clkb	(clk),
		.addrb	(mem_spm_addr),
		.dinb	(mem_spm_wr_data),
		.web	(web),
		.doutb	(mem_spm_rd_data)
	);

endmodule






















	

	