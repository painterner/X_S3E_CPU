//*******************单端口ROM SINGEL PORT ROM
`include "header/rom.h"
`include "header/firstglobal.h"
`include "CPU/STORE/x_s3e_sprom.v"
module rom(
	input wire		clk,
	input wire		reset,
	
	input wire		cs_,
	input wire		as_,
	input wire	[`RomAddrBus]	addr,
	output wire	[`WordDataBus]	rd_data,
	output reg		rdy_
);
	//***********Xlinx 单端口rom的实例化
	x_s3e_sprom x_s3e_sprom0(
		.clka (clk),
		.addra(addr),
		.douta(rd_data)
	);
	
	//**********生成就绪信号
	always @(posedge clk or `RESET_EDGE reset)
		if(reset == `RESET_ENABLE)
			rdy_	<= #1 `DISABLE_;
		else if((cs_== `ENABLE_)&&(as_ == `ENABLE_))
			rdy_	<= #1 `ENABLE_;
		else	
			rdy_	<= #1 `DISABLE_;

endmodule
