//****************���ߴ�����·������
`include "header/bus.h"
module bus_slave_mux(
	input wire		s0_cs_,			//Ƭѡ
	input wire	[31:0]	s0_rd_data,		//����������
	input wire		s0_rdy_,		//����

	input wire		s1_cs_,
	input wire	[31:0]	s1_rd_data,
	input wire		s1_rdy_,
	input wire		s2_cs_,
	input wire	[31:0]	s2_rd_data,
	input wire		s2_rdy_,
	input wire		s3_cs_,
	input wire	[31:0]	s3_rd_data,
	input wire		s3_rdy_,
	input wire		s4_cs_,
	input wire	[31:0]	s4_rd_data,
	input wire		s4_rdy_,
	input wire		s5_cs_,
	input wire	[31:0]	s5_rd_data,
	input wire		s5_rdy_,
	input wire		s6_cs_,
	input wire	[31:0]	s6_rd_data,
	input wire		s6_rdy_,
	input wire		s7_cs_,
	input wire	[31:0]	s7_rd_data,
	input wire		s7_rdy_,

	output reg	[31:0]	m_rd_data,		//ѡ���ź�
	output reg		m_rdy_
);
	always @ * 
		if(s0_cs_ == `ENABLE_) begin
			m_rd_data = s0_rd_data;
			m_rdy_	  = s0_rdy_;
		end else if(s1_cs_ == `ENABLE_) begin
			m_rd_data = s1_rd_data;
			m_rdy_	  = s1_rdy_;
		end else if(s2_cs_ == `ENABLE_) begin
			m_rd_data = s2_rd_data;
			m_rdy_	  = s2_rdy_;
		end else if(s3_cs_ == `ENABLE_) begin
			m_rd_data = s3_rd_data;
			m_rdy_	  = s3_rdy_;
		end else if(s4_cs_ == `ENABLE_) begin
			m_rd_data = s4_rd_data;
			m_rdy_	  = s4_rdy_;
		end else if(s5_cs_ == `ENABLE_) begin
			m_rd_data = s5_rd_data;
			m_rdy_	  = s5_rdy_;
		end else if(s6_cs_ == `ENABLE_) begin
			m_rd_data = s6_rd_data;
			m_rdy_	  = s6_rdy_;
		end else if(s7_cs_ == `ENABLE_) begin
			m_rd_data = s7_rd_data;
			m_rdy_	  = s7_rdy_;
		end else begin
			m_rd_data = `WORD_DATA_W'h0;
			m_rdy_    = `DISABLE_;
		end

endmodule

	

