/******头文件******/
`include"header/regfile.h"

/******模块******/
module regfile(
	/******时钟和复位******/
	input	wire		clk,
	input	wire		reset_,
	
	/******访问接口******/
	input  wire [`AddrBus]	addr,
	input  wire [`DataBus]	d_in,
	inout  wire [`DataBus]	Bus,
	input  wire 		we_,
	input  wire 		as_,
	input  wire		cs_,
	output reg		rdy_
);
	
	/******内部信号******/
	reg	[`DataBus]	ff[`DATA_D-1:0];
	reg	[`DataBus]	d_out;
	integer			i;

	assign Bus = (we_ == `ENABLE_)?	   d_in:{`DATA_W{1'bz}};
	assign Bus = (we_ == `DISABLE_)?   d_out:{`DATA_W{1'bz}}; 
	
	/******读取访问******/
	always @(negedge clk or negedge reset_)
		if(reset_ == 0)
			d_out = #1 {`DATA_W{1'b0}};
		else 
			d_out = #1 ff[addr];
	
	/******写入访问******/
	always @(posedge clk or negedge reset_)
		if(reset_ == 0)
			ff[i] <= #1 {`DATA_W{1'b0}};
		else if(we_ ==`ENABLE_)
			ff[addr] <= #1 d_in;
	
	/******生成rdy_信号****/					
	always @(posedge clk or negedge reset_)
	if(reset_ == 0)
		rdy_	<= #1 `DISABLE_;
	else if((cs_== `ENABLE_)&&(as_ == `ENABLE_))
		rdy_	<= #1 `ENABLE_;
	else	
		rdy_	<= #1 `DISABLE_;

endmodule
					
		

