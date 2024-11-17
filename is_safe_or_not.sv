module safe_or_not_dd(input [2:0]row_counter,clm_counter  ,input [7:0]board[7:0], output logic safe_or_not);
	integer i, j;
	integer m,n;
	logic conflict;
//is_safe_module_design:
	always @(*) begin
		conflict = 0;
		// Check the entire row for another queen
		for (m = 0; m < 8; m = m + 1) begin
			if (board[row_counter][m] == 1 && m != clm_counter) begin
				conflict = 1;
            		end	
		end
		// Check the entire column for another queen
		for (n = 0; n < 8; n = n + 1) begin
			if (board[n][clm_counter] == 1 && n != row_counter) begin
				conflict = 1;
			end
		end
		// Check all four diagonal directions
		// (1) Down-right diagonal
		m = row_counter; n = clm_counter;
		while (m < 8 && n < 8) begin
			if (board[m][n] == 1 && (m != row_counter || n != clm_counter)) conflict = 1;
			m = m + 1;
			n = n + 1;
		end
		// (2) Down-left diagonal
		m = row_counter; n = clm_counter;
		while (m < 8 && n >= 0) begin
			if (board[m][n] == 1 && (m != row_counter || n != clm_counter)) conflict = 1;
			m = m + 1;
			n = n - 1;
		end
		// (3) Up-right diagonal
		m = row_counter; n = clm_counter;
		while (m >= 0 && n < 8) begin
			if (board[m][n] == 1 && (m != row_counter || n != clm_counter)) conflict = 1;
			m = m - 1;
			n = n + 1;
		end
		// (4) Up-left diagonal
		m = row_counter; n = clm_counter;
		while (m >= 0 && n >= 0) begin
			if (board[m][n] == 1 && (m != row_counter || n != clm_counter)) conflict = 1;
			m = m - 1;
			n = n - 1;
		end
		safe_or_not = ~conflict;
	end
endmodule