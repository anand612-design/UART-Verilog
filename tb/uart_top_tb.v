`timescale 1ns/1ps

module uart_top_tb;

    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;
    wire tx;
    wire tx_busy;
    wire [7:0] rx_data;
    wire rx_done;

    uart_top dut (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

    // Clock generation
    initial clk = 0;
    always #10 clk = ~clk;

   
    initial begin
        $dumpfile("uart.vcd");
        $dumpvars(0, uart_top_tb);
    end

 
    string message = "Hello UART";
    integer i;

    initial begin
        rst = 1;
        tx_start = 0;
        tx_data = 8'h00;

        #50 rst = 0;
        #50;

        
        for (i = 0; i < message.len(); i = i + 1) begin
            send_byte(message[i]);
        end

        #5000;
        $finish;
    end

    
    task send_byte(input [7:0] data);
        begin
            wait (tx_busy == 0);
            @(posedge clk);
            tx_data  = data;
            tx_start = 1;
            @(posedge clk);
            tx_start = 0;

            wait (rx_done == 1);
            $display("Time=%0t : Sent='%c' (0x%0h), Received='%c' (0x%0h)",
                     $time, data, data, rx_data, rx_data);
        end
    endtask

endmodule
