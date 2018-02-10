`include "header/firstglobal.h"      
`include "header/cpuglobal.h" 
`include "header/ioglobal.h"         
module chip(
	input wire							clk         ,                                   
	input wire							clkcounter	,						         
	input wire							reset	    ,                                   
	//******************************************************rx && tx data     
    input wire							rx       	,                        
    output wire							tx          ,                         
	input wire	[`GPIO_IN_CH-1:0]		gpio_in     ,       
	output wire	[`GPIO_OUT_CH-1:0]		gpio_out    ,       
	inout wire	[`GPIO_IO_CH-1:0]		gpio_io             
		
);          

	//******************************************************cpu内部信号
	wire					if_bus_grnt_        ;                    	
	wire					if_bus_as_          ;                    
	wire					if_bus_req_         ;                    
	wire	[`WordAddrBus]	if_bus_addr         ;                    
	wire					if_bus_rw           ;                    
	wire	[`WordDataBus]	if_bus_wr_data      ;                    
    wire					mem_bus_grnt_       ;                    
    wire					mem_bus_as_         ;                    
    wire					mem_bus_req_        ;                    
    wire	[`WordAddrBus]	mem_bus_addr        ;                    
    wire					mem_bus_rw          ;                    
    wire	[`WordDataBus]	mem_bus_wr_data     ;                    
    wire	[`CpuIrqBus]			irq         ;
   //**************************************************bus内部信号
    wire					m0_req_				;
	wire					m1_req_             ;
	wire					m2_req_				= `DISABLE_  ;
	wire					m3_req_				= `DISABLE_  ;
	wire					m0_grnt_		    ;
	wire					m1_grnt_            ;
	wire					m2_grnt_            ;
	wire 					m3_grnt_            ;
	wire	[`WordAddrBus]	m0_addr             ;
	wire					m0_as_              ;
	wire					m0_rw               ;
	wire	[`WordDataBus]	m0_wr_data          ;
	wire	[`WordAddrBus]	m1_addr             ;
	wire					m1_as_              ;
	wire					m1_rw               ;
	wire	[`WordDataBus]	m1_wr_data          ;
	wire	[`WordAddrBus]	m2_addr				= `WORD_ADDR_W'h0  ;
	wire					m2_as_				= `DISABLE_        ;
	wire					m2_rw				= `READ            ;
	wire	[`WordDataBus]	m2_wr_data			= `WORD_DATA_W'h0  ;
	wire	[`WordAddrBus]	m3_addr				= `WORD_ADDR_W'h0  ;
	wire					m3_as_              = `DISABLE_        ;
	wire					m3_rw               = `READ            ;
	wire	[`WordDataBus]	m3_wr_data          = `WORD_DATA_W'h0  ;
	wire					s0_cs_		        ;
	wire					s1_cs_              ;
	wire					s2_cs_			    ;
	wire					s3_cs_			    ;
	wire					s4_cs_              ;
	wire					s5_cs_              ;
	wire					s6_cs_              ;
	wire					s7_cs_              ;
	wire	[`WordAddrBus] 	s_addr              ;
	wire					s_as_               ;
	wire					s_rw                ;
	wire	[`WordDataBus]	s_wr_data           ;
	wire	[`WordDataBus]	s0_rd_data          ;
	wire					s0_rdy_             ;
	wire	[`WordDataBus]	s1_rd_data          ;
	wire					s1_rdy_             ;
	wire	[`WordDataBus]	s2_rd_data          ;
	wire					s2_rdy_             ;
	wire	[`WordDataBus]	s3_rd_data          ;
	wire					s3_rdy_             ;
	wire	[`WordDataBus]	s4_rd_data          ;
	wire					s4_rdy_             ;
	wire	[`WordDataBus]	s5_rd_data			= `WORD_DATA_W'h0      ;
	wire					s5_rdy_				= `DISABLE_            ;
	wire	[`WordDataBus]	s6_rd_data         	= `WORD_DATA_W'h0      ;
	wire					s6_rdy_            	= `DISABLE_            ;
	wire	[`WordDataBus]	s7_rd_data			= `WORD_DATA_W'h0      ;
	wire					s7_rdy_             = `DISABLE_            ;
	wire	[`WordDataBus]	m_rd_data			;
	wire					m_rdy_              ;
	
	 cpu_top cpu_top0(                                                        
		.clk                     ( clk             )    ,                            
		.clkcounter				 ( clkcounter	   )	,			   
		.reset	                 ( reset	       )    ,                                                               
		.if_bus_rd_data			 ( m_rd_data	   )	,		      
		.if_bus_rdy_             ( m_rdy_          )    ,               
		.if_bus_grnt_            ( m0_grnt_        )    ,                
		.if_bus_as_              ( m0_as_          )    ,                
		.if_bus_req_             ( m0_req_         )    ,                
		.if_bus_addr             ( m0_addr         )    ,                
		.if_bus_rw               ( m0_rw           )    ,                
		.if_bus_wr_data          ( m0_wr_data      )    ,                                         
   		.mem_bus_rd_data         ( m_rd_data       )    ,		      
		.mem_bus_rdy_            ( m_rdy_          )    ,              
    	.mem_bus_grnt_           ( m1_grnt_        )    ,               
    	.mem_bus_as_             ( m1_as_          )    ,               
    	.mem_bus_req_            ( m1_req_         )    ,               
    	.mem_bus_addr            ( m1_addr         )    ,               
    	.mem_bus_rw              ( m1_rw           )    ,               
    	.mem_bus_wr_data         ( m1_wr_data      )    ,                                          
    	.irq                     ( irq             )                                   
                                                                                          
	);          
	                                                                       
	 bus_top bus_top0(
		.clk                   (clk              )		,
		.reset                 (reset            )      ,
		.m0_req_               (m0_req_          )      ,
		.m1_req_               (m1_req_          )      ,
		.m2_req_               (m2_req_          )      ,
		.m3_req_               (m3_req_          )      ,
		.m0_grnt_		       (m0_grnt_		 )      ,
		.m1_grnt_              (m1_grnt_         )      ,
		.m2_grnt_              (m2_grnt_         )      ,
		.m3_grnt_              (m3_grnt_         )      ,
		.m0_addr               (m0_addr          )      ,
		.m0_as_                (m0_as_           )      ,
		.m0_rw                 (m0_rw            )      ,
		.m0_wr_data            (m0_wr_data       )      ,
		.m1_addr               (m1_addr          )      ,
		.m1_as_                (m1_as_           )      ,
		.m1_rw                 (m1_rw            )      ,
		.m1_wr_data            (m1_wr_data       )      ,
		.m2_addr               (m2_addr          )      ,
		.m2_as_                (m2_as_           )      ,
		.m2_rw                 (m2_rw            )      ,
		.m2_wr_data            (m2_wr_data       )      ,
		.m3_addr               (m3_addr          )      ,
		.m3_as_                (m3_as_           )      ,
		.m3_rw                 (m3_rw            )      ,
		.m3_wr_data            (m3_wr_data       )      ,
		.s0_cs_		           (s0_cs_		     )      ,
		.s1_cs_                (s1_cs_           )      ,
		.s2_cs_                (s2_cs_           )      ,
		.s3_cs_                (s3_cs_           )      ,
		.s4_cs_                (s4_cs_           )      ,
		.s5_cs_                (s5_cs_           )      ,
		.s6_cs_                (s6_cs_           )      ,
		.s7_cs_                (s7_cs_           )      ,
		.s_addr                (s_addr           )      ,
		.s_as_                 (s_as_            )      ,
		.s_rw                  (s_rw             )      ,
		.s_wr_data             (s_wr_data        )      ,
		.s0_rd_data            (s0_rd_data       )      ,
		.s0_rdy_               (s0_rdy_          )      ,
		.s1_rd_data            (s1_rd_data       )      ,
		.s1_rdy_               (s1_rdy_          )      ,
		.s2_rd_data            (s2_rd_data       )      ,
		.s2_rdy_               (s2_rdy_          )      ,
		.s3_rd_data            (s3_rd_data       )      ,
		.s3_rdy_               (s3_rdy_          )      ,
		.s4_rd_data            (s4_rd_data       )      ,
		.s4_rdy_               (s4_rdy_          )      ,
		.s5_rd_data            (s5_rd_data       )      ,
		.s5_rdy_               (s5_rdy_          )      ,
		.s6_rd_data            (s6_rd_data       )      ,
		.s6_rdy_               (s6_rdy_          )      ,
		.s7_rd_data            (s7_rd_data       )      ,
		.s7_rdy_               (s7_rdy_          )      ,
		.m_rd_data             (m_rd_data        )      ,
		.m_rdy_                (m_rdy_           )      
	);

	 rom rom0(                                                                                                        
		.clk        			 (clk               )	,
		.reset            	     (reset             ) 	,                  
		.cs_                     (s0_cs_            )   ,
		.as_                     (s_as_             )   ,
		.addr                    (s_addr            )   ,
		.rd_data                 (s0_rd_data        )   ,
		.rdy_                    (s0_rdy_           )   
	); 

	 timer timer0(
		.clk                    (clk  			 	) 	, 
		.reset	                (reset	         	)   ,
		.cs_                    (s2_cs_          	)   ,
		.as_                    (s_as_           	)   ,
		.rw                     (s_rw            	)   ,
		.addr                   (s_addr          	)   ,
		.wr_data                (s_wr_data       	)   ,
		.rd_data                (s2_rd_data      	)   ,
		.rdy_                   (s2_rdy_         	)   ,
		.irq                    (irq[0]          	)   
	                                             	
	); 

	uart_top uart_top0(                                                                 
		.clk			 		 (clk			    )  	,                        
		.reset                   (reset             )   ,                      
		.as_                     (s_as_             )   ,           
		.cs_                     (s3_cs_            )   ,            
		.rw                      (s_rw              )   ,           
		.addr					 (s_addr			)   ,
		.wr_data                 (s_wr_data         )   ,           
		.rd_data                 (s3_rd_data        )   ,            
		.rdy_                    (s3_rdy_           )   ,                             
		.irq_tx                  (irq[1]            )   ,         
		.irq_rx                  (irq[2]            )   ,                
		.rx       	             (rx       	    	)   ,         
		.tx                      (tx                )           
	                                                                             
	);  

	 gpio gpio0(
		.clk				   (clk        			)	,			
		.reset                 (reset             	)   ,
		.cs_                   (s4_cs_              )   ,
		.as_                   (s_as_               )   ,
		.rw                    (s_rw                )   ,
		.addr                  (s_addr              )   ,
		.wr_data               (s_wr_data           )   ,
		.rd_data               (s4_rd_data          )   ,
		.rdy_                  (s4_rdy_             )   ,
		.gpio_in               (gpio_in             )   ,
		.gpio_out              (gpio_out            )   ,
		.gpio_io               (gpio_io             )   
	);  
	
endmodule                                 