
//Module: UART Transmitter
//Description: UART transmitter (8N1) 
//Author: Anand Ambadkar
//Date: January 2026

`timescale 1ns/1ps

module uart_tx (
    input  wire       clk,
    input  wire       rst,
    input  wire       tx_enb,      
    input  wire       tx_start,    
    input  wire [7:0] tx_data,     
    output reg        tx,           
    output reg        tx_busy       
);

    
    localparam IDLE  = 2'd0;
    localparam START = 2'd1;
    localparam DATA  = 2'd2;
    localparam STOP  = 2'd3;

    reg [1:0] state;
    reg [2:0] bit_cnt;              
    reg [7:0] shift_reg;

    
    always @(posedge clk) begin
        if (rst) begin
            state     <= IDLE;
            tx        <= 1'b1;       
            tx_busy  <= 1'b0;
            bit_cnt  <= 3'd0;
            shift_reg <= 8'd0;
        end
        else begin
            case (state)

                
                IDLE: begin
                    tx       <= 1'b1;
                    tx_busy <= 1'b0;
                    if (tx_start) begin
                        shift_reg <= tx_data;
                        state     <= START;
                        tx_busy  <= 1'b1;
                    end
                end

                
                START: begin
                    if (tx_enb) begin
                        tx    <= 1'b0;   
                        state <= DATA;
                        bit_cnt <= 3'd0;
                    end
                end

                
                DATA: begin
                    if (tx_enb) begin
                        tx        <= shift_reg[0];
                        shift_reg <= shift_reg >> 1;
                        if (bit_cnt == 3'd7)
                            state <= STOP;
                        else
                            bit_cnt <= bit_cnt + 1'b1;
                    end
                end

                
                STOP: begin
                    if (tx_enb) begin
                        tx    <= 1'b1;   
                        state <= IDLE;
                    end
                end

                default: state <= IDLE;

            endcase
        end
    end

endmodule