`include "header/firstglobal.h"        
`include "header/cpuglobal.h"          
`include "header/ioglobal.h"  
`include "IO/uart_ctrl.v"
`include "IO/uart_rx.v"
`include "IO/uart_tx.v"             
module uart_top(
	input wire							clk			,
	input wire							reset       ,
	//******************************************************总线接口
	input wire							as_         ,
	input wire							cs_         ,
	input wire							rw          ,
	input wire							addr		,					//注意
	input wire	[`WordDataBus]			wr_data     ,
	output wire	[`WordDataBus]			rd_data     ,
	output wire							rdy_        ,
	//******************************************************中断
	output wire							irq_tx      ,
	output wire							irq_rx      ,
	//******************************************************rx && tx data
	input wire							rx       	,
	output wire							tx
	
);

	wire							rx_busy  	;
	wire							rx_end      ;
	wire	[`ByteDataBus]			rx_data     ;
	wire							tx_busy     ;
	wire							tx_end      ;
	wire							tx_start    ;
	wire	[`ByteDataBus]			tx_data     ;

	uart_tx uart_tx0(
		.clk         	(clk        ),
		.reset          (reset      ),
		.tx_start       (tx_start   ),
		.tx_data        (tx_data    ),
		.tx_busy        (tx_busy    ),
		.tx_end         (tx_end     ),
		.tx             (tx         )
	
	);
	uart_rx uart_rx0(
		.clk			(clk        ), 
		.reset          (reset      ), 
		.rx             (rx         ), 
		.rx_busy        (rx_busy    ), 
		.rx_end         (rx_end     ), 
		.rx_data        (rx_data    ) 
	
	);
	uart_ctrl uart_ctrl0(
		.clk        	(clk        ), 
		.reset          (reset      ), 
		.as_            (as_        ), 
		.cs_            (cs_        ), 
		.rw             (rw         ), 
		.addr			(addr		),				
		.wr_data        (wr_data    ), 
		.rd_data        (rd_data    ), 
		.rdy_           (rdy_       ), 
		.irq_tx         (irq_tx     ), 
		.irq_rx         (irq_rx     ), 
		.rx_busy        (rx_busy    ), 
		.rx_end         (rx_end     ), 
		.rx_data        (rx_data    ), 
		.tx_busy        (tx_busy    ), 
		.tx_end         (tx_end     ), 
		.tx_start       (tx_start   ), 
		.tx_data        (tx_data    )
	);

endmodule