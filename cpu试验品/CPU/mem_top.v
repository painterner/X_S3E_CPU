`include "header/firstglobal.h"
`include "header/cpuglobal.h"
`include "header/bus.h"
`include "CPU/MEM/mem_ctrl.v"
`include "CPU/MEM/mem_reg.v"
module mem_top(	
	input wire			clk,
	input wire			reset,
	
	//***********************???????
	input wire			stall,		//????
	input wire			flush,		//????
	output wire			busy,		//?????
	
	//*************************************************************bus_if ??**************************//
	//***********************SPM??
	input wire	[`WordDataBus]	spm_rd_data,    
	output wire					spm_as_,
	output wire	[`WordAddrBus]	spm_addr,
	output wire	[`WordDataBus]	spm_wr_data,
	output wire					spm_rw,
	//***********************????
	input wire	[`WordDataBus]	bus_rd_data,
	input wire					bus_rdy_,
	input wire					bus_grnt_,
	output wire					bus_as_,
	output wire					bus_req_,
	output wire	[`WordAddrBus]	bus_addr,
	output wire					bus_rw,
	output wire	[`WordDataBus]	bus_wr_data,
	
	
	//***************************************************************mem_ctrl??************************//
	input wire								ex_en,                         
    input wire	[`MemOpBus]					ex_mem_op,                     
    input wire	[`WordDataBus]				ex_mem_wr_data,                
    input wire	[`WordDataBus]				ex_out,                                                                                                                        
      
    //**************************************************************mem_reg ??*************************//                                          	                                                                    
 	//*************************************EX/MEM??????              
 	input wire	[`WordAddrBus]			ex_pc          ,                                
 	input wire							ex_br_flag     ,                
 	input wire	[`CtrlOpBus]			ex_ctrl_op     ,                
 	input wire	[`RegAddrBus]			ex_dst_addr    ,                
 	input wire							ex_gpr_we_     ,                
 	input wire	[`IsaExpBus]			ex_exp_code    ,                
 	//*************************************MEM/WB???????             	                                                                       
 	output wire	[`WordAddrBus]			mem_pc          ,     	        
 	output wire							mem_en          ,               
 	output wire							mem_br_flag     ,               
 	output wire	[`CtrlOpBus]			mem_ctrl_op     ,               
 	output wire	[`RegAddrBus]			mem_dst_addr    ,               
 	output wire							mem_gpr_we_     ,               
 	output wire	[`IsaExpBus]			mem_exp_code    ,               
 	output wire	[`WordDataBus]			mem_out     	,
 	
 	//*************************************************************???******************************//
 	output wire	[`WordDataBus]			fwd_data					//????
 
 );
 
 	wire	[`WordDataBus]				out;                                       
 	wire								miss_align; 
 	wire	[`WordDataBus]				rd_data;                     
 	wire	[`WordAddrBus]				addr;               
 	wire								as_;                
 	wire								rw;                 
 	wire	[`WordDataBus]				wr_data;
 	 
 	assign  fwd_data						= out;
 	
 	bus_if bus_if1(
 		.clk                  (clk             ),               
 	    .reset                (reset           ),                	                                                    
 	    .stall		          (stall		   ),  
 	    .flush		          (flush		   ),  
 	    .busy		          (busy		       ),           
 	   	.addr                 (addr            ),       
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
	mem_ctrl mem_ctrl0(                           
		.ex_en            	   (ex_en             ) ,   
		.ex_mem_op             (ex_mem_op         ) ,
		.ex_mem_wr_data        (ex_mem_wr_data    ) ,
		.ex_out              	(ex_out           ) , 	                                                                              
		.rd_data               (rd_data           ) ,
		.addr                  (addr              ) ,
		.as_                   (as_               ) ,
		.rw                    (rw                ) ,
		.wr_data             	(wr_data          ) , 	                                                                             
		.out                   (out               ) ,
		.miss_align            (miss_align        )  
				
	); 
	mem_reg mem_reg0(
		.clk                 	(clk              ),           
	   	.reset               	(reset            ),           
	   	.flush               	(flush            ),           
	   	.stall               	(stall            ),                            
	   	.out                 	(out              ),           
	   	.miss_align          	(miss_align       ),                    
	   	.ex_pc               	(ex_pc            ),           
	   	.ex_en               	(ex_en            ),           
	   	.ex_br_flag          	(ex_br_flag       ),           
	   	.ex_ctrl_op          	(ex_ctrl_op       ),           
	   	.ex_dst_addr         	(ex_dst_addr      ),           
	   	.ex_gpr_we_          	(ex_gpr_we_       ),           
	   	.ex_exp_code         	(ex_exp_code      ),                       
	   	.mem_pc              	(mem_pc           ), 	        
	   	.mem_en              	(mem_en           ),           
	   	.mem_br_flag         	(mem_br_flag      ),           
	   	.mem_ctrl_op         	(mem_ctrl_op      ),           
	   	.mem_dst_addr        	(mem_dst_addr     ),           
	   	.mem_gpr_we_         	(mem_gpr_we_      ),           
	   	.mem_exp_code        	(mem_exp_code     ),               
       	.mem_out             	(mem_out          )
       	);
       	
endmodule          