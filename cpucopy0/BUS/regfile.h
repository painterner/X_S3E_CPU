`ifndef __REGFILE_HEADER__
	`define __REGFILE_HEADER__
	
	/******�źŵ�ƽ******/
	`define HIGH			1'b1
	`define LOW			1'b0
	
	/******�߼�ֵ******/
	`define	ENABLE_			1'b0
	`define DISABLE_		1'b1
	
	/******����******/
	`define DATA_W			32		//���ݿ��
	`define DataBus			31:0		//��������
	`define DATA_D			32		//�������

	/******��ַ******/
	`define ADDR_W			30		//��ַ���
	`define AddrBus			29:0		//��ַ����

`endif
