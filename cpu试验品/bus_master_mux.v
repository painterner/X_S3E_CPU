//*******************根据mx_grnt_选择仲裁后所有者的控制，地址，数据
`include "header/bus.h"
module bus_master_mux(
	input wire	[29:0]	m0_addr,		//地址
	input wire		m0_as_,			//地址选通
	input wire		m0_rw,			//读写
	input wire	[31:0]	m0_wr_data,		//写入的数据
	input wire		m0_grnt_,  		//赋予总线

	input wire	[29:0]	m1_addr,		//地址
	input wire		m1_as_,			//地址选通
	input wire		m1_rw,			//读写
	input wire	[31:0]	m1_wr_data,		//写入的数据
	input wire		m1_grnt_,  		//赋予总线

	input wire	[29:0]	m2_addr,		//地址
	input wire		m2_as_,			//地址选通
	input wire		m2_rw,			//读写
	input wire	[31:0]	m2_wr_data,		//写入的数据
	input wire		m2_grnt_,  		//赋予总线

	input wire	[29:0]	m3_addr,		//地址
	input wire		m3_as_,			//地址选通
	input wire		m3_rw,			//读写
	input wire	[31:0]	m3_wr_data,		//写入的数据
	input wire		m3_grnt_,  		//赋予总线

	//**********************共享信号总线从属，输出选通信号
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
























