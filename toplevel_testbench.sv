`timescale 1ns/1ns

module tb_eight_queen_top;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in ns

    // Testbench signals
    logic clk;
    logic start;
    logic [7:0] result;
    logic done;

    // Instantiate the top-level module
    eight_queen_top uut(
        .clk(clk),
        .start(start),
        .result(result),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk; // Toggle clock every half period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        start = 0;

        // Wait for a few clock cycles
        #(CLK_PERIOD * 5);

        // Start the algorithm
        start = 1;
        #(CLK_PERIOD); // Wait one clock cycle

        // Release start signal
        start = 0;

        // Wait for the algorithm to finish
        wait(done); // Wait until done signal is asserted

        // Display the result
        $display("Result: %b", result);

        // End the simulation after observing the output
        #(CLK_PERIOD * 10);
        $finish;
    end

endmodule

