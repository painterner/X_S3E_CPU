
//`include "header/firstglobal.h"
//`include "header/cpuglobal.h"
//`include "header/bus.h"
module mem_reg(
	input wire							clk,
	input wire							reset,
	input wire							flush,
	input wire							stall,
	
	//*************************************内存访问结果
	input wire	[`WordDataBus]			out,
	input wire							miss_align,
		
	//*************************************EX/MEM流水线寄存器
    input wire	[`WordAddrBus]			ex_pc          ,     
    input wire							ex_en          ,     
    input wire							ex_br_flag     ,     
    input wire	[`CtrlOpBus]			ex_ctrl_op     ,     
    input wire	[`RegAddrBus]			ex_dst_addr    ,     
    input wire							ex_gpr_we_     ,     
    input wire	[`IsaExpBus]			ex_exp_code    ,    
	//*************************************MEM/WB流水线那寄存器
	
    output reg	[`WordAddrBus]			mem_pc          ,     	
    output reg							mem_en          ,     
    output reg							mem_br_flag     ,           
    output reg	[`CtrlOpBus]			mem_ctrl_op     ,     
    output reg	[`RegAddrBus]			mem_dst_addr    ,     
    output reg							mem_gpr_we_     ,     
    output reg	[`IsaExpBus]			mem_exp_code    , 
    output reg	[`WordDataBus]			mem_out    
	
);

	always @(posedge clk or `RESET_EDGE reset)
		if(reset == `RESET_ENABLE)	begin
			mem_pc    			 = `WORD_ADDR_W'H0;   
		    mem_en               = `DISABLE;
            mem_br_flag          = `DISABLE;
            mem_ctrl_op          = `CTRL_OP_NOP;
            mem_dst_addr         = `REG_ADDR_W'H0;
            mem_gpr_we_          = `DISABLE_;
            mem_exp_code         = `ISA_EXP_NO_EXP;
            mem_out              = `WORD_DATA_W'H0;
        end else
        	if(stall == `DISABLE)	
        		if(flush == `ENABLE)	begin
        		   mem_pc    			 = `WORD_ADDR_W'H0;          
                   mem_en               = `DISABLE;                   
                   mem_br_flag          = `DISABLE;                   
                   mem_ctrl_op          = `CTRL_OP_NOP;               
                   mem_dst_addr         = `REG_ADDR_W'H0;             
                   mem_gpr_we_          = `DISABLE_;                  
                   mem_exp_code         = `ISA_EXP_NO_EXP;            
                   mem_out              = `WORD_DATA_W'H0;   
                end else if(miss_align == `ENABLE)	begin
                	mem_pc    			 = ex_pc;        
                    mem_en               = ex_en;        
                    mem_br_flag          = ex_br_flag;   
                    mem_ctrl_op          = `CTRL_OP_NOP;             
                    mem_dst_addr         = `REG_ADDR_W'H0;           
                    mem_gpr_we_          = `DISABLE_;                
                    mem_exp_code         = `ISA_EXP_MISS_ALIGN;    			//      
                    mem_out              = `WORD_DATA_W'H0;   
                end else begin
                	mem_pc    			 = ex_pc    		 ;        
                    mem_en               = ex_en             ;    
                    mem_br_flag          = ex_br_flag        ;    
                    mem_ctrl_op          = ex_ctrl_op        ;    
                    mem_dst_addr         = ex_dst_addr       ;    
                    mem_gpr_we_          = ex_gpr_we_        ;    
                    mem_exp_code         = ex_exp_code       ;    
                    mem_out              = out               ; 
                end
                 
endmodule