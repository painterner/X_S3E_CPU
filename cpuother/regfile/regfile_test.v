`timescale 1ns/1ps
`include "regfile.h"

/******ģ��******/
module regfile_test;
	reg			clk;
	reg			reset_;	
	//���ʽӿ�
	reg	[`AddrBus]	addr;			//��ַ
	reg	[`DataBus]	d_in;			//��������
	reg			we_;			//ʹ���ź�
	wire	[`DataBus]	d_out;			//�������
	/******�ڲ�����******/
	integer			i;
	/******���沽��******/
	parameter		STEP = 100.000;		//10Mhz
	
	/*******����ʱ��******/
	always #(STEP/2)	clk=~clk;
	
	/******ʵ����*******/
	regfile regfile(
		.clk	(clk),
		.reset_	(reset_),
		/******���ʽӿ�*********/
		.addr	(addr),
		.d_in	(d_in),
		.we_	(we_),
		.d_out	(d_out)
	);

	/***********��������************/
	initial begin
		/********��ʼ��********/
		# 0 		
			clk	<= `HIGH;
			reset_ 	<= `ENABLE_;
			addr	<= {`ADDR_W{1'b0}};
			d_in	<= {`DATA_W{1'b0}};
			we_	<= `DISABLE_;
				
		# (STEP *3/4)					//�ӳ�3/4
		# STEP		reset_	<= `DISABLE_;		//�����λ

		/********ѭ������******/
		# STEP 	
			for(i=0; i<`DATA_D;i=i+1) begin
			# STEP
				addr 	<= i;			//�ڵ�ַi��д��
				d_in	<= i;
				we_	<= `ENABLE_;
			
			# STEP
				addr	<= {`ADDR_W{1'b0}};	//��ȡ��ַ0
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

	/*********�������**********/
	initial begin
		$dumpfile("regfile.vcd");
		$dumpvars(0,regfile);
	end
	

endmodule			
			
		
			
				


			
		