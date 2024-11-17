`timescale 1ns/1ns

module eight_queen_top (
    input logic clk,
    input logic start,
    output logic [7:0] result,
    output logic done
);

    // Wires for interconnecting the FSM and datapath
    logic rst;
    logic [2:0]clm_counter;
    logic rld_en;
    logic row_rst;
    logic update;
    logic fill_erase;
    logic up_count_en;
    logic down_count_en;
    logic sld_en;
    logic serase;
    logic ccount_rst;
    logic ccount_en;
    logic rcount_en;
    logic mld_en;
    logic safe_or_not;
    logic clm_counter_carry;
    logic row_counter_carry;
    logic ccarry;
    logic [7:0]board[7:0];

    // Instantiate the FSM controller
    eight_queen_fsm controller (
        .clk(clk),
        .start(start),
        .safe_or_not(safe_or_not),
        .clm_counter_carry(clm_counter_carry),
        .row_counter_carry(row_counter_carry),
        .ccarry(ccarry),
        .rst(rst),
        .rld_en(rld_en),
        .row_rst(row_rst),
        .update(update),
        .fill_erase(fill_erase),
        .up_count_en(up_count_en),
        .down_count_en(down_count_en),
        .sld_en(sld_en),
        .serase(serase),
        .ccount_rst(ccount_rst),
        .ccount_en(ccount_en),
        .done(done),
        .rcount_en(rcount_en),
        .mld_en(mld_en),
	.clm_counter(clm_counter)
    );

    // Instantiate the datapath
    eigth_queen_datapath datapath (
        .clk(clk),
        .row_rst(row_rst),
        .rld_en(rld_en),
        .rcount_en(rcount_en),
        .rst(rst),
        .update(update),
        .fill_erase(fill_erase),
        .up_count_en(up_count_en),
        .down_count_en(down_count_en),
        .mld_en(mld_en),
        .sld_en(sld_en),
        .serase(serase),
        .ccounter_rst(ccount_rst),
        .ccounter_en(ccount_en),
        .result(result),
        .ccarry(ccarry),
        .safe_or_not(safe_or_not),
        .row_carry(row_counter_carry),
        .clm_carry(clm_counter_carry),
	.board(board),
	.clm_counter(clm_counter)
    );

endmodule

