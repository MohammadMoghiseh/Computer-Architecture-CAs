`timescale 1ns/1ns
module eigth_queen_datapath(input clk,input row_rst,rld_en,rcount_en,rst,update,fill_erase,up_count_en,down_count_en,mld_en,sld_en,serase,ccounter_rst,ccounter_en,output logic[7:0]result,output logic ccarry,safe_or_not,row_carry,clm_carry,output logic [7:0]board[7:0],output logic [2:0]clm_counter);
	logic [5:0]ml_reg_out;
	logic [2:0]row_counter;
	logic [2:0]ccounter;
	logic [5:0]stack_out;
	logic [5:0]stack_in;
	safe_or_not_dd safe_instanse(row_counter,clm_counter ,board,safe_or_not);
	//row_counter_design:
	always@(posedge clk)begin
		if (row_rst==1) row_counter<=3'b000;
		else if(rld_en==1) row_counter<=ml_reg_out[5:3];
		else if(rcount_en==1) row_counter<=row_counter+1;
		else row_counter<=row_counter;
	end
	assign row_carry=(row_counter==3'b111)?1:0;
	//clm_counter_design:
	always@(posedge clk)begin
		if(rst==1) clm_counter<=3'b000;
		else if(up_count_en==1) clm_counter<=clm_counter+1;
		else if(down_count_en==1) clm_counter<=clm_counter-1;
		else clm_counter<=clm_counter;
	end
	assign clm_carry=(clm_counter==3'b111)?1:0;
	//ML_register_design:
	always@(posedge clk)begin
		if(rst==1) ml_reg_out<=3'b000;
		else if(mld_en==1) ml_reg_out<=stack_out;
		else ml_reg_out<=ml_reg_out;
	end
	//stack instansiation and connecting:
	assign stack_in={row_counter,clm_counter};
	stack8_6 stackk(clk,rst,sld_en,serase,stack_in,stack_out);
	//board instansiation:
	board_8_8 boardd(row_counter,clm_counter,clk,rst,update,fill_erase,board);
	//control_unit_counter_design:
	always@(posedge clk)begin
		if(ccounter_rst==1) ccounter<=3'd0;
		else if(ccounter_en==1) ccounter<=ccounter+1;
		else ccounter<=ccounter;
	end
	assign ccarry=(ccounter==3'b111)?1:0;
	//mux_for_put_on_output:
	always @(*) begin
       		case (ccounter)
          		3'b000: result = board[0];
          		3'b001: result = board[1];
         		3'b010: result = board[2];
          		3'b011: result = board[3];
           		3'b100: result = board[4];
           		3'b101: result = board[5];
           		3'b110: result = board[6];
         		3'b111: result = board[7];
        		default: result = board[1]; // Default case
      	  	endcase
    	end
endmodule
