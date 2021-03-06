//`include "header/firstglobal.h"
//`include "header/cpuglobal.h"
//`include "header/bus.h"
module mem_top(	
	input wire			clk,
	input wire			reset,
	
	//***********************流水线控制信号
	input wire			stall,		//延迟信号
	input wire			flush,		//刷新信号
	output wire			busy,		//总线忙信号
	
	//*************************************************************bus_if 部分**************************//
	//***********************SPM接口
	input wire	[`WordDataBus]	spm_rd_data,    
	output wire					spm_as_,
	output wire	[`WordAddrBus]	spm_addr,
	output wire	[`WordDataBus]	spm_wr_data,
	output wire					spm_rw,
	//***********************总线接口
	input wire	[`WordDataBus]	bus_rd_data,
	input wire					bus_rdy_,
	input wire					bus_grnt_,
	output wire					bus_as_,
	output wire					bus_req_,
	output wire	[`WordAddrBus]	bus_addr,
	output wire					bus_rw,
	output wire	[`WordDataBus]	bus_wr_data,
	
	
	//***************************************************************mem_ctrl部分************************//
	input wire								ex_en,                         
    input wire	[`MemOpBus]					ex_mem_op,                     
    input wire	[`WordDataBus]				ex_mem_wr_data,                
    input wire	[`WordDataBus]				ex_out,                                                                                                                        
      
    //**************************************************************mem_reg 部分*************************//                                          	                                                                    
 	//*************************************EX/MEM流水线寄存器              
 	output wire	[`WordAddrBus]			ex_pc          ,                                
 	output wire							ex_br_flag     ,                
 	output wire	[`CtrlOpBus]			ex_ctrl_op     ,                
 	output wire	[`RegAddrBus]			ex_dst_addr    ,                
 	output wire							ex_gpr_we_     ,                
 	output wire	[`IsaExpBus]			ex_exp_code    ,                
 	//*************************************MEM/WB流水线那寄存器             	                                                                       
 	output wire	[`WordAddrBus]			mem_pc          ,     	        
 	output wire							mem_en          ,               
 	output wire							mem_br_flag     ,               
 	output wire	[`CtrlOpBus]			mem_ctrl_op     ,               
 	output wire	[`RegAddrBus]			mem_dst_addr    ,               
 	output wire							mem_gpr_we_     ,               
 	output wire	[`IsaExpBus]			mem_exp_code    ,               
 	output wire	[`WordDataBus]			mem_out     	,
 	
 	//*************************************************************额外的******************************//
 	output wire	[`WordDataBus]			fwd_data					//数据直通
 
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
		.ex_out                (ex_out           ) , 	                                                                              
		.rd_data               (rd_data           ) ,
		.addr                  (addr              ) ,
		.as_                   (as_               ) ,
		.rw                    (rw                ) ,
		.wr_data               (wr_data          ) , 	                                                                             
		.out                   (out               ) ,   //ld数据结果，或者ex执行结果
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