`ifndef	__GPIO_H__
	`define __GPIO_H__
	`define GPIO_IN_CH				4
	`define GPIO_OUT_CH				18
	`define GPIO_IO_CH				16
	`define	GpioAddrBus				1:0
	`define GPIO_ADDR_W				2
	`define GpioAddrLoc				1:0
	`define GPIO_ADDR_IN_DATA		2'H0
	`define GPIO_ADDR_OUT_DATA		2'H1
	`define GPIO_ADDR_IO_DATA		2'H2
	`define	GPIO_ADDR_IO_DIR		2'H3
	`define GPIO_DIR_IN				1'B0
	`define GPIO_DIR_OUT			1'B1
`endif