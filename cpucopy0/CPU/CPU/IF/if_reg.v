
`include "header/firstglobal.h"
`include "header/cpuglobal.h"
`include "header/bus.h"
module if_reg(
	input wire						clk,
	input wire						reset,
	
	input wire	[`WordDataBus]		insn,		//读取的指令
	
	input wire						stall,		
	input wire						flush,		
	input wire	[`WordAddrBus]		new_pc,		//新程序计数器
	input wire						br_taken,	//分支发生
	input wire	[`WordAddrBus]		br_addr,	//分支目标地址
	
	output reg						if_en,		//流水线数据有效标志	
	output reg	[`WordAddrBus]		if_pc,		//程序计数器
	output reg	[`WordDataBus]		if_insn	//写出指令
	
);
	
	always @(posedge clk or `RESET_EDGE reset)	begin
		if(reset == `RESET_ENABLE) begin
			if_pc				<= #1 `RESET_VECTOR;
			if_insn				<= #1 `ISA_NOP;
			if_en				<= #1 `DISABLE;
		end else
			if(stall == `DISABLE)
				if(flush == `ENABLE) begin					//刷新流水线并更新流水线为新地址
					if_pc		<= #1 new_pc;				
					if_insn		<= #1 `ISA_NOP;
					if_en		<= #1 `DISABLE;
				end else if(br_taken == `ENABLE) begin		//PC值更新为分支目标地址
					if_pc		<= #1 br_addr;
					if_insn		<= #1 insn;
					if_en		<= #1 `ENABLE;
				end else begin								//pc值为顺序执行下一条地址
					if_pc		<= #1 if_pc + 1'd1;
					if_insn		<= #1 insn;
					if_en		<= #1 `ENABLE;
				end
	end

endmodule