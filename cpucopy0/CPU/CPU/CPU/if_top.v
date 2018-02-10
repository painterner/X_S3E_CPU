
`include "header/firstglobal.h"
`include "header/cpuglobal.h"
`include "header/bus.h"
`include "CPU/IF/if_reg.v"
`include "CPU/IF/bus_if.v" 
module if_top(
	input wire			clk,
	input wire			reset,
	input wire			stall,		
	input wire			flush,		
	output wire			busy,	
	
	//*******************************************buf_if******************//	
	//***********************SPM
	input wire	[`WordDataBus]	spm_rd_data,    
	output wire			spm_as_,
	output wire	[`WordAddrBus]	spm_addr,
	output wire	[`WordDataBus]	spm_wr_data,
	output wire			spm_rw,
	//***********************????
	input wire	[`WordDataBus]	bus_rd_data,
	input wire			bus_rdy_,
	input wire			bus_grnt_,
	output wire			bus_as_,
	output wire			bus_req_,
	output wire	[`WordAddrBus]	bus_addr,
	output wire			bus_rw,
	output wire	[`WordDataBus]	bus_wr_data,
	
	//********************************************if_reg****************//
    //input wire	[`WordDataBus]		insn,		                                                                                                                
    input wire	[`WordAddrBus]		new_pc,		               
    input wire						br_taken,	               
    input wire	[`WordAddrBus]		br_addr,	                                                                       
	output wire						if_en,		     
	output wire	[`WordAddrBus]		if_pc,	       
	output wire	[`WordDataBus]		if_insn	

);
	
	  //***********************CPU??   
	  // wire	[`WordAddrBus]	addr;											//
	  reg			        rw		= `READ;          
	  reg			        as_		= `ENABLE_;
	  reg	[`WordDataBus]	wr_data	= `WORD_DATA_W'H0;
	  wire	[`WordDataBus]	rd_data;
	  
	  bus_if bus_if0(
 		.clk                  (clk             ),               
 	    .reset                (reset           ),                	                                                    
 	    .stall		          (stall		   ),  
 	    .flush		          (flush		   ),  
 	    .busy		          (busy		       ),           
 	   	.addr                 (if_pc            ),   							//    
 	    .rw                   (rw              ),               
 	    .as_                  (as_             ),               
 	   	.wr_data              (wr_data         ),       
 	   	.rd_data              (rd_data         ),              
 	   	.spm_rd_data          (spm_rd_data     ),       
 	    .spm_as_              (spm_as_         ),               
 	    .spm_addr             (spm_addr        ),       
 	    .spm_wr_data          (spm_wr_data     ),       
 	    .spm_rw               (spm_rw          ),                	                                        
 	    .bus_rd_data          (bus_rd_data     ),       
 	    .bus_rdy_             (bus_rdy_        ),               
 	    .bus_grnt_            (bus_grnt_       ),               
 	    .bus_as_              (bus_as_         ),               
 	    .bus_req_             (bus_req_        ),               
 	    .bus_addr             (bus_addr        ),       
 	    .bus_rw               (bus_rw          ),               
 	    .bus_wr_data          (bus_wr_data     )       
 	
	); 
	if_reg if_reg0(
		.clk        (  clk         ) 			,
		.reset      (  reset       ) 	        ,                        
		.insn		( rd_data		)   	    ,  							//                          
		.stall		( stall		)               ,
		.flush		( flush		)               ,
		.new_pc	    (	 new_pc	)               ,
		.br_taken	( br_taken	    )           ,
		.br_addr	( br_addr	    )           ,                     
		.if_en		( if_en		)               ,
		.if_pc		( if_pc		)               ,
		.if_insn	( if_insn	    )           
	
);

endmodule






























