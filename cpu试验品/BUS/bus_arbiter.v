//待优化项目：1.合并always   2.加入默认else，避免锁存器

//********************************总线仲裁
`include "header/bus.h"
module bus_arbiter(
	input	 wire		clk,
	input	 wire		reset,
	
	//**************0号总线主控
	input	 wire		m0_req_,		//请求总线
	output	 reg		m0_grnt_,		//赋予总线

	input	 wire		m1_req_,
	output	 reg		m1_grnt_,
	input	 wire		m2_req_,
	output	 reg		m2_grnt_,
	input	 wire		m3_req_,
	output	 reg		m3_grnt_
);
	reg	[1:0]	owner;				//总线所有者
	
	//******************************赋予总线使用权
	always @ * begin
		//****赋予总线使用权初始化
		m0_grnt_ = `DISABLE_;
		m1_grnt_ = `DISABLE_;
		m2_grnt_ = `DISABLE_;
		m3_grnt_ = `DISABLE_;
		//****赋予总线使用权
		case (owner)
			`BUS_OWNER_MASTER_0 :	m0_grnt_ = `ENABLE_;

			`BUS_OWNER_MASTER_1 :	m1_grnt_ = `ENABLE_;

			`BUS_OWNER_MASTER_2 :	m2_grnt_ = `ENABLE_;

			`BUS_OWNER_MASTER_3 :	m3_grnt_ = `ENABLE_;
		endcase
	end

	always @(posedge clk or `RESET_EDGE reset) 
		if(reset == `RESET_ENABLE) 
			owner <= #1 `BUS_OWNER_MASTER_0;		//开机等于复位？
		else 
			case (owner)
			`BUS_OWNER_MASTER_0 : 				//所有权级别：0>1>2>3
				if	(m0_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_0;
				else if (m1_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_1;
				else if (m2_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_2;
				else if (m3_req_ == `ENABLE_)	 owner	<= #1 `BUS_OWNER_MASTER_3;
				//**********注意此处不直接 m0_grnt_ <= #1 `ENABLE_是因为两者always语句
				//**********的判断条件不一样，而m0_grnt又不能在两种always里赋值，必须
				//**********借助辅助的中间量。
			
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
			
							
							

				
			





















	