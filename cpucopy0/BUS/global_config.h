//****************************************�뿪�����йصĸ�λ���ڴ棬i/o

`ifndef __GLOBAL_CONFIG_HEADER__
	`define __GLOBAL_CONFIG_HEADER__
	
	/********��λ�źż���ѡ��***********/
		//`define POSITIVE_RESET		NaN	//ʹ��active high ��λʱ����POSITIVE_RESET
	`define NEGATIVE_RESET		NaN	
	
	/********�ڴ�����źż��Ե�ѡ��********/
	`define POSITIVE_MEMORY		NaN	//ʹ��active high ��λʱ����˺�
	`define NEGATIVE_MEMORY		NaN	

	/********I/O��ѡ��*****************/
	`define IMPLEMENT_TIMER		NaN	//��Ҫʹ�ö�ʱ��ʱ�ٶ���˺�
	`define IMPLEMENT_UART		NaN
	`define IMPLEMENT_GPIO		NaN

	/********��λ***********/
	`define RESET_EDGE		negedge	//���ݲ�ͬ�����嶨�岻ͬ��λ��ʽ
	`define	RESET_ENABLE		1'b0	//�ڴ���Ч
	`define RESET_DISABLE		1'b1

	/********�ڴ�**********/
	`define MEM_ENABLE		1'b1	//(if select the POSITIVE_MEMORY)
	`define MEM_DISABLE		1'b0
`endif



