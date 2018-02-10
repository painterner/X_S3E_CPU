`timescale 1ns/1ps
`include "regfile.h"

/******模块******/
module regfile_test;
	reg			clk;
	reg			reset_;	
	//访问接口
	reg	[`AddrBus]	addr;			//地址
	reg	[`DataBus]	d_in;			//输入数据
	reg			we_;			//使能信号
	wire	[`DataBus]	d_out;			//输出数据
	/******内部变量******/
	integer			i;
	/******仿真步长******/
	parameter		STEP = 100.000;		//10Mhz
	
	/*******生成时钟******/
	always #(STEP/2)	clk=~clk;
	
	/******实例化*******/
	regfile regfile(
		.clk	(clk),
		.reset_	(reset_),
		/******访问接口*********/
		.addr	(addr),
		.d_in	(d_in),
		.we_	(we_),
		.d_out	(d_out)
	);

	/***********测试用例************/
	initial begin
		/********初始化********/
		# 0 		
			clk	<= `HIGH;
			reset_ 	<= `ENABLE_;
			addr	<= {`ADDR_W{1'b0}};
			d_in	<= {`DATA_W{1'b0}};
			we_	<= `DISABLE_;
				
		# (STEP *3/4)					//延迟3/4
		# STEP		reset_	<= `DISABLE_;		//解除复位

		/********循环仿真******/
		# STEP 	
			for(i=0; i<`DATA_D;i=i+1) begin
			# STEP
				addr 	<= i;			//在地址i处写入
				d_in	<= i;
				we_	<= `ENABLE_;
			
			# STEP
				addr	<= {`ADDR_W{1'b0}};	//读取地址0
				d_in	<= {`DATA_W{1'b0}};
				we_	<= `DISABLE_;
				if(d_out == i)
					$display ($time,"ff[%d] Read/Write Check OK!",i);
				else
					$display ($time,"ff[%d] Read/Write Check NG!",i);
			end
		# STEP 
			$finish;
	end

	/*********输出波形**********/
	initial begin
		$dumpfile("regfile.vcd");
		$dumpvars(0,regfile);
	end
	

endmodule			
			
		
			
				


			
		