// Module: Baud Rate Generator
// Description: UART Baud Rate Generator (8N1)
// Author: Anand Ambadkar
// Date: January 2026



`timescale 1ns/1ps

module baud_rate_gen (
    input  wire clk,
    input  wire rst,
    output reg  tx_enb,
    output reg  rx_enb
);

   
    parameter TX_DIV = 5208;
    parameter RX_DIV = 325;

    reg [12:0] tx_counter;
    reg [9:0]  rx_counter;

    
    always @(posedge clk) begin
        if (rst) begin
            tx_counter <= 0;
            tx_enb     <= 0;
        end
        else if (tx_counter == TX_DIV-1) begin
            tx_counter <= 0;
            tx_enb     <= 1;   
        end
        else begin
            tx_counter <= tx_counter + 1;
            tx_enb     <= 0;
        end
    end

 
    always @(posedge clk) begin
        if (rst) begin
            rx_counter <= 0;
            rx_enb     <= 0;
        end
        else if (rx_counter == RX_DIV-1) begin
            rx_counter <= 0;
            rx_enb     <= 1;   
        end
        else begin
            rx_counter <= rx_counter + 1;
            rx_enb     <= 0;
        end
    end

endmodule 

