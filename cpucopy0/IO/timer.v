`include "header/ioglobal.h"  
`include "header/firstglobal.h"       
`include "header/cpuglobal.h"         
module timer(
	input wire							clk,
	input wire							reset,
	
	//******************************************************总线接口
	input wire							cs_,
	input wire							as_,
	input wire							rw,
	input wire	[`TimerAddrBus]			addr,
	input wire	[`WordDataBus]			wr_data,
	output reg	[`WordDataBus]			rd_data,
	output reg							rdy_,
	
	//******************************************************控制寄存器	
	output reg							irq
	
);

	 reg							start;
	 reg							mode;
	 reg	[`WordDataBus]			expr_val;
	 reg	[`WordDataBus]			counter;
	 wire							expr_flag;
	 
	 assign	expr_flag				= ((counter == expr_val)&&(start == `ENABLE))? `ENABLE : `DISABLE;
	 
	 //******************************************************定时器控制
	 always @(posedge clk or `RESET_EDGE reset)
	 	if(reset == `RESET_ENABLE)	begin
	 		rd_data					<= #1 `WORD_DATA_W'H0;
	 		rdy_					<= #1 `DISABLE;
	 		start					<= #1 `DISABLE;
	 		mode					<= #1 `TIMER_MODE_ONE_SHOT;
	 		irq						<= #1 `DISABLE;						//irq持续为1，cpu会循环处理异常？
	 		expr_val				<= #1 `DISABLE;
	 		counter					<= #1 `WORD_DATA_W'H0;
	 	end else begin
	 		if((cs_ == `ENABLE_)&&(as_ == `ENABLE_))
	 			rdy_				<= #1 `ENABLE;
	 		else
	 			rdy_				<= #1 `DISABLE;
	 			
	 		if((cs_ == `ENABLE_)&&(as_ == `ENABLE)&&(rw == `READ)) 
	 			case (addr)
	 				`TIMER_ADDR_CTRL		:
	 					rd_data		<= #1 {{`WORD_DATA_W-2{1'B0}},mode,start};
	 				`TIMER_ADDR_INTR		:
	 					rd_data		<= #1 {{`WORD_DATA_W-1{1'B0}},irq};
	 				`TIMER_ADDR_EXPR		:
	 					rd_data		<= #1 expr_val;
	 				`TIMER_ADDR_COUNTER		:
	 					rd_data		<= #1 counter;
	 			endcase
	 		else 
	 					rd_data		<= #1 `WORD_DATA_W'H0;
	 			
	 		if((cs_ == `ENABLE_)&&(as_ == `ENABLE)&&(rw == `WRITE)&&(addr == `TIMER_ADDR_CTRL))	begin
	 			start				<= #1 wr_data[`TimerStartLoc];
	 			mode				<= #1 wr_data[`TimerModeLoc];
	 		end else if((expr_flag == `ENABLE)&&(mode == `TIMER_MODE_ONE_SHOT))	
	 			start				<= #1 `DISABLE;
	 		
	 		if(expr_flag == `ENABLE)
	 			irq					<= #1 `ENABLE;
	 		else if((cs_ == `ENABLE_)&&(as_ == `ENABLE_)	&&(rw == `WRITE)&&(addr == `TIMER_ADDR_INTR))
	 			irq					<= #1 wr_data[`TimerIrqLoc];		
	 			
	 		if((cs_ == `ENABLE_)&&(as_ == `ENABLE_)	&&(rw == `WRITE)&&(addr == `TIMER_ADDR_EXPR))
	 			expr_val			<= #1 wr_data;
	 		
	 		if((cs_ == `ENABLE_)&&(as_ == `ENABLE_)	&&(rw == `WRITE)&&(addr == `TIMER_ADDR_INTR))
	 			counter				<= #1 wr_data;
	 		else if(expr_flag == `ENABLE)
	 			counter				<= #1 `WORD_DATA_W'H0;
	 		else if(start == `ENABLE)
	 			counter				<= #1 counter + 1'b1;
		end
		
endmodule
	 			