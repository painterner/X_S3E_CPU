//****************΢�ܹ��йصĺ�����
`ifndef __CPU_H__
	`define __CPU_H__
	//************************�Ĵ���
	`define REG_NUM		32		//�Ĵ�������
	`define REG_ADDR_W	5
	`define RegAddrBus	4:0

	`define	CPU_IRQ_CH	8		//�ж�������
	`define CpuIrqBus	7:0									//�������ӵ�

	//***********************ALU
	`define	ALU_OP_W	4		//ALU�������	
	`define AluOpBus	3:0		
	`define ALU_OP_NOP	4'h0		//No Operation
	`define	ALU_OP_AND	4'h1	
	`define	ALU_OP_OR	4'h2
	`define	ALU_OP_XOR	4'h3
	`define	ALU_OP_ADDS	4'h4		//�з��żӷ�
	`define	ALU_OP_ADDU	4'h5		//�޷��żӷ�
	`define	ALU_OP_SUBS	4'h6
	`define	ALU_OP_SUBU	4'h7
	`define	ALU_OP_SHRL	4'h8		//�߼�����
	`define	ALU_OP_SHLL	4'h9		//�߼�����

	//***********************�ڴ�
	`define MEM_OP_W	2
	`define	MemOpBus	1:0
	`define	MEM_OP_NOP	2'h0	
	`define	MEM_OP_LDW	2'h1		//�ֶ�ȡ
	`define	MEM_OP_STW	2'h2		//��д��

	//***********************����
	`define CTRL_OP_W	2
	`define CtrlOpBus	1:0
	`define	CTRL_OP_NOP	2'h0
	`define	CTRL_OP_WRCR	2'h1		//д����ƼĴ���
	`define	CTRL_OP_EXRT	2'h2		//���쳣�ָ�

	//***********************ģʽ
	`define	CPU_EXE_MODE_W	1		//cpuִ��ģʽ��
	`define CpuExeModeBus	0:0
	`define	CPU_KERNEL_MODE	1'b0		//�ں�ģʽ
	`define	CPU_USER_MODE	1'b1		//�û�ģʽ

	//***********************״̬�����ƼĴ���
	`define CREG_ADDR_STATUS	5'h0
	`define	CREG_ADDR_PRE_STATUS	5'h1
	`define	CREG_ADDR_PC		5'h2
	`define	CREG_ADDR_EPC		5'h3	//EXCEPTION �쳣���������
	`define	CREG_ADDR_EXP_VECTOR	5'h4	//�쳣����
	`define	CREG_ADDR_CAUSE		5'h5	//�쳣ԭ��Ĵ���
	`define	CREG_ADDR_INT_MASK	5'h6	//�ж�����
	`define	CREG_ADDR_IRQ		5'h7	//�ж�����Ĵ���
	`define CREG_ADDR_ROM_SIZE	5'h1d	//rom����
	`define	CREG_ADDR_SPM_SIZE	5'h1e	//spm����
	`define	CREG_ADDR_CPU_INFO	5'h1f	//cpu����
	`define	CregExeModeLoc		0	//ִ��ģʽλ��
	`define	CregIntEnableLoc	1	//�ն���Чλ��
	`define CregExpCodeLoc		2:0	//�쳣����λ��
	`define	CregDlyFlagLoc		3	//�ӳټ�϶��־λ��λ��   1
	
	//***********************��������
	`define	BusIfStateBus		1:0	//״̬����
	`define	BUS_IF_STATE_IDLE	2'h0	//���߿���
	`define	BUS_IF_STATE_REQ	2'h1	//��������
	`define	BUS_IF_STATE_ACCESS	2'h2	//��������
	`define	BUS_IF_STATE_STALL	2'h3	//ͣ��
	
	//***********************��λ����λ
	`define	RESET_VECTOR		30'h0	//��λ����
	`define	ShAmountBus		4:0	//��λ������
	`define ShAmountLoc		4:0	//��λ��λ��
	
	//***********************�汾��ʱ��
	`define	RELEASE_YEAR		8'd41	//�������	
	`define RELEASE_MONTH		8'd7	
 	`define RELEASE_VERSION		8'd1	//�汾��
	`define	RELEASE_REVISION	8'd0	//�޶���
`endif