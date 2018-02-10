
`include "header/firstglobal.h"
`include "header/cpuglobal.h"
`include "header/bus.h"
module if_reg(
	input wire						clk,
	input wire						reset,
	
	input wire	[`WordDataBus]		insn,		//��ȡ��ָ��
	
	input wire						stall,		
	input wire						flush,		
	input wire	[`WordAddrBus]		new_pc,		//�³��������
	input wire						br_taken,	//��֧����
	input wire	[`WordAddrBus]		br_addr,	//��֧Ŀ���ַ
	
	output reg						if_en,		//��ˮ��������Ч��־	
	output reg	[`WordAddrBus]		if_pc,		//���������
	output reg	[`WordDataBus]		if_insn	//д��ָ��
	
);
	
	always @(posedge clk or `RESET_EDGE reset)	begin
		if(reset == `RESET_ENABLE) begin
			if_pc				<= #1 `RESET_VECTOR;
			if_insn				<= #1 `ISA_NOP;
			if_en				<= #1 `DISABLE;
		end else
			if(stall == `DISABLE)
				if(flush == `ENABLE) begin					//ˢ����ˮ�߲�������ˮ��Ϊ�µ�ַ
					if_pc		<= #1 new_pc;				
					if_insn		<= #1 `ISA_NOP;
					if_en		<= #1 `DISABLE;
				end else if(br_taken == `ENABLE) begin		//PCֵ����Ϊ��֧Ŀ���ַ
					if_pc		<= #1 br_addr;
					if_insn		<= #1 insn;
					if_en		<= #1 `ENABLE;
				end else begin								//pcֵΪ˳��ִ����һ����ַ
					if_pc		<= #1 if_pc + 1'd1;
					if_insn		<= #1 insn;
					if_en		<= #1 `ENABLE;
				end
	end

endmodule