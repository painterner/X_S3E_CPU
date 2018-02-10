
//`include "header/firstglobal.h"
//`include "header/cpuglobal.h"
module gpr(						//general purpose 通用的
	input wire			clk,
	input wire			reset,
	input wire	[`RegAddrBus]	rd_addr_0,
	output wire	[`WordDataBus]	rd_data_0,		//去定义宏
	input wire	[`RegAddrBus]	rd_addr_1,
	output wire	[`WordDataBus]	rd_data_1,
	
	input wire			we_,
	input wire	[`RegAddrBus]	wr_addr,
	input wire	[`WordDataBus]	wr_data
);
	
	reg	[`RegAddrBus]	gpr;
	integer			i;
	assign rd_data_0 = ((we_ == `ENABLE_)&&(wr_addr == rd_addr_0))? wr_data : gpr[rd_addr_0];
	assign rd_data_1 = ((we_ == `ENABLE_)&&(wr_addr == rd_addr_1))? wr_data : gpr[rd_addr_1];
	
	always @ (posedge clk or `RESET_EDGE reset)
		if(reset == `RESET_ENABLE)
			for(i=0;i<`REG_NUM;i=i+1)
			gpr[i] 		<= #1 {`WORD_DATA_W{1'b0}};	
		else if(we_ == `ENABLE_)
			gpr[wr_addr] 	<= #1 wr_data;
	
endmodule