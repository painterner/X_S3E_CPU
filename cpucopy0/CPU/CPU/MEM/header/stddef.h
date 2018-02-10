//**********全局通用宏************//
`ifndef __STDDER_HEADER__
	`define __STDDER_HEADER__
	
	/*********高低电平*********/
	`define HIGH		1'b1
	`define LOW		1'b0
	
	/*********逻辑有效与否*************/
	`define	DISABLE		1'b0
	`define ENABLE		1'b1
	`define DISABLE_	1'b1
	`define ENABLE_		1'b0
	
	/**********信号读写*************/
	`define READ		1'b1
	`define WRITE		1'b0
	
	/**********高低位判断************/
	`define LSB		0		//最低位
	`define BYTE_MSB	7		//字节最高位
	`define WORD_MSB	31		//字最高位
	`define WORD_ADDR_MSB   29		//地址最高位
	
	/**********数据大小************/
	`define BYTE_DATA_W	8		//数据宽度（字节）
	`define ByteDataBus	7:0		//数据总线（字节）
	`define WORD_DATA_W	32		//数据宽度（字）
	`define	WordDataBus	31:0		//数据总线（字）
	`define WORD_ADDR_W	30		//地址宽度
	`define WordAddrBus	29:0		//地址总线
	
	/*********位移与边界**********/
	`define BYTE_OFFSET_W	2		//位移宽度
	`define ByteOffsetBus	1:0		//位移总线
	`define WordAddrLoc	31:2		//字地址位置
	`define	ByteOffsetLoc	1:0		//字节位移位置
	`define BYTE_OFFSET_WORD 2'b00		//字边界
`endif