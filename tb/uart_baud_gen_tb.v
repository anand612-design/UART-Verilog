`timescale 1ns/1ps
module baud_rate_tb;

reg clk;
reg rst;
wire tx_enb;
wire rx_enb;

baud_rate_gen uut (
    .clk(clk),
    .rst(rst),
    .tx_enb(tx_enb),
    .rx_enb(rx_enb)
);

initial clk = 0;
always #10 clk = ~clk;   

initial begin
    rst = 1;
    #50 rst = 0;          
end

initial begin
    $dumpfile("Baud_rate.vcd");
    $dumpvars(0, baud_rate_tb);
    #200000;
    $finish;
end

endmodule
