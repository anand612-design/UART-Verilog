// Module: UART Receiver
// Description: UART receiver (8N1)
// Author: Anand Ambadkar
// Date: January 2026



`timescale 1ns/1ps
module uart_rx (
    input  wire       clk,
    input  wire       rst,
    input  wire       rx_enb,
    input  wire       rx,
    output reg [7:0]  rx_data,
    output reg        rx_done
);

    localparam IDLE  = 2'd0;
    localparam START = 2'd1;
    localparam DATA  = 2'd2;
    localparam STOP  = 2'd3;

    reg [1:0] state;
    reg [3:0] sample_cnt;
    reg [2:0] bit_cnt;
    reg [7:0] shift_reg;

    always @(posedge clk) begin
        if (rst) begin
            state      <= IDLE;
            sample_cnt <= 0;
            bit_cnt    <= 0;
            shift_reg  <= 0;
            rx_data    <= 0;
            rx_done    <= 0;
        end else begin
            rx_done <= 0;
            if (rx_enb) begin
                case (state)

                    IDLE: begin
                        if (rx == 1'b0) begin
                            state      <= START;
                            sample_cnt <= 0;
                        end
                    end

                    START: begin
                        if (sample_cnt == 4'd7) begin
                            if (rx == 1'b0) begin
                                state      <= DATA;
                                sample_cnt <= 0;
                                bit_cnt    <= 0;
                            end else begin
                                state <= IDLE;
                            end
                        end else begin
                            sample_cnt <= sample_cnt + 1;
                        end
                    end

                    DATA: begin
                        if (sample_cnt == 4'd15) begin
                            sample_cnt <= 0;
                            shift_reg  <= {rx, shift_reg[7:1]};
                            if (bit_cnt == 3'd7)
                                state <= STOP;
                            else
                                bit_cnt <= bit_cnt + 1;
                        end else begin
                            sample_cnt <= sample_cnt + 1;
                        end
                    end

                    STOP: begin
                        if (sample_cnt == 4'd15) begin
                            state      <= IDLE;
                            rx_data    <= shift_reg;
                            rx_done    <= 1'b1;
                            sample_cnt <= 0;
                        end else begin
                            sample_cnt <= sample_cnt + 1;
                        end
                    end

                    default: state <= IDLE;

                endcase
            end
        end
    end

endmodule
