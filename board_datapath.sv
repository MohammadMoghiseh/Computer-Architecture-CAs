`timescale 1ns/1ns
module board_8_8(input [2:0]row_counter,input [2:0]clm_counter,input clk,rst,update,fill_erase,output logic [7:0]board[7:0] );
	integer i,j;
	logic [7:0]temp_board[7:0];
	assign board=temp_board;
	always @(posedge clk) begin
		if (rst) begin
			for (i = 0; i < 8; i = i + 1) begin
				for (j = 0; j < 8; j = j + 1) begin
					temp_board[i][j] <= 1'b0; // Clear all cells
				end
			end
		end
		else if (update==1 && fill_erase==1 ) begin
			temp_board[row_counter][clm_counter] <= 1'b1;
		end
		else if(update==1 && fill_erase==0 ) begin
			temp_board[row_counter][clm_counter] <= 1'b0;
		end
	end
endmodule