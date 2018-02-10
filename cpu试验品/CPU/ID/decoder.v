`include "header/firstglobal.h"
`include "header/cpuglobal.h"
module decoder(
	//**************************IF/ID??????
	input wire						if_en,
	input wire	[`WordAddrBus]		if_pc,						//output?
	input wire	[`WordDataBus]		if_insn,						//output?
	
	//**************************GPR??
	input wire	[`WordDataBus]		gpr_rd_data_0,
	input wire	[`WordDataBus]		gpr_rd_data_1,
	output wire	[`RegAddrBus]		gpr_rd_addr_0,
	output wire [`RegAddrBus]		gpr_rd_addr_1,
	
	//**************************??ID???????
	input wire						id_en,
	input wire	[`RegAddrBus]		id_dst_addr,			//????
	input wire						id_gpr_we_,				//????
	input wire	[`MemOpBus]			id_mem_op,
	
	//**************************??EX???????,
	input wire						ex_en,
	input wire	[`RegAddrBus]		ex_dst_addr,
	input wire						ex_gpr_we_,
	input wire	[`WordDataBus]		ex_fwd_data,			//????
	
	//**************************??mem???????
	input wire	[`WordDataBus]		mem_fwd_data, 
	
	//**************************???????
	input wire						exe_mode,				//????
	input wire	[`WordDataBus]		creg_rd_data,			//???????
	output wire	[`RegAddrBus]		creg_rd_addr,
	
	//**************************????
	output reg	[`AluOpBus]			alu_op,
	output reg	[`WordDataBus]		alu_in_0,
	output reg	[`WordDataBus]		alu_in_1,
	output reg	[`WordAddrBus]		br_addr,
	output reg						br_taken,
	output reg						br_flag,
	output reg	[`MemOpBus]			mem_op,
	output reg	[`WordDataBus]		mem_wr_data,							//where from get this? 
	output reg	[`CtrlOpBus]		ctrl_op,
	output reg	[`RegAddrBus]		dst_addr,
	output reg						gpr_we_,
	output reg	[`IsaExpBus]		exp_code,
	output reg						ld_hazard				//load??

);

	//*************************????,??
	wire		[`IsaOpBus]			op			= if_insn[`IsaOpLoc];
	wire		[`RegAddrBus]		ra_addr		= if_insn[`IsaRaAddrLoc];
	wire		[`RegAddrBus]		rb_addr		= if_insn[`IsaRbAddrLoc];
	wire		[`RegAddrBus]		rc_addr		= if_insn[`IsaRcAddrLoc];
	wire		[`IsaImmBus]		imm			= if_insn[`IsaImmLoc];
	
	//*************************???
	wire		[`WordDataBus]		imm_s		= {{`ISA_EXT_W{imm[`ISA_IMM_MSB]}},imm};					//?????????
	wire		[`WordDataBus]		imm_u		= {{`ISA_EXT_W{1'b0}},imm};								//0???????
	
	//*************************???????????
	reg			[`WordDataBus]		ra_data	;														//Ra?????????????
	wire signed	[`WordDataBus]		s_ra_data	= $signed(ra_data);										//Ra?????????????
	reg			[`WordDataBus]		rb_data	;                											
	wire signed	[`WordDataBus]		s_rb_data	= $signed(rb_data);                                 	
	                                                                                                	
	assign gpr_rd_addr_0			= ra_addr;  														//?????????0           										    	
	assign gpr_rd_addr_1			= rb_addr;                                                      										
	assign creg_rd_addr				= ra_addr;                                                      	//?????????0
		                                                                                            	
		//*************************?????                         										
	wire		[`WordAddrBus]		ret_addr	= if_pc +1'b1;											//????
	wire		[`WordAddrBus]		br_target	= if_pc +imm_s[`WORD_ADDR_MSB:0];						//??????
	wire		[`WordAddrBus]		jr_target	= ra_data[`WordAddrLoc];								//??????
	
		//*************************??????
	always @ *	                           
		if((id_en == `ENABLE)&&(id_gpr_we_ == `ENABLE_)&&(id_dst_addr == ra_addr))
			ra_data				= ex_fwd_data;  
		else if((ex_en == `ENABLE)&&(ex_gpr_we_ == `ENABLE_)&&(ex_dst_addr == ra_addr))
			ra_data				= mem_fwd_data; 
		else                                    
			ra_data				= gpr_rd_data_0;
			
	always @ *	                           
		if((id_en == `ENABLE)&&(id_gpr_we_ == `ENABLE_)&&(id_dst_addr == rb_addr))
			rb_data				= ex_fwd_data;  
		else if((ex_en == `ENABLE)&&(ex_gpr_we_ == `ENABLE_)&&(ex_dst_addr == rb_addr))
			rb_data				= mem_fwd_data; 
		else                                    
		rb_data				= gpr_rd_data_1;
		
		//*************************Load????
	always @ *  
		if((id_en == `ENABLE)&&(id_mem_op == `MEM_OP_LDW)&&((id_dst_addr == ra_addr)||(id_dst_addr == rb_addr)))
			ld_hazard			= `ENABLE;
		else
			ld_hazard			= `DISABLE;
	
	always @ *	begin
		//*************************???????   
		alu_op				= `ALU_OP_NOP;
		alu_in_0			= ra_data;
		alu_in_1      		= rb_data;
		br_taken			= `DISABLE;
		br_flag				= `DISABLE;
		br_addr				={`WORD_ADDR_W{1'b0}};
		mem_op				= `MEM_OP_NOP;
		ctrl_op				= `CTRL_OP_NOP;
		dst_addr			= rb_addr;
		gpr_we_				= `DISABLE_;
		exp_code			= `ISA_EXP_NO_EXP;
		mem_wr_data			= `WORD_DATA_W'h0;									//after addition
	
	//*****************************??????
	 case(op)														
		//*************************??????
		`ISA_OP_ANDR	:	begin							//AND   初始值op为0，此时alu_op等于1
			alu_op				= `ALU_OP_AND;
			dst_addr			= rc_addr; 
			gpr_we_				= `ENABLE_;
		end                                
		`ISA_OP_ANDI	:	begin          
			alu_op				= `ALU_OP_AND;
			alu_in_1			= imm_u;   
			gpr_we_				= `ENABLE_;
		end
		`ISA_OP_ORR	:		begin							//OR
			alu_op				= `ALU_OP_OR;
			dst_addr			= rc_addr; 
			gpr_we_				= `ENABLE_;
		end                                
		`ISA_OP_ORI	:		begin       		   
			alu_op				= `ALU_OP_OR;
			alu_in_1			= imm_u;   
			gpr_we_				= `ENABLE_;	
		end
		`ISA_OP_XORR	:	begin							//XOR
			alu_op				= `ALU_OP_XOR;
			dst_addr			= rc_addr; 
			gpr_we_				= `ENABLE_;
		end                                
		`ISA_OP_XORI	:	begin          
			alu_op				= `ALU_OP_XOR;
			alu_in_1			= imm_u;   
			gpr_we_				= `ENABLE_;
		end
		
		//************************??????
		`ISA_OP_ADDSR	:	begin							//ADD
			alu_op				= `ALU_OP_ADDS;
			dst_addr			= rc_addr; 
			gpr_we_				= `ENABLE_;
		end                                
		`ISA_OP_ADDSI	:	begin          
			alu_op				= `ALU_OP_ADDS;
			alu_in_1			= imm_s;   
			gpr_we_				= `ENABLE_;	
		end                                
		`ISA_OP_ADDUR	:	begin
			alu_op				= `ALU_OP_ADDU;
			dst_addr			= rc_addr; 
			gpr_we_				= `ENABLE_;
		end                                
		`ISA_OP_ADDUI	:	begin          
			alu_op				= `ALU_OP_ADDU;
			alu_in_1			= imm_s;   
			gpr_we_				= `ENABLE_;
		end
		`ISA_OP_SUBSR	:	begin								//SUB
			alu_op				= `ALU_OP_SUBS;
			dst_addr			= rc_addr; 
			gpr_we_				= `ENABLE_;
		end
		`ISA_OP_SUBUR	:	begin
			alu_op				= `ALU_OP_SUBU;
			dst_addr			= rc_addr; 
			gpr_we_				= `ENABLE_;
		end  
		
		//************************??????    
		`ISA_OP_SHRLR	:	begin							//SHR
			alu_op				= `ALU_OP_SHRL;
			dst_addr			= rc_addr; 
			gpr_we_				= `ENABLE_;
		end                                
		`ISA_OP_SHRLI	:	begin          
			alu_op				= `ALU_OP_SHRL;
			alu_in_1			= imm_u;   
			gpr_we_				= `ENABLE_;
		end    
		`ISA_OP_SHLLR	:	begin							//SHL
			alu_op				= `ALU_OP_SHLL;
			dst_addr			= rc_addr; 
			gpr_we_				= `ENABLE_;
		end                                
		`ISA_OP_SHLLI	:	begin          
			alu_op				= `ALU_OP_SHLL;
			alu_in_1			= imm_u;   
			gpr_we_				= `ENABLE_;
		end       
		
		//************************????
		`ISA_OP_BE		:	begin							//== ??
			br_addr				= br_target;
			br_taken			= (ra_data == rb_data)?		`ENABLE : `DISABLE;
			br_flag				= `ENABLE;               
		end
		`ISA_OP_BNE		:	begin
			br_addr				= br_target;
			br_taken			= (ra_data != rb_data)?		`ENABLE : `DISABLE;
			br_flag				= `ENABLE;               
		end
		`ISA_OP_BSGT	:	begin						//< ??
			br_addr				= br_target;
			br_taken			= (s_ra_data < s_rb_data)?	`ENABLE : `DISABLE;
			br_flag				= `ENABLE;               
		end
		`ISA_OP_BUGT	:	begin
			br_addr				= br_target;
			br_taken			= (ra_data < rb_data)?		`ENABLE : `DISABLE;
			br_flag				= `ENABLE;               
		end
		`ISA_OP_JMP		:	begin						//?????
			br_addr				= jr_target;
			br_taken			= `ENABLE;
			br_flag				= `ENABLE;               
		end
		`ISA_OP_CALL	:	begin						//??
			alu_in_0			= {ret_addr,{`BYTE_OFFSET_W{1'b0}}};
			br_addr				= jr_target;
			br_taken			= `ENABLE;
			br_flag				= `ENABLE;
			dst_addr			= `REG_ADDR_W'd31;
			gpr_we_				= `ENABLE_;
		end
		
		//************************????????
		`ISA_OP_LDW		:	begin							
			alu_op				= `ALU_OP_ADDU;
			alu_in_1			= imm_s; 
			mem_op				= `MEM_OP_LDW;
			gpr_we_				= `ENABLE_;
		end                                
		`ISA_OP_STW		:	begin          
			alu_op				= `ALU_OP_ADDU;
			alu_in_1			= imm_s;   
			mem_op				= `MEM_OP_STW;
			mem_wr_data			= rb_data;									//after addition
		end
		
		//************************??????
		`ISA_OP_TRAP	:									//trap
			exp_code			= `ISA_EXP_TRAP;
		
		//************************????
		`ISA_OP_RDCR	:									//read control register
			if(exe_mode == `CPU_KERNEL_MODE) begin
				alu_in_0		= creg_rd_data;
				gpr_we_			= `ENABLE_;
			end else
				exp_code		= `ISA_EXP_PRV_VIO;
		`ISA_OP_WRCR	:									//write control register
			if(exe_mode == `CPU_KERNEL_MODE) 
				ctrl_op			= `CTRL_OP_WRCR;
			else
				exp_code		= `ISA_EXP_PRV_VIO;
		`ISA_OP_EXRT	:									//?????
			if(exe_mode == `CPU_KERNEL_MODE) 
				ctrl_op			= `CTRL_OP_EXRT;
			else
				exp_code		= `ISA_EXP_PRV_VIO;		
		
		//************************?????
		default			:
			exp_code			= `ISA_EXP_UNDEF_INSN;
	 endcase
	end
		


endmodule
			

	
	