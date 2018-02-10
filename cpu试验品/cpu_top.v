`include "header/firstglobal.h"
`include "header/cpuglobal.h"
`include "CPU/ctrl.v"
`include "CPU/if_top.v"
`include "CPU/id_top.v"
`include "CPU/ex_top.v"
`include "CPU/mem_top.v"
`include "CPU/spm.v"
`include "CPU/gpr.v"
module cpu_top(
	input wire			clk                                             ,
	input wire			clkcounter								        , //????
	input wire			reset	                                        ,
//******************************************************if	
	//***********************????						
	//output wire			busy											,
	
	input wire	[`WordDataBus]	if_bus_rd_data							,
	input wire					if_bus_rdy_                             ,
	input wire					if_bus_grnt_                            ,
	output wire					if_bus_as_                              ,
	output wire					if_bus_req_                             ,
	output wire	[`WordAddrBus]	if_bus_addr                             ,
	output wire					if_bus_rw                               ,
	output wire	[`WordDataBus]	if_bus_wr_data                          ,
//******************************************************mem
	
	input wire	[`WordDataBus]	mem_bus_rd_data         				, 
	input wire					mem_bus_rdy_                            ,
    input wire					mem_bus_grnt_                           ,
    output wire					mem_bus_as_                             ,
    output wire					mem_bus_req_                            ,
    output wire	[`WordAddrBus]	mem_bus_addr                            ,
    output wire					mem_bus_rw                              ,
    output wire	[`WordDataBus]	mem_bus_wr_data                         ,
//******************************************************ctrl
    input wire	[`CpuIrqBus]			irq

); 	         
	
//*******************************************************if????	
//****************SPM                                   
	wire	[`WordDataBus]	if_spm_rd_data              ;
	wire					if_spm_as_                  ;
	wire	[`WordAddrBus]	if_spm_addr                 ;
	wire	[`WordDataBus]	if_spm_wr_data              ;
	wire					if_spm_rw                   ;                                                   
	//wire	[`WordDataBus]		insn		            ;                                                                                                    
    wire	[`WordAddrBus]		new_pc		            ;   
    wire						br_taken	            ;   
    wire	[`WordAddrBus]		br_addr	                ;                                                       
	wire						if_en		            ;
	wire	[`WordAddrBus]		if_pc	                ;
	wire	[`WordDataBus]		if_insn	                ;
	
	
	//******************************************************id????
 	   wire	[`WordDataBus]		gpr_rd_data_0           ;
       wire	[`WordDataBus]		gpr_rd_data_1           ;
       wire	[`RegAddrBus]		gpr_rd_addr_0           ;
       wire  [`RegAddrBus]		gpr_rd_addr_1           ;
       wire						ex_en                   ;
       wire	[`RegAddrBus]		ex_dst_addr             ;
       wire						ex_gpr_we_              ;
       wire	[`WordDataBus]		ex_fwd_data	         	;
       wire	[`WordDataBus]		mem_fwd_data            ;
       wire						exe_mode		        ; 	
       wire	[`WordDataBus]		creg_rd_data	        ; 	
       wire	[`RegAddrBus]		creg_rd_addr            ; 
       wire						ld_hazard	            ;
                                                        
       wire   [`WordAddrBus]      id_pc                 ;  
       wire   				    id_en                   ;
       wire   [`AluOpBus]			id_alu_op	        ;
       wire   [`WordDataBus]	    id_alu_in_0 	    ;   
       wire   [`WordDataBus]	    id_alu_in_1         ;
       wire   				    id_br_flag              ;
       wire   [`MemOpBus]			id_mem_op           ;
       wire   [`WordDataBus]	    id_mem_wr_data      ;
       wire   [`CtrlOpBus]	    id_ctrl_op              ;
       wire   [`RegAddrBus]	    id_dst_addr             ;
       wire   				    id_gpr_we_		        ;
       wire   [`IsaExpBus]	    id_exp_code  ;    
       
       //******************************************************ex????
	 wire							int_detect	    			;//????
	 wire	[`WordAddrBus]			ex_pc                      ;
     wire							ex_br_flag                 ;
     wire	[`MemOpBus]				ex_mem_op                  ;
     wire	[`WordDataBus]			ex_mem_wr_data             ;
     wire	[`CtrlOpBus]			ex_ctrl_op                 ;
     wire	[`IsaExpBus]			ex_exp_code                ;
     wire	[`WordDataBus]			ex_out     	               ;
                                                                  
       //******************************************************mem????
     wire	[`WordDataBus]	mem_spm_rd_data        ;
	 wire					mem_spm_as_            ;
	 wire	[`WordAddrBus]	mem_spm_addr           ;
	 wire	[`WordDataBus]	mem_spm_wr_data        ;
	 wire					mem_spm_rw             ;
		                                               
	 wire	[`WordAddrBus]			mem_pc         ;     	        
 	 wire							mem_en         ;               
 	 wire							mem_br_flag    ;               
 	 wire	[`CtrlOpBus]			mem_ctrl_op    ;               
 	 wire	[`RegAddrBus]			mem_dst_addr   ;               
 	 wire							mem_gpr_we_    ;               
 	 wire	[`IsaExpBus]			mem_exp_code   ;               
 	 wire	[`WordDataBus]			mem_out     	;
 	
 	 //******************************************************ctrl????                

 //***************************************??????         
 	wire							if_busy                  ;
 	wire							mem_busy                 ;
 //*************************************** ????           
    wire							if_stall                 ;
    wire							id_stall                 ;
    wire							ex_stall                 ;
    wire							mem_stall                ;
 //*************************************** ????            
    wire							if_flush                 ;
    wire							id_flush                 ;
    wire							ex_flush                 ;
    wire							mem_flush                ;
      
if_top if_top0(        	
		.clk					(clk           			),
		.reset                  (reset                  ),
		.stall		            (if_stall		            ),
		.flush		            (if_flush		            ),
		.busy	                (if_busy	                ),
		.spm_rd_data            (if_spm_rd_data         ),
		.spm_as_                (if_spm_as_             ),
		.spm_addr               (if_spm_addr            ),
		.spm_wr_data            (if_spm_wr_data         ),
		.spm_rw                 (if_spm_rw              ),
		.bus_rd_data            (if_bus_rd_data         ),
		.bus_rdy_               (if_bus_rdy_            ),
		.bus_grnt_              (if_bus_grnt_           ),
		.bus_as_                (if_bus_as_             ),
		.bus_req_               (if_bus_req_            ),
		.bus_addr               (if_bus_addr            ),
		.bus_rw                 (if_bus_rw              ),
		.bus_wr_data            (if_bus_wr_data         ),                                                                               
    	.new_pc		            (new_pc		            ),
    	.br_taken	            (br_taken	            ),
    	.br_addr	            (br_addr	            ),                                             
		.if_en		            (if_en		            ),
		.if_pc	                (if_pc	                ),
		.if_insn	            (if_insn	            )

	);



id_top id_top0(
	 	.clk     		   		(clk     		   	),													
   	 	.reset   		   		(reset   		   	),												
   	 	.flush   		   		(id_flush   		   	),												
   	 	.stall   		   		(id_stall   		   	),												  						   			
     	.if_en                  (if_en              ), 
     	.if_pc                  (if_pc              ), 
     	.if_insn                (if_insn            ), 
     	.gpr_rd_data_0          (gpr_rd_data_0      ), 
     	.gpr_rd_data_1          (gpr_rd_data_1      ), 
     	.gpr_rd_addr_0          (gpr_rd_addr_0      ), 
     	.gpr_rd_addr_1          (gpr_rd_addr_1      ), 
     	.ex_en                  (ex_en              ), 
     	.ex_dst_addr            (ex_dst_addr        ), 
     	.ex_gpr_we_             (ex_gpr_we_         ), 
     	.ex_fwd_data	        (ex_fwd_data	    ),    	
     	.mem_fwd_data           (mem_fwd_data       ), 
     	.exe_mode		        (exe_mode		    ),	
     	.creg_rd_data	        (creg_rd_data	    ),	
     	.creg_rd_addr           (creg_rd_addr       ),
     	.br_taken               (br_taken           ),
     	.ld_hazard	            (ld_hazard	        ),
        .id_pc                  (id_pc              ), 
        .id_en                  (id_en              ),
     	.id_alu_op	            (id_alu_op	        ),
        .id_alu_in_0 	        (id_alu_in_0 	    ),
        .id_alu_in_1            (id_alu_in_1        ),
        .id_br_flag             (id_br_flag         ),
     	.id_mem_op              (id_mem_op          ),
        .id_mem_wr_data         (id_mem_wr_data     ),
        .id_ctrl_op             (id_ctrl_op         ),
        .id_dst_addr            (id_dst_addr        ),
        .id_gpr_we_		        (id_gpr_we_		    ),
        .id_exp_code            (id_exp_code        )
    
    );       

ex_top ex_top0(
			.clk   		    		(clk   				),        
    		.reset                  (reset              ),                                                
			.in_0                   (id_alu_in_0               ), 
  			.in_1                   (id_alu_in_1               ), 
    		.op                     (id_alu_op                 ),                                                       
    		.stall                  (ex_stall              ), 
    		.flush                  (ex_flush              ), 
    		.int_detect	    		(int_detect	    	),	   
    		.id_pc                  (id_pc              ), 
    		.id_en                  (id_en              ), 
    		.id_br_flag             (id_br_flag         ), 
    		.id_mem_op              (id_mem_op          ), 
    		.id_mem_wr_data         (id_mem_wr_data     ), 
    		.id_ctrl_op             (id_ctrl_op         ), 
    		.id_dst_addr            (id_dst_addr        ), 
    		.id_gpr_we_             (id_gpr_we_         ), 
    		.id_exp_code            (id_exp_code        ), 
    		.ex_pc                  (ex_pc              ), 
    		.ex_en                  (ex_en              ), 
    		.ex_br_flag             (ex_br_flag         ), 
    		.ex_mem_op              (ex_mem_op          ), 
    		.ex_mem_wr_data         (ex_mem_wr_data     ), 
    		.ex_ctrl_op             (ex_ctrl_op         ), 
    		.ex_dst_addr            (ex_dst_addr        ), 
    		.ex_gpr_we_             (ex_gpr_we_         ), 
    		.ex_exp_code            (ex_exp_code        ), 
    		.ex_out     	        (ex_out     	    ),    
    		.fwd_data		    	(ex_fwd_data		    )
    	
    	);	
    
mem_top mem_top0(
	.clk              		(clk            ),
	.reset	                (reset	        ),
	.stall		            (mem_stall		    ),
	.flush		            (mem_flush		    ),
	.busy		            (mem_busy		    ),
	.spm_rd_data            (mem_spm_rd_data    ),
	.spm_as_                (mem_spm_as_        ),
	.spm_addr               (mem_spm_addr       ),
	.spm_wr_data            (mem_spm_wr_data    ),
	.spm_rw                 (mem_spm_rw         ),
	.bus_rd_data            (mem_bus_rd_data    ),
	.bus_rdy_               (mem_bus_rdy_       ),
	.bus_grnt_              (mem_bus_grnt_      ),
	.bus_as_                (mem_bus_as_        ),
	.bus_req_               (mem_bus_req_       ),
	.bus_addr               (mem_bus_addr       ),
	.bus_rw                 (mem_bus_rw         ),
	.bus_wr_data            (mem_bus_wr_data    ),
	.ex_en                  (ex_en          ),       
    .ex_mem_op              (ex_mem_op      ),       
    .ex_mem_wr_data         (ex_mem_wr_data ),       
    .ex_out                 (ex_out         ),                                                                                                                                              	                                                                                
 	.ex_pc                  (ex_pc          ),                        
 	.ex_br_flag             (ex_br_flag     ),        
 	.ex_ctrl_op             (ex_ctrl_op     ),        
 	.ex_dst_addr            (ex_dst_addr    ),        
 	.ex_gpr_we_             (ex_gpr_we_     ),        
 	.ex_exp_code            (ex_exp_code    ),                    	                                                                       
 	.mem_pc               	(mem_pc         ),        
 	.mem_en                 (mem_en         ),        
 	.mem_br_flag            (mem_br_flag    ),        
 	.mem_ctrl_op            (mem_ctrl_op    ),        
 	.mem_dst_addr           (mem_dst_addr   ),        
 	.mem_gpr_we_            (mem_gpr_we_    ),        
 	.mem_exp_code           (mem_exp_code   ),        
 	.mem_out     	        (mem_out     	),
 	.fwd_data				(mem_fwd_data	)
 	
 	);
    
  ctrl ctrl0(
			.clk           			      (clk           	),             
    		.reset                  (reset          ),                                                                                
    		.creg_rd_addr           (creg_rd_addr   ),   
    		.creg_rd_data           (creg_rd_data   ),   
    		.exe_mode               (exe_mode       ),                       
    		.irq                    (irq            ),   
    		.int_detect             (int_detect     ),          
    		.id_pc                  (id_pc          ),      
    		.mem_pc                 (mem_pc         ),   
    		.mem_en                 (mem_en         ),   
    		.mem_br_flag            (mem_br_flag    ),   
    		.mem_ctrl_op            (mem_ctrl_op    ),   
    		.mem_dst_addr           (mem_dst_addr   ),   
    		.mem_gpr_we_            (mem_gpr_we_    ),   
    		.mem_exp_code           (mem_exp_code   ),   
    		.mem_out                (mem_out        ),               
    		.if_busy                (if_busy        ),   
    		.mem_busy               (mem_busy       ),   
    		.ld_hazard              (ld_hazard      ),                  
    		.if_stall               (if_stall       ),   
    		.id_stall               (id_stall       ),   
    		.ex_stall               (ex_stall       ),   
    		.mem_stall              (mem_stall      ),                  
    		.if_flush               (if_flush       ),   
    		.id_flush               (id_flush       ),   
    		.ex_flush               (ex_flush       ),   
    		.mem_flush              (mem_flush      ),   
    		.new_pc                 (new_pc         )
    		
    	);
    
    spm spm0(
 	     	.clk               	   (clkcounter         )		      ,                          
        .if_spm_addr           (if_spm_addr        )        ,
        .if_spm_as_            (if_spm_as_         )        ,      
        .if_spm_rw             (if_spm_rw          )        ,      
        .if_spm_rd_data        (if_spm_rd_data     )        ,
        .if_spm_wr_data        (if_spm_wr_data     )        ,
        .mem_spm_addr          (mem_spm_addr       )        ,
        .mem_spm_as_           (mem_spm_as_        )        ,      
        .mem_spm_rw            (mem_spm_rw         )        ,      
        .mem_spm_rd_data       (mem_spm_rd_data    )        ,
        .mem_spm_wr_data       (mem_spm_wr_data    )      
        
    );  
    gpr gpr0(
    	.clk      				(clk                  ),                      
    	.reset          		(reset                ),                
    	.rd_addr_0      		(gpr_rd_addr_0        ),        
    	.rd_data_0				(gpr_rd_data_0	       ),
    	.rd_addr_1      		(gpr_rd_addr_1        ),        
    	.rd_data_1      		(gpr_rd_data_1        ),                 
    	.we_            		(mem_gpr_we_          ),                
    	.wr_addr        		(mem_dst_addr         ),        
    	.wr_data        		(mem_out              )         
    	
    );                       
endmodule
                                                                     