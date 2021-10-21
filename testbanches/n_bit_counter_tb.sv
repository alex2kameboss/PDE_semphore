`timescale 1ns/1ps

module n_bit_counter_tb ();
    logic clk;
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end

    logic reset, start, done;

    initial begin
        reset = 1;
        start = 0;

        @(posedge clk);
        reset = 0;
        start = 1;
        @(posedge clk);
        start=0;
    end

    n_bit_counter u_cnt(.*);
endmodule