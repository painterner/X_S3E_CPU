`include "header/firstglobal.h"
`include "header/cpuglobal.h"
`include "header/bus.h"
module mem_ctrl(
	//***************************	mem ��ˮ�߼Ĵ���
	input wire								ex_en,
	input wire	[`MemOpBus]					ex_mem_op,
	input wire	[`WordDataBus]				ex_mem_wr_data,
	input wire	[`WordDataBus]				ex_out,
	
	//***************************  �ڴ���ʽӿ�
	input wire	[`WordDataBus]				rd_data,
	output wire	[`WordAddrBus]				addr,
	output reg								as_,
	output reg								rw,
	output wire	[`WordDataBus]				wr_data,
	
	//***************************  �ڴ���ʽ��
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
				`MEM_OP_LDW	:								//ldָ���stָ���һ��wb����
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

		
				
						
						
						
						
						
						
						
						
						