//**********ȫ��ͨ�ú�************//
`ifndef __STDDER_HEADER__
	`define __STDDER_HEADER__
	
	/*********�ߵ͵�ƽ*********/
	`define HIGH		1'b1
	`define LOW		1'b0
	
	/*********�߼���Ч���*************/
	`define	DISABLE		1'b0
	`define ENABLE		1'b1
	`define DISABLE_	1'b1
	`define ENABLE_		1'b0
	
	/**********�źŶ�д*************/
	`define READ		1'b1
	`define WRITE		1'b0
	
	/**********�ߵ�λ�ж�************/
	`define LSB		0		//���λ
	`define BYTE_MSB	7		//�ֽ����λ
	`define WORD_MSB	31		//�����λ
	`define WORD_ADDR_MSB   29		//��ַ���λ
	
	/**********���ݴ�С************/
	`define BYTE_DATA_W	8		//���ݿ�ȣ��ֽڣ�
	`define ByteDataBus	7:0		//�������ߣ��ֽڣ�
	`define WORD_DATA_W	32		//���ݿ�ȣ��֣�
	`define	WordDataBus	31:0		//�������ߣ��֣�
	`define WORD_ADDR_W	30		//��ַ���
	`define WordAddrBus	29:0		//��ַ����
	
	/*********λ����߽�**********/
	`define BYTE_OFFSET_W	2		//λ�ƿ��
	`define ByteOffsetBus	1:0		//λ������
	`define WordAddrLoc	31:2		//�ֵ�ַλ��
	`define	ByteOffsetLoc	1:0		//�ֽ�λ��λ��
	`define BYTE_OFFSET_WORD 2'b00		//�ֱ߽�
`endif