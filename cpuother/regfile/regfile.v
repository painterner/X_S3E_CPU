/******头文件******/
`include"regfile.h"

/******模块******/
module regfile(
	/******时钟和复位******/
	input	wire		clk,
	input	wire		reset_,
	
	/******访问接口******/
	input  wire [`AddrBus]	addr,
	input  wire [`DataBus]	d_in,
	input  wire 		we_,
	output wire [`DataBus]	d_out
);
	
	/******内部信号******/
	reg	[`DataBus]	ff[`DATA_D-1:0];
	integer			i;
	
	/******读取访问******/
	assign	d_out=ff[addr];				//读取数据与时钟无关。
	
	/******写入访问******/
	always	@(posedge clk or negedge reset_) begin

		if(reset_ == `ENABLE_)
			ff[i] <= #1 {`DATA_W{1'b0}};
		else if(we_ ==`ENABLE_)
			ff[addr] <= #1 d_in;
						end

endmodule
					
		

