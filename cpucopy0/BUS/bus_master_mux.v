//*******************����mx_grnt_ѡ���ٲú������ߵĿ��ƣ���ַ������
`include "header/bus.h"
module bus_master_mux(
	input wire	[29:0]	m0_addr,		//��ַ
	input wire		m0_as_,			//��ַѡͨ
	input wire		m0_rw,			//��д
	input wire	[31:0]	m0_wr_data,		//д�������
	input wire		m0_grnt_,  		//��������

	input wire	[29:0]	m1_addr,		//��ַ
	input wire		m1_as_,			//��ַѡͨ
	input wire		m1_rw,			//��д
	input wire	[31:0]	m1_wr_data,		//д�������
	input wire		m1_grnt_,  		//��������

	input wire	[29:0]	m2_addr,		//��ַ
	input wire		m2_as_,			//��ַѡͨ
	input wire		m2_rw,			//��д
	input wire	[31:0]	m2_wr_data,		//д�������
	input wire		m2_grnt_,  		//��������

	input wire	[29:0]	m3_addr,		//��ַ
	input wire		m3_as_,			//��ַѡͨ
	input wire		m3_rw,			//��д
	input wire	[31:0]	m3_wr_data,		//д�������
	input wire		m3_grnt_,  		//��������

	//**********************�����ź����ߴ��������ѡͨ�ź�
	output reg	[29:0]	s_addr,
	output reg 		s_as_,
	output reg		s_rw,
	output reg	[31:0]	s_wr_data
);
	
	always @ * 
		if(m0_grnt_ ==`ENABLE_) begin
			s_addr		= m0_addr;
			s_as_		= m0_as_;
			s_rw		= m0_rw;
			s_wr_data	= m0_wr_data;
		end else if (m1_grnt_ == `ENABLE_) begin
			s_addr		= m1_addr;
			s_as_		= m1_as_;
			s_rw		= m1_rw;
			s_wr_data	= m1_wr_data;
		end else if (m2_grnt_ == `ENABLE_) begin
			s_addr		= m2_addr;
			s_as_		= m2_as_;
			s_rw		= m2_rw;
			s_wr_data	= m2_wr_data;
		end else if (m3_grnt_ == `ENABLE_) begin
			s_addr		= m3_addr;
			s_as_		= m3_as_;
			s_rw		= m3_rw;
			s_wr_data	= m3_wr_data;
		end

endmodule
























