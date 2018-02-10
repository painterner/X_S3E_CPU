`include "header/rom.h"
`include "header/firstglobal.h"
module x_s3e_sprom(
		input wire					clka ,
		input wire	[`RomAddrBus]	addra,
		output reg	[`WordDataBus]	douta
	);
	
	reg	[`WordDataBus]				gpr[`RomAddrBus];
	always @ (posedge clka)	
		douta			<= #1 gpr[addra];
	
endmodule