`include "header/ioglobal.h"
module chip_top(

	input wire							clk_ref		,
	input wire							reset_sw    ,
	input wire							rx       	,                        
    output wire							tx          ,                         
	input wire	[`GPIO_IN_CH-1:0]		gpio_in     ,       
	output wire	[`GPIO_OUT_CH-1:0]		gpio_out    ,       
	inout wire	[`GPIO_IO_CH-1:0]		gpio_io     
);  
	
	wire	clk;
	wire	clk_;
	wire	chip_reset;     

	chip chip0(              
		.clk               (clk           )         ,                     
		.clkcounter			(clk_		)			,         
		.reset	           (chip_reset	       )    ,                             
    	.rx       	       (rx       	   )        ,           
    	.tx                (tx            )         ,            
		.gpio_in           (gpio_in       )         ,
		.gpio_out          (gpio_out      )         ,
		.gpio_io            (gpio_io        )       
		
	);          

	clk_gen clk_gen0(
		.clk_ref      		(clk_ref    	)		,
		.reset_sw          (reset_sw      )         ,
		.clk               (clk           )         ,
		.clk_              (clk_          )         ,
		.chip_reset         (chip_reset     )
	); 
	
endmodule