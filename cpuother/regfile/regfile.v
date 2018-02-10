/******ͷ�ļ�******/
`include"regfile.h"

/******ģ��******/
module regfile(
	/******ʱ�Ӻ͸�λ******/
	input	wire		clk,
	input	wire		reset_,
	
	/******���ʽӿ�******/
	input  wire [`AddrBus]	addr,
	input  wire [`DataBus]	d_in,
	input  wire 		we_,
	output wire [`DataBus]	d_out
);
	
	/******�ڲ��ź�******/
	reg	[`DataBus]	ff[`DATA_D-1:0];
	integer			i;
	
	/******��ȡ����******/
	assign	d_out=ff[addr];				//��ȡ������ʱ���޹ء�
	
	/******д�����******/
	always	@(posedge clk or negedge reset_) begin

		if(reset_ == `ENABLE_)
			ff[i] <= #1 {`DATA_W{1'b0}};
		else if(we_ ==`ENABLE_)
			ff[addr] <= #1 d_in;
						end

endmodule
					
		

