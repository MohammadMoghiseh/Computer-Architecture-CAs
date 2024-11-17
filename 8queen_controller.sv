module eight_queen_fsm (
	input logic [2:0]clm_counter,
    	input logic clk,
    	input logic start,
    	input logic safe_or_not,
    	input logic clm_counter_carry,
    	input logic row_counter_carry,
    	input logic ccarry,
	output logic rst,
    	output logic rld_en,
    	output logic row_rst,
    	output logic update,
    	output logic fill_erase,
    	output logic up_count_en,
    	output logic down_count_en,
    	output logic sld_en,
    	output logic serase,
    	output logic ccount_rst,
    	output logic ccount_en,
    	output logic done,
	output logic rcount_en,
	output logic mld_en
);

    // Define the states
	parameter [3:0] IDLE=4'd0, INITIAL=4'd1, CHECK=4'd2,NOT_SAFE=4'd3, MEM_UPD=4'd4, NEXT_ROW=4'd5,COUNTER_UPDATE=4'd6, WAIT_1=4'd7, DONE=4'd8,SORT=4'd9, BACKTRACK=4'd10, S_DELETE=4'd11,BOARD_ERASE=4'd12, ROW_INC=4'd13, RC_UPDATE=4'd14,WAIT_2=4'd15;

    logic [3:0] state, next_state;

    // State transition logic
    always @(posedge clk ) begin
            state <= next_state;
    end

    // Next state and output logic
    always @(*) begin
        // Default values for outputs
        rld_en = 0;
        row_rst = 0;
        update = 0;
        fill_erase = 0;
        up_count_en = 0;
        down_count_en = 0;
        sld_en = 0;
        serase = 0;
        ccount_rst = 0;
        ccount_en = 0;
        done = 0;
	rst =0 ;
	rcount_en=0;
	mld_en=0;

        case (state)
            IDLE: begin
                if (start)
                    next_state = INITIAL;
                else
                    next_state = IDLE;
            end

            INITIAL: begin
                row_rst = 1;
		rst =1;
                next_state = CHECK;
            end

            CHECK: begin
                if (safe_or_not)
                    next_state = MEM_UPD;
                else
                    next_state = NOT_SAFE;
            end

            NOT_SAFE: begin
                if (row_counter_carry)
                    next_state = BACKTRACK;
                else
                    next_state = NEXT_ROW;
            end

            MEM_UPD: begin
                sld_en = 1;
                update = 1;
                fill_erase = 1;
                next_state = COUNTER_UPDATE;
            end

            NEXT_ROW: begin
                rcount_en = 1;
                next_state = CHECK;
            end

            COUNTER_UPDATE: begin
		row_rst=1;
		up_count_en=1;
                next_state = WAIT_1;
            end

            WAIT_1: begin
                if (clm_counter==3'b000)
                    next_state = DONE;
                else
                    next_state = CHECK;
            end

            DONE: begin
                done = 1;
                ccount_rst = 1;
                next_state = SORT;
            end

            SORT: begin
                ccount_en = 1;
                if (ccarry)
                    next_state = WAIT_2;
                else
                    next_state = SORT;
            end

            BACKTRACK: begin
                serase = 1;
                next_state = S_DELETE;
            end

            S_DELETE: begin
		mld_en = 1;
                next_state = RC_UPDATE;
            end

            BOARD_ERASE: begin
                fill_erase = 0;
                update = 1;
                if (row_counter_carry==1) 
			next_state = BACKTRACK;
		else
			next_state = ROW_INC;
			
            end

            ROW_INC: begin
                rcount_en = 1;
                next_state = CHECK;
            end

            RC_UPDATE: begin
                down_count_en = 1;
                rld_en = 1;
                next_state = BOARD_ERASE;
            end

            WAIT_2: begin
            	next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end
endmodule

