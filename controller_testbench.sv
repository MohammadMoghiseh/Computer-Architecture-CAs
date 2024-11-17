`timescale 1ns/1ns

module eight_queen_fsm_tb;

    // Declare inputs as reg and outputs as wire
    logic clk;
    logic start;
    logic safe_or_not;
    logic clm_counter_carry;
    logic row_counter_carry;
    logic ccarry;
    logic rst;
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
    logic done;
    logic rcount_en;
    logic mld_en;

    // Instantiate the FSM module
    eight_queen_fsm uut (
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
        .mld_en(mld_en)
    );

    // Generate clock signal with a period of 10ns
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        start = 0;
        safe_or_not = 0;
        clm_counter_carry = 0;
        row_counter_carry = 0;
        ccarry = 0;

        // Display message
        $display("Starting testbench for eight_queen_fsm...");

        // Step 1: Activate start signal to enter INITIAL state
        #10 start = 1;
        #10 start = 0;
	#10 safe_or_not=1;clm_counter_carry=1;
        
        wait(done);
	#50 ccarry=1;
        // Display when done
        $display("FSM test completed.");

        // Finish simulation
        #100;
        $stop;
    end

    // Monitor outputs
    initial begin
        $monitor("Time: %0t | clk: %b | start: %b | safe_or_not: %b | clm_counter_carry: %b | row_counter_carry: %b | ccarry: %b | rst: %b | rld_en: %b | row_rst: %b | update: %b | fill_erase: %b | up_count_en: %b | down_count_en: %b | sld_en: %b | serase: %b | ccount_rst: %b | ccount_en: %b | done: %b | rcount_en: %b | mld_en: %b",
                 $time, clk, start, safe_or_not, clm_counter_carry, row_counter_carry, ccarry, rst, rld_en, row_rst, update, fill_erase, up_count_en, down_count_en, sld_en, serase, ccount_rst, ccount_en, done, rcount_en, mld_en);
    end

endmodule

