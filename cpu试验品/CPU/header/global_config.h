//****************************************与开发板有关的复位，内存，i/o

`ifndef __GLOBAL_CONFIG_HEADER__
	`define __GLOBAL_CONFIG_HEADER__
	
	/********复位信号极性选择***********/
		//`define POSITIVE_RESET		NaN	//使用active high 复位时定义POSITIVE_RESET
	`define NEGATIVE_RESET		NaN	
	
	/********内存控制信号极性的选择********/
	`define POSITIVE_MEMORY		NaN	//使用active high 复位时定义此宏
	`define NEGATIVE_MEMORY		NaN	

	/********I/O的选择*****************/
	`define IMPLEMENT_TIMER		NaN	//需要使用定时器时再定义此宏
	`define IMPLEMENT_UART		NaN
	`define IMPLEMENT_GPIO		NaN

	/********复位***********/
	`define RESET_EDGE		negedge	//根据不同开发板定义不同复位方式
	`define	RESET_ENABLE		1'b0	//内存有效
	`define RESET_DISABLE		1'b1

	/********内存**********/
	`define MEM_ENABLE		1'b1	//(if select the POSITIVE_MEMORY)
	`define MEM_DISABLE		1'b0
`endif



