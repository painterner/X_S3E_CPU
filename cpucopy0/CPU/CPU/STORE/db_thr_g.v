//*********单控制无释放一对双向3态门 （注意：使用时要定义DataBus的数据缓冲）

module db_thr_g(
	inout 	Bus,
	output reg	Bus0,
	output reg	Bus1,
	input wire	control
	
);
	assign Bus = (control == 1)? Bus0:1'bz;
	assign Bus = (control == 0)? Bus1:1'bz;



endmodule		
	
	