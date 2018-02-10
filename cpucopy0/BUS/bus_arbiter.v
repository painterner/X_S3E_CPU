//���Ż���Ŀ��1.�ϲ�always   2.����Ĭ��else������������

//********************************�����ٲ�
`include "header/bus.h"
module bus_arbiter(
	input	 wire		clk,
	input	 wire		reset,
	
	//**************0����������
	input	 wire		m0_req_,		//��������
	output	 reg		m0_grnt_,		//��������

	input	 wire		m1_req_,
	output	 reg		m1_grnt_,
	input	 wire		m2_req_,
	output	 reg		m2_grnt_,
	input	 wire		m3_req_,
	output	 reg		m3_grnt_
);
	reg	[1:0]	owner;				//����������
	
	//******************************��������ʹ��Ȩ
	always @ * begin
		//****��������ʹ��Ȩ��ʼ��
		m0_grnt_ = `DISABLE_;
		m1_grnt_ = `DISABLE_;
		m2_grnt_ = `DISABLE_;
		m3_grnt_ = `DISABLE_;
		//****��������ʹ��Ȩ
		case (owner)
			`BUS_OWNER_MASTER_0 :	m0_grnt_ = `ENABLE_;

			`BUS_OWNER_MASTER_1 :	m1_grnt_ = `ENABLE_;

			`BUS_OWNER_MASTER_2 :	m2_grnt_ = `ENABLE_;

			`BUS_OWNER_MASTER_3 :	m3_grnt_ = `ENABLE_;
		endcase
	end

	always @(posedge clk or `RESET_EDGE reset) 
		if(reset == `RESET_ENABLE) 
			owner <= #1 `BUS_OWNER_MASTER_0;		//�������ڸ�λ��
		else 
			case (owner)
			`BUS_OWNER_MASTER_0 : 				//����Ȩ����0>1>2>3
				if	(m0_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_0;
				else if (m1_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_1;
				else if (m2_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_2;
				else if (m3_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_3;
				//**********ע��˴���ֱ�� m0_grnt_ <= #1 `ENABLE_����Ϊ����always���
				//**********���ж�������һ������m0_grnt�ֲ���������always�︳ֵ������
				//**********�����������м�����
			
			`BUS_OWNER_MASTER_1 :
				if	(m1_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_1;
				else if (m2_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_2;
				else if (m3_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_3;
				else if (m0_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_0;

			`BUS_OWNER_MASTER_2 :
				if	(m2_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_2;
				else if (m3_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_3;
				else if (m0_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_0;
				else if (m1_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_1;
							
			`BUS_OWNER_MASTER_3 :
				if	(m3_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_3;
				else if (m0_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_0;
				else if (m1_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_1;
				else if (m2_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_2;
		endcase
endmodule
			
							
							

				
			





















	