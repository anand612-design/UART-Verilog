// Module: UART Module
// Description: UART top module (8N1)
// Author: Anand Ambadkar
// Date: January 2026


`timescale 1ns/1ps

module uart_top (
    input  wire       clk,
    input  wire       rst,
    input  wire       tx_start,
    input  wire [7:0] tx_data,
    output wire       tx,
    output wire       tx_busy,
    output wire [7:0] rx_data,
    output wire       rx_done
);

    wire tx_enb;
    wire rx_enb;

    baud_rate_gen baud_inst (
        .clk    (clk),
        .rst    (rst),
        .tx_enb (tx_enb),
        .rx_enb (rx_enb)
    );

    uart_tx tx_inst (
        .clk      (clk),
        .rst      (rst),
        .tx_enb   (tx_enb),
        .tx_start (tx_start),
        .tx_data  (tx_data),
        .tx       (tx),
        .tx_busy  (tx_busy)
    );

    uart_rx rx_inst (
        .clk     (clk),
        .rst     (rst),
        .rx_enb  (rx_enb),
        .rx      (tx),       
        .rx_data (rx_data),
        .rx_done (rx_done)
    );

endmodule