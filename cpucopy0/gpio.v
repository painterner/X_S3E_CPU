`include "header/firstglobal.h"
`include "header/cpuglobal.h"
`include "header/ioglobal.h"
module gpio(
	input wire							clk,
	input wire							reset,
	//******************************************************总线接口
	input wire							cs_,
	input wire							as_,
	input wire							rw,
	input wire	[`GpioAddrBus]			addr,
	input wire	[`WordDataBus]			wr_data,
	output reg	[`WordDataBus]			rd_data,
	output reg							rdy_,
	//******************************************************通用输入输入端口
	input wire	[`GPIO_IN_CH-1:0]		gpio_in,
	output reg	[`GPIO_OUT_CH-1:0]		gpio_out,
	inout wire	[`GPIO_IO_CH-1:0]		gpio_io
);
	//******************************************************inout类型的控制
`ifdef GPIO_IO_CH
	wire	[`GPIO_IO_CH-1:0]			io_in;
	reg		[`GPIO_IO_CH-1:0]			io_out;
	reg		[`GPIO_IO_CH-1:0]			io_dir;
	reg		[`GPIO_IO_CH-1:0]			io;
	integer							i;
	
	assign	io_in				= gpio_io;
	assign	gpio_io				= io;
	
	always @ *
		for(i=0;i<`GPIO_IO_CH;i=i+1)
			io[i]				= (io_dir[i] == `GPIO_DIR_IN) ?	1'Bz:io_out[i];
`endif

	//******************************************************gpio的控制		
	always @(posedge clk or `RESET_EDGE reset)
		if(reset == `RESET_ENABLE)	begin
			rd_data				<= #1 `WORD_DATA_W'H0;
			rdy_				<= #1 `DISABLE_;
`ifdef GPIO_OUT_CH
			gpio_out			<= #1 {`GPIO_IO_CH{`LOW}};
`endif
`ifdef GPIO_IO_CH
			io_out				<= #1 {`GPIO_IO_CH{`LOW}};									
			io_dir				<= #1 {`GPIO_IO_CH{`GPIO_DIR_IN}};
`endif
		end else begin
			if((cs_ == `ENABLE_)&&(as_ == `ENABLE_))
				rdy_			<= #1 `ENABLE_;
			else 
				rdy_			<= #1 `DISABLE_;
				
			if((cs_ == `ENABLE_)&&(as_ == `ENABLE_)&&(rw == `READ))
				case(addr)
`ifdef GPIO_IN_CH					
					`GPIO_ADDR_IN_DATA 	:
						rd_data <= #1 {{`WORD_DATA_W-`GPIO_IN_CH{1'b0}},gpio_in};
`endif
`ifdef GPIO_OUT_CH
					`GPIO_ADDR_OUT_DATA	:
						rd_data	<= #1 {{`WORD_DATA_W-`GPIO_OUT_CH{1'B0}},gpio_out};
`endif
`ifdef GPIO_IO_CH
					`GPIO_ADDR_IO_DATA	:
						rd_data <= #1 {{`WORD_DATA_W-`GPIO_IO_CH{1'B0}},io_in};
					`GPIO_ADDR_IO_DIR	:
						rd_data <= #1 {{`WORD_DATA_W-`GPIO_IO_CH{1'B0}},io_dir};
`endif
				endcase
			else
				rd_data			<= #1 `WORD_DATA_W'H0;
				
			if((cs_ == `ENABLE_)&&(as_ == `ENABLE_)&&(rw == `WRITE)) 
`ifdef GPIO_OUT_CH
				case(addr)
					`GPIO_ADDR_OUT_DATA	:
						gpio_out<= #1 wr_data[`GPIO_OUT_CH-1:0];
`endif
`ifdef GPIO_IO_CH
					`GPIO_ADDR_IO_DATA	:
						io_out	<= #1 wr_data[`GPIO_IO_CH-1:0];
					`GPIO_ADDR_IO_DIR	:
						io_dir	<= #1 wr_data[`GPIO_IO_CH-1:0];
`endif
				endcase
		end

endmodule
			
			