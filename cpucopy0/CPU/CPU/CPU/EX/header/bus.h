`ifndef __BUS_HEADER__
	`define __BUS_HEADER__	

	//*****************主控
	`define BUS_MASTER_CH		4	//总线主控通道数
	`define BUS_MASTER_INDEX_W	2	//总线主控索引宽度
	
	//*****************总线分配
	`define BusOwnerBus		1:0	//总线使用者总线
	`define BUS_OWNER_MASTER_0	2'h0	//总线使用权所有者：0号主控
	`define BUS_OWNER_MASTER_1	2'h1	//总线使用权所有者：1号主控
	`define BUS_OWNER_MASTER_2	2'h2    //总线使用权所有者：2号主控
	`define BUS_OWNER_MASTER_3	2'h3	//总线使用权所有者：3号主控

	//*****************总线从属
	`define BUS_SLAVE_CH		8	//总线从属通道数
	`define BUS_SLAVE_INDEX_W	3	//总线从属索引宽度
	`define BusSlaveIndexBus	2:0	//总线从属索引总线
	`define	BusSlaveIndexLoc	29:27	//总线从属索引位置
	`define BUS_SLAVE_0		0	//0号从属总线
	`define BUS_SLAVE_1		1
	`define BUS_SLAVE_2		2
	`define BUS_SLAVE_3		3
	`define BUS_SLAVE_4		4
	`define BUS_SLAVE_5		5
	`define BUS_SLAVE_6		6
	`define BUS_SLAVE_7		7
`endif