`include "header/firstglobal.h"
`include "header/cpuglobal.h"
`include "header/bus.h"
module mem_ctrl(
	//***************************	mem 流水线寄存器
	input wire								ex_en,
	input wire	[`MemOpBus]					ex_mem_op,
	input wire	[`WordDataBus]				ex_mem_wr_data,
	input wire	[`WordDataBus]				ex_out,
	
	//***************************  内存访问接口
	input wire	[`WordDataBus]				rd_data,
	output wire	[`WordAddrBus]				addr,
	output reg								as_,
	output reg								rw,
	output wire	[`WordDataBus]				wr_data,
	
	//***************************  内存访问结果
	output reg	[`WordDataBus]				out,
	output reg								miss_align
	
);
    wire	[`ByteOffsetBus]			offset ;
    
	assign wr_data					= ex_mem_wr_data;				
	assign addr						= ex_out[`WordAddrLoc];
	assign offset					= ex_out[`ByteOffsetLoc];

	always @ * begin
		miss_align					= `DISABLE;
		out							= `WORD_DATA_W'H0;
		as_                         = `DISABLE_;
		rw                          = `READ;
		if(ex_en == `ENABLE)	
			case(ex_mem_op)
				`MEM_OP_LDW	:								//ld指令比st指令多一个wb周期
					if(offset == `BYTE_OFFSET_WORD)	begin
						out			= rd_data;
						as_			= `ENABLE_;
					end else
						miss_align	= `ENABLE;
				`MEM_OP_STW	:
					if(offset == `BYTE_OFFSET_WORD)	begin
						rw			= `WRITE;
						as_			= `ENABLE_;
					end else
						miss_align  = `ENABLE;
				default		:
					out				= ex_out;
			endcase
	end
		
endmodule

		
				
						
						
						
						
						
						
						
						
						