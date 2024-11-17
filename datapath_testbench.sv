`timescale 1ns/1ns
module board_tb;
    // Testbench signals
    logic clk;
    logic rst;
    logic [7:0]board[7:0];
    logic [2:0]row_counter,clm_counter;
    logic update,fill_erase;
    //instansiation:
    board_8_8 sut(
	.clk(clk),
	.rst(rst),
	.clm_counter(clm_counter),
	.row_counter(row_counter),
	.update(update),
	.fill_erase(fill_erase)
     );
	//Generate clock signal with a period of 10ns
    always #5 clk = ~clk;
    // Testbench process
    initial begin
        clk = 0;
        #15;

        rst=1;
	#10;
	rst=0;
        #15;
	//we play:
	row_counter=3'b000;
	clm_counter=3'b000;
	update=1;
	#10;
	fill_erase=1;
	#10;
	update=0;
	#10;
	fill_erase=0;
	#10;
	
	//play again:
	row_counter=3'd5;
	clm_counter=3'd7;
	update=1;
	#10;
	fill_erase=1;
	#10;
	update=0;
	#10;
	fill_erase=0;
	#10;

	//lets erease something:
	row_counter=3'b000;
	clm_counter=3'b000;
	update=1;
	#10;
	fill_erase=0;
	#10;
	update=0;
	#10;
	fill_erase=1;
	#10;
	fill_erase=0;
	#25;
        $stop;
    end
endmodule

