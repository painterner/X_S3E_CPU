`include "header/firstglobal.h"
`include "header/cpuglobal.h"
`include "header/ioglobal.h"
module uart_ctrl(
	input wire							clk,
	input wire							reset,
	//******************************************************????
	input wire							as_,
	input wire							cs_,
	input wire							rw,
	input wire							addr,							//??
	input wire	[`WordDataBus]			wr_data,
	output reg	[`WordDataBus]			rd_data,
	output reg							rdy_,
	//******************************************************??
	output reg							irq_tx,
	output reg							irq_rx,
	//******************************************************????
	input wire							rx_busy,
	input wire							rx_end,
	input wire	[`ByteDataBus]			rx_data,
	input wire							tx_busy,
	input wire							tx_end,
	output reg							tx_start,
	output reg	[`ByteDataBus]			tx_data
	
);	
	
	reg	[`ByteDataBus]					rx_buf;
	
	always @ (posedge clk or `RESET_EDGE reset)
		if(	reset == `RESET_ENABLE) begin
			rd_data				<= #1 `WORD_DATA_W'h0;
			rdy_				<= #1 `DISABLE_;
			irq_rx				<= #1 `DISABLE;
			irq_tx				<= #1 `DISABLE;
			rx_buf				<= #1 `BYTE_DATA_W'h0;
			tx_start			<= #1 `DISABLE;
			tx_data				<= #1 `BYTE_DATA_W'h0;
		end else begin
			if((cs_ == `ENABLE_)&&(as_ == `ENABLE_))
				rdy_            <= #1 `ENABLE_;
			else
				rdy_			<= #1 `DISABLE_;
			
			//******************************************************????	
			if((cs_ == `ENABLE_)&&(as_ == `ENABLE_)&&(rw == `READ))
				case(addr)
					`UART_ADDR_STATUS	:	
						rd_data	<= #1 {{`WORD_DATA_W-4{1'b0}},tx_busy,rx_busy,irq_tx,irq_rx};
					`UART_ADDR_DATA		:
						rd_data <= #1 {{`WORD_DATA_W-8{1'b0}},rx_buf};					//*3 or *2?
				endcase
			else
						rd_data			<= #1 `WORD_DATA_W'h0;
			
			//******************************************************????
			//*******?????0
			if(tx_end == `ENABLE)
				irq_tx			<= #1 `ENABLE;
			else if((cs_ == `ENABLE_)&&(as_ == `ENABLE_)&&(rw == `WRITE)&&(addr == `UART_ADDR_STATUS))
				irq_tx			<= #1 wr_data[`UartCtrlIrqTx];
			
			if(rx_end == `ENABLE)
				irq_rx			<= #1 `ENABLE;
			else if((cs_ == `ENABLE_)&&(as_ == `ENABLE_)&&(rw == `WRITE)&&(addr == `UART_ADDR_STATUS))
				irq_rx			<= #1 wr_data[`UartCtrlIrqRx];
			
			//******?????1
			if((cs_ == `ENABLE_)&&(as_ == `ENABLE_)&&(rw == `WRITE)&&(addr == `UART_ADDR_DATA))	begin
				tx_start		<= #1 `ENABLE;
				tx_data			<= #1 wr_data[`BYTE_MSB:`LSB];
			end else begin
				tx_start		<= #1 `DISABLE;
				tx_data			<= #1 `BYTE_DATA_W'h0;
			
			end
			
			if(rx_end == `ENABLE)	
				rx_buf			<= #1 rx_data;
		end

endmodule
		
			
			
				
								