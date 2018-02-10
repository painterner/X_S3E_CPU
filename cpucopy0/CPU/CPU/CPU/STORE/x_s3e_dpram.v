module x_s3e_dpram(
	input wire						clka,
	input wire						wea,
	input wire	[`SpmAddrBus]		addra,
	input wire	[`WordDataBus]		dina,
	output reg	[`WordDataBus]		douta,
	
	input wire						clkb,
	input wire						web,
	input wire	[`SpmAddrBus]		addrb,
	input wire	[`WordDataBus]		dinb,
	output reg	[`WordDataBus]		doutb
	
);
	reg	[`WordDataBus]				gpr[`SpmAddrBus];
	
	//******************************************************�˿�A
	always @ (posedge clka) begin
		/*������*/
		if((web == `ENABLE)&&(addra == addrb))				//��д��ش���
			douta		<= #1 dinb;
		else
			douta		<= #1 gpr[addra];
		/*д����*/
		if(wea	== `ENABLE)
			gpr[addra]	<= #1 dina;
	end
	//******************************************************�˿�B
	always @ (posedge clkb) begin
		/*������*/
		if((wea == `ENABLE)&&(addrb == addra))				//��д��ش���
			doutb		<= #1 dina;
		else
			doutb		<= #1 gpr[addrb];
		/*д����*/
		if(web	== `ENABLE)
			gpr[addrb]	<= #1 dinb;
	end

endmodule
			