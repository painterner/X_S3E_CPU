//**********************指令集架构（instruction set architecture）有关的宏
`ifndef __ISA_H__
	`define __ISA_H__

	
	`define	ISA_NOP		32'h0
	`define	ISA_OP_W	6
	`define	IsaOpBus	5:0
	`define	IsaOpLoc	5:0
	
	//**************************操作
	`define	ISA_OP_ANDR	6'h00
	`define	ISA_OP_ANDI	6'h01		//invariable 常数->寄存器与常数的逻辑与
	`define	ISA_OP_ORR	6'h02
	`define	ISA_OP_ORI	6'h03
	`define	ISA_OP_XORR	6'h04
	`define	ISA_OP_XORI	6'h05
	`define	ISA_OP_ADDSR	6'h06
	`define	ISA_OP_ADDSI	6'h07		//有符号寄存器与常数加
	`define	ISA_OP_ADDUR	6'h08
	`define	ISA_OP_ADDUI	6'h09
	`define	ISA_OP_SUBSR	6'h0a
	`define	ISA_OP_SUBUR	6'h0b
	`define	ISA_OP_SHRLR	6'h0c		//logic register
	`define	ISA_OP_SHRLI	6'h0d
	`define	ISA_OP_SHLLR	6'h0e
	`define	ISA_OP_SHLLI	6'h0f
	`define	ISA_OP_BE	6'h10		//寄存器间的比较(==)
	`define	ISA_OP_BNE	6'h11
	`define	ISA_OP_BSGT	6'h12		//寄存期间的有符号比较（<）
	`define	ISA_OP_BUGT	6'h13
	`define	ISA_OP_JMP	6'h14
	`define	ISA_OP_CALL	6'h15		//寄存器指定子程序调用
	`define	ISA_OP_LDW	6'h16		//字读取
	`define	ISA_OP_STW	6'h17		
	`define	ISA_OP_TRAP	6'h18		//陷阱
	`define	ISA_OP_RDCR	6'h19		//读取控制寄存器
	`define	ISA_OP_WRCR	6'h1a
	`define	ISA_OP_EXRT	6'h1b		//exception retire 从异常恢复

	//**************************寄存器,操作数
	`define	ISA_REG_ADDR_W	5
	`define IsaRegAddrBus	4:0
	`define	IsaRaAddrLoc	25:21
	`define	IsaRbAddrLoc	20:16
	`define	IsaRcAddrLoc	15:11
	`define	ISA_IMM_W	16		//immediate 
	`define	ISA_EXT_W	16		//extend 符号扩展后的立即数宽
	`define	ISA_IMM_MSB	15		//立即数最高位
	`define	IsaImmBus	15:0
	`define	IsaImmLoc	15:0

	//**************************异常
	`define	ISA_EXP_W	3
	`define	IsaExpBus	2:0
	`define	ISA_EXP_NO_EXP	3'h0		//无异常
	`define	ISA_EXP_EXT_INT	3'h1		//external
	`define	ISA_EXP_UNDEF_INSN	3'h2	//未定义指令
	`define	ISA_EXP_OVERFLOW    	3'h3  	//溢出
	`define	ISA_EXP_MISS_ALIGN	3'h4	//地址未对齐
	`define	ISA_EXP_TRAP		3'h5	//陷阱
	`define	ISA_EXP_PRV_VIO		3'h6	//违反权限
`endif