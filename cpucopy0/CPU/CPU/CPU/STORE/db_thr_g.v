//*********���������ͷ�һ��˫��3̬�� ��ע�⣺ʹ��ʱҪ����DataBus�����ݻ��壩

module db_thr_g(
	inout 	Bus,
	output reg	Bus0,
	output reg	Bus1,
	input wire	control
	
);
	assign Bus = (control == 1)? Bus0:1'bz;
	assign Bus = (control == 0)? Bus1:1'bz;



endmodule		
	
	