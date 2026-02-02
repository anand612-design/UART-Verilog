

`timescale 1ns/1ps

module uart_tx_tb;

    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;
    wire tx,rx,rx_done;
    wire tx_busy;
    wire [7:0] rx_data;
    uart_top dut (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );
   
    initial begin
      $dumpfile("uart.vcd");
      $dumpvars(0,uart_tx_tb);
    end
    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        rst = 1;
        tx_start = 0;
        tx_data = 8'h00;

        #50;
        rst = 0;

        #20;
        tx_data = 8'h55;
        tx_start = 1;
        #10;
        tx_start = 0;

        wait(tx_busy == 0);

        #100;
        tx_data = 8'hA3;
        tx_start = 1;
        #10;
        tx_start = 0;

        wait(tx_busy == 0);

        #200;
        $finish;
    end

endmodule
