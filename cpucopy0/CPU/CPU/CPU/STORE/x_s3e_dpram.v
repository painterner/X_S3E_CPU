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
	
	//******************************************************端口A
	always @ (posedge clka) begin
		/*读数据*/
		if((web == `ENABLE)&&(addra == addrb))				//读写相关处理
			douta		<= #1 dinb;
		else
			douta		<= #1 gpr[addra];
		/*写数据*/
		if(wea	== `ENABLE)
			gpr[addra]	<= #1 dina;
	end
	//******************************************************端口B
	always @ (posedge clkb) begin
		/*读数据*/
		if((wea == `ENABLE)&&(addrb == addra))				//读写相关处理
			doutb		<= #1 dina;
		else
			doutb		<= #1 gpr[addrb];
		/*写数据*/
		if(web	== `ENABLE)
			gpr[addrb]	<= #1 dinb;
	end

endmodule
			