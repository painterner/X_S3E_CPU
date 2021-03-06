`ifndef __UART_H__ 
	`define __UART_H__
	//******************************************************分频计数器
	`define UART_DIV_RATE			260
	`define UART_DIV_CNT_W			9
	`define UartDivCntBus			8:0
	//******************************************************2个寄存器控制
	`define UartAddrBus				0:0
	`define UART_ADDR_W				1
	`define UartAddrLoc				0:0	
	`define UART_ADDR_STATUS		1'B0
	`define UART_ADDR_DATA			1'B1
	`define UartCtrlIrqRx			0
	`define UartCtrlIrqTx			1
	`define	UartCtrlBusyRx			2
	`define UartCtrlBusyTx			3
	//******************************************************发送状态
	`define UartStateBus			0:0
	`define UART_STATE_IDLE			1'B0
	`define UART_STATE_RX			1'b1
	`define UART_STATE_TX			1'b1
	//******************************************************比特计数器
	`define UartBitCntBus			3:0
	`define UART_BIT_CNT_W			4
	`define UART_BIT_CNT_START		0
	`define UART_BIT_CNT_MSB		8
	`define UART_BIT_CNT_STOP		9
	`define UART_START_BIT			1'b0
	`define UART_STOP_BIT			1'b1
`endif
