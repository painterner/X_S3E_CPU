`include "header/firstglobal.h"
`include "header/cpuglobal.h"
`include "header/ioglobal.h"
module uart_rx(
	input wire						clk,
	input wire						reset,
	//******************************************************
	input wire						rx,
	output wire						rx_busy,
	output reg						rx_end,
	output reg	[`ByteDataBus]		rx_data
	
);
	reg							state;
	reg	[`UartDivCntBus]		div_cnt;
	reg	[`UartBitCntBus]		bit_cnt;
	//******************************************************接收busy信号
	assign rx_busy				= (state != `UART_STATE_IDLE) ? `ENABLE : `DISABLE;
	//******************************************************接收逻辑电路
	always @(posedge clk or `RESET_EDGE reset)
		if(reset == `RESET_ENABLE) begin
			state				<= #1 `UART_STATE_IDLE;       
            div_cnt				<= #1 `UART_DIV_RATE/2;         
            bit_cnt				<= #1 `UART_BIT_CNT_W'h0;    
            rx_data				<= #1 `BYTE_DATA_W'H0;        
            rx_end				<= #1 `DISABLE;   
        end else
        	case(state)
        		`UART_STATE_IDLE	: begin
        			if(rx == `UART_START_BIT)	
        				state	<= #1 `UART_STATE_RX;
        			
        			rx_end		<= #1 `DISABLE;
        		end
        		`UART_STATE_RX		: 
        			if(div_cnt == {`UART_DIV_CNT_W{1'b0}})
        				case(bit_cnt)
        	            	`UART_BIT_CNT_STOP	: begin                            
        						state				<= #1 `UART_STATE_TX;                   
                        		bit_cnt				<= #1 `UART_BIT_CNT_START;  
                        		div_cnt				<= #1 `UART_DIV_RATE/2;             
                        	                                           
                        		if(rx == `UART_STOP_BIT)					//差错检测
                        			rx_end			<= #1 `ENABLE;
           			    	           end
           			    	 default				: begin
           			    	 	rx_data				<= #1 {rx,rx_data[`BYTE_MSB:`LSB+1]};
           			    	 	bit_cnt				<= #1 bit_cnt + 1'b1;
           			    	 	div_cnt 			<= #1 `UART_DIV_RATE; 
           			    	 end
           				endcase
           			else
           				div_cnt						<= #1 div_cnt - 1'b1;
           	endcase
             
endmodule                        