
//*******************************else ????????
//`include "header/firstglobal.h"
//`include "header/cpuglobal.h"
//`include "header/bus.h"
module bus_if(
	input wire			clk,
	input wire			reset,
	
	//***********************???????
	input wire			stall,		//????
	input wire			flush,		//????
	output reg			busy,		//?????
	
	//***********************CPU??
	input wire	[`WordAddrBus]	addr,
	input wire			rw,
	input wire			as_,
	input wire	[`WordDataBus]	wr_data,
	output reg	[`WordDataBus]	rd_data,

	//***********************SPM??
	input wire	[`WordDataBus]	spm_rd_data,    
	output reg			spm_as_,
	output wire	[`WordAddrBus]	spm_addr,
	output wire	[`WordDataBus]	spm_wr_data,
	output wire			spm_rw,

	//***********************????
	input wire	[`WordDataBus]	bus_rd_data,
	input wire			bus_rdy_,
	input wire			bus_grnt_,
	output reg			bus_as_,
	output reg			bus_req_,
	output reg	[`WordAddrBus]	bus_addr,
	output reg			bus_rw,
	output reg	[`WordDataBus]	bus_wr_data
);

	reg	[`BusIfStateBus]	state;
	reg	[`WordDataBus]		rd_buf;
	wire	[`BusSlaveIndexBus]	s_index;
	
	//*******************************????????
	assign s_index		= addr[`BusSlaveIndexLoc];

	//*******************************????
	assign spm_addr		= addr;
	assign spm_rw		= rw;
	assign spm_wr_data	= wr_data;

		//*********************???????
	always @ *	begin
		//*****************???
		rd_data		= `WORD_DATA_W'b0;
		spm_as_		= `DISABLE_;
		busy		= `DISABLE;
		
		//*****************??????
		case(state)
			`BUS_IF_STATE_IDLE	: 					//??
				if((flush == `DISABLE)&&(as_ == `ENABLE_))		//??????
					if(s_index == `BUS_SLAVE_1)	 begin		//?? SPM
						if(stall == `DISABLE)	begin		//???
							spm_as_ = `ENABLE_;		
							if(rw == `READ)			//????
								rd_data	= spm_rd_data;
						end
					end else
						busy	= `ENABLE;
			`BUS_IF_STATE_REQ		:
						busy	= `ENABLE;

			`BUS_IF_STATE_ACCESS	:					//????
				//**********************??????
				if (bus_rdy_ == `ENABLE_)	begin
					if (rw == `READ)
						rd_data = bus_rd_data;
						
				end else
					busy	= `ENABLE;

			`BUS_IF_STATE_STALL 	:
				if (rw == `READ)
					rd_data	= rd_buf;
		endcase
	end
	
		//*********************????????
	always @ (posedge clk or `RESET_EDGE reset)	
		if (reset	== `RESET_ENABLE) begin
			state		<= #1 `BUS_IF_STATE_IDLE;
			bus_req_	<= #1 `DISABLE_;
			bus_addr	<= #1 `WORD_ADDR_W'H0;
			bus_as_		<= #1 `DISABLE_;
			bus_rw		<= #1 `READ;
			bus_wr_data	<= #1 `WORD_ADDR_W'h0;
			rd_buf		<= #1 `WORD_DATA_W'H0;
		end	 else
			case(state)
				`BUS_IF_STATE_IDLE	:	
					if((flush	== `DISABLE)&&(as_	== `ENABLE_))
						if(s_index	!= `BUS_SLAVE_1)	begin
							state			<= #1 `BUS_IF_STATE_REQ;
							bus_req_		<= #1 `ENABLE_;
							bus_addr		<= #1 addr;
							bus_rw			<= #1 rw;
							bus_wr_data	    <= #1 wr_data;
						end
						
				`BUS_IF_STATE_REQ	:
					if(bus_grnt_	== `ENABLE_)	begin          //只有仲裁通过才能写数据，才能让as_信号有效。
						state			<= #1 `BUS_IF_STATE_ACCESS;
						bus_as_			<= #1 `ENABLE_;
					end
				
				`BUS_IF_STATE_ACCESS	:	begin
					bus_as_			<= #1	`DISABLE_;
					if(bus_rdy_ 	== `ENABLE_) begin
						bus_req_	<= #1	`DISABLE_;
						bus_addr	<= #1 `WORD_ADDR_W'h0;
						bus_rw		<= #1 `READ;
						bus_wr_data	<= #1 `WORD_ADDR_W'h0;					
						if(bus_rw	==`READ)
							rd_buf			<= #1 bus_rd_data;
						if(stall	==`ENABLE)
							state			<=#1 `BUS_IF_STATE_STALL;
						else
							state			<=#1 `BUS_IF_STATE_IDLE;	
					end
					
				end
					
				`BUS_IF_STATE_STALL		:	
					if(stall == `DISABLE) 	begin						//解除等待（等待其主控他总线访问）
					state				<= #1 `BUS_IF_STATE_IDLE;
					end
		endcase
	

endmodule


	//失误原因：1 access阶段少了begin，end
	//			2 stall阶段少了解除等待的if语句
	//解决启发由来：在波形图上比较if与mem阶段的bus_if模块波形，思考可得。
								

	



	
				
					
		


















































