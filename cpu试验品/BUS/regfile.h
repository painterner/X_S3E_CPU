`ifndef __REGFILE_HEADER__
	`define __REGFILE_HEADER__
	
	/******信号电平******/
	`define HIGH			1'b1
	`define LOW			1'b0
	
	/******逻辑值******/
	`define	ENABLE_			1'b0
	`define DISABLE_		1'b1
	
	/******数据******/
	`define DATA_W			32		//数据宽度
	`define DataBus			31:0		//数据总线
	`define DATA_D			32		//数据深度

	/******地址******/
	`define ADDR_W			30		//地址宽度
	`define AddrBus			29:0		//地址总线

`endif
